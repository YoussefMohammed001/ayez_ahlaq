import '../../../../../generated/l10n.dart';
import '../../domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel({required super.code, required super.label});

  factory PaymentMethodModel.fromCode(String code) {
    return PaymentMethodModel(code: code, label: _labelFor(code));
  }

  static String _labelFor(String code) {
    switch (code) {
      case 'CASH':
        return S().paymentMethodCash;
      case 'CARD':
        return S().paymentMethodCard;
      case 'WALLET':
        return S().paymentMethodWallet;
      default:
        return code;
    }
  }
}
