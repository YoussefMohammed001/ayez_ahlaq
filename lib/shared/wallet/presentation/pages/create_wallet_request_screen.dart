import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/alerts.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/documents/pick_attachment_flow.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../manager/create_wallet_request_cubit.dart';
import '../manager/create_wallet_request_state.dart';
import '../manager/wallet_cubit.dart';
import '../widgets/wallet_request_confirm_dialog.dart';
import '../widgets/wallet_request_form_body.dart';

class CreateWalletRequestScreen extends StatefulWidget {
  const CreateWalletRequestScreen({super.key});

  @override
  State<CreateWalletRequestScreen> createState() =>
      _CreateWalletRequestScreenState();
}

class _CreateWalletRequestScreenState
    extends State<CreateWalletRequestScreen> {
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
    context.read<CreateWalletRequestCubit>()
      ..loadTransferAccounts()
      ..loadWithdrawMethods();
    context.read<WalletCubit>().loadWallet();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _withdrawAccountController.dispose();
    super.dispose();
  }

  void _onTransferAccountChanged(int id) => setState(() {
    _transferAccountId = id;
    _showTransferAccountError = false;
  });

  void _onWithdrawMethodChanged(int id) => setState(() {
    _withdrawMethodId = id;
    _showWithdrawMethodError = false;
  });

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
    final confirmed = await WalletRequestConfirmDialog.show(
      context,
      isDeposit: _isDeposit,
      amount: amount,
    );
    if (!confirmed || !mounted) return;

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
      context.read<WalletCubit>().loadWallet();
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
          builder: (context, state) => WalletRequestFormBody(
            state: state,
            amountController: _amountController,
            noteController: _noteController,
            withdrawAccountController: _withdrawAccountController,
            type: _type,
            onTypeChanged: (type) => setState(() => _type = type),
            filePath: _filePath,
            onPickAttachment: () async {
              final path = await PickAttachmentFlow.run(context);
              if (path != null) setState(() => _filePath = path);
            },
            selectedTransferAccountId: _transferAccountId,
            onTransferAccountChanged: _onTransferAccountChanged,
            showTransferAccountError: _showTransferAccountError,
            selectedWithdrawMethodId: _withdrawMethodId,
            onWithdrawMethodChanged: _onWithdrawMethodChanged,
            showWithdrawMethodError: _showWithdrawMethodError,
            onSubmit: _submit,
          ),
        ),
      ),
    );
  }
}
