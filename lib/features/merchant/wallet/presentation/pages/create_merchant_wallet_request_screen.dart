import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../shared/widgets/attachments/attachment_source_sheet.dart';
import '../../../../../shared/widgets/forms/withdraw_note_composer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/documents/document_file_picker.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../manager/create_wallet_request_cubit.dart';
import '../manager/create_wallet_request_state.dart';
import '../widgets/wallet_request_form_fields.dart';

class CreateMerchantWalletRequestScreen extends StatefulWidget {
  const CreateMerchantWalletRequestScreen({super.key});

  @override
  State<CreateMerchantWalletRequestScreen> createState() =>
      _CreateMerchantWalletRequestScreenState();
}

class _CreateMerchantWalletRequestScreenState
    extends State<CreateMerchantWalletRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _withdrawAccountController = TextEditingController();
  WalletRequestType _type = WalletRequestType.deposit;
  String? _filePath;
  int? _transferAccountId;
  bool _showTransferAccountError = false;

  @override
  void initState() {
    super.initState();
    context.read<CreateWalletRequestCubit>().loadTransferAccounts();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _withdrawAccountController.dispose();
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
    final cubit = context.read<CreateWalletRequestCubit>();
    final requiresTransferAccount = cubit.state.transferAccounts.isNotEmpty;

    setState(() {
      _showTransferAccountError = requiresTransferAccount && _transferAccountId == null;
    });

    if (!_formKey.currentState!.validate() || _showTransferAccountError) return;

    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    final note = _noteController.text.trim();

    final withdrawAccount = _withdrawAccountController.text.trim();

    final confirmed = await showConfirmDialog(
      context,
      title: _type == WalletRequestType.deposit
          ? S().confirmWalletRequestDepositTitle
          : S().confirmWalletRequestWithdrawTitle,
      message: S().confirmWalletRequestMessage(S().currencyEgp(amount)),
      confirmLabel: _type == WalletRequestType.deposit
          ? S().walletRequestTypeDeposit
          : S().walletRequestTypeWithdraw,
      icon: Icons.account_balance_wallet_outlined,
      isDestructive: _type == WalletRequestType.withdraw,
    );
    if (!confirmed || !mounted) return;

    final created = await cubit.submit(
      type: _type,
      amount: amount,
      transferAccountId: _transferAccountId,
      note: WithdrawNoteComposer.compose(note: note, account: withdrawAccount),
      filePath: _type == WalletRequestType.deposit ? _filePath : null,
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
        child: BlocBuilder<CreateWalletRequestCubit, CreateWalletRequestState>(
          builder: (context, state) => ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              WalletRequestFormFields(
                amountController: _amountController,
                noteController: _noteController,
                withdrawAccountController: _withdrawAccountController,
                type: _type,
                onTypeChanged: (type) => setState(() => _type = type),
                filePath: _filePath,
                onPickAttachment: _pickAttachment,
                transferAccounts: state.transferAccounts,
                selectedTransferAccountId: _transferAccountId,
                onTransferAccountChanged: (id) => setState(() {
                  _transferAccountId = id;
                  _showTransferAccountError = false;
                }),
                showTransferAccountError: _showTransferAccountError,
              ),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: S().submitWalletRequest,
                isLoading: state.status == CreateWalletRequestStatus.submitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
