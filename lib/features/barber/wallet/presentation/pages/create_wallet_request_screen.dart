import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../../../shared/widgets/documents/pick_attachment_flow.dart';
import '../../../../../shared/wallet/domain/entities/wallet_request_type.dart';
import '../../../../../shared/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../../../../../shared/wallet/presentation/manager/create_wallet_request_state.dart';
import '../widgets/wallet_request_form_fields.dart';
import '../widgets/wallet_request_submit_button.dart';

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
  final _withdrawAccountController = TextEditingController();
  WalletRequestType _type = WalletRequestType.deposit;
  String? _filePath;
  int? _transferAccountId;
  int? _withdrawMethodId;
  bool _showTransferAccountError = false;
  bool _showWithdrawMethodError = false;

  bool get _isDeposit => _type == WalletRequestType.deposit;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateWalletRequestCubit>();
    cubit.loadTransferAccounts();
    cubit.loadWithdrawMethods();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _withdrawAccountController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachment() async {
    final path = await PickAttachmentFlow.run(context);
    if (path != null) setState(() => _filePath = path);
  }

  bool _hasValidationErrors(CreateWalletRequestCubit cubit) {
    setState(() {
      _showTransferAccountError = _isDeposit &&
          cubit.state.transferAccounts.isNotEmpty &&
          _transferAccountId == null;
      _showWithdrawMethodError = !_isDeposit &&
          cubit.state.withdrawMethods.isNotEmpty &&
          _withdrawMethodId == null;
    });
    return !_formKey.currentState!.validate() ||
        _showTransferAccountError ||
        _showWithdrawMethodError;
  }

  Future<void> _submit() async {
    final cubit = context.read<CreateWalletRequestCubit>();
    if (_hasValidationErrors(cubit)) return;

    if (_isDeposit && _filePath == null) {
      showError(S().walletRequestAttachmentRequired);
      return;
    }

    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    final note = _noteController.text.trim();

    final created = await cubit.submit(
      type: _type,
      amount: amount,
      transferAccountId: _isDeposit ? _transferAccountId : null,
      withdrawMethodId: _isDeposit ? null : _withdrawMethodId,
      withdrawAccount: _isDeposit ? null : _withdrawAccountController.text.trim(),
      note: note.isEmpty ? null : note,
      filePath: _isDeposit ? _filePath : null,
    );

    if (!mounted) return;

    if (created) {
      showSuccess(S().walletRequestCreatedSuccess);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<CreateWalletRequestCubit, CreateWalletRequestState>(
      isBusy: (state) => state.status == CreateWalletRequestStatus.submitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
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
                  withdrawMethods: state.withdrawMethods,
                  selectedWithdrawMethodId: _withdrawMethodId,
                  onWithdrawMethodChanged: (id) => setState(() {
                    _withdrawMethodId = id;
                    _showWithdrawMethodError = false;
                  }),
                  showWithdrawMethodError: _showWithdrawMethodError,
                ),
                SizedBox(height: 20.h),
                WalletRequestSubmitButton(status: state.status, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
