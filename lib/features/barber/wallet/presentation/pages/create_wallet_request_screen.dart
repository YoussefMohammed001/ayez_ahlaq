import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../shared/widgets/attachments/attachment_source_sheet.dart';
import '../../../../../generated/l10n.dart';
import '../../../documents/presentation/helpers/document_file_picker.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../manager/create_wallet_request_cubit.dart';
import '../manager/create_wallet_request_state.dart';
import '../widgets/wallet_request_form_fields.dart';

class CreateWalletRequestScreen extends StatefulWidget {
  const CreateWalletRequestScreen({super.key});

  @override
  State<CreateWalletRequestScreen> createState() =>
      _CreateWalletRequestScreenState();
}

class _CreateWalletRequestScreenState extends State<CreateWalletRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  WalletRequestType _type = WalletRequestType.deposit;
  String? _filePath;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachment() async {
    final source = await AttachmentSourceSheet.show(context, allowFiles: false);
    if (source == null) return;

    final picked = await DocumentFilePicker.pick(source);
    if (picked == null) return;

    if (picked.exceedsMaxSize) {
      showError(S().documentTooLarge(DocumentFilePicker.maxSizeInMB));
      return;
    }

    if (picked.isUnsupportedType) {
      showError(S().documentUnsupportedType);
      return;
    }

    setState(() => _filePath = picked.path);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<CreateWalletRequestCubit>();
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    final note = _noteController.text.trim();

    final created = await cubit.submit(
      type: _type,
      amount: amount,
      note: note.isEmpty ? null : note,
      filePath: _filePath,
    );

    if (!mounted) return;

    if (created) {
      showSuccess(S().walletRequestCreatedSuccess);
      context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().createWalletRequestTitle),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            WalletRequestFormFields(
              amountController: _amountController,
              noteController: _noteController,
              type: _type,
              onTypeChanged: (type) => setState(() => _type = type),
              filePath: _filePath,
              onPickAttachment: _pickAttachment,
            ),
            SizedBox(height: 20.h),
            BlocBuilder<CreateWalletRequestCubit, CreateWalletRequestState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().submitWalletRequest,
                isLoading: state.status == CreateWalletRequestStatus.submitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
