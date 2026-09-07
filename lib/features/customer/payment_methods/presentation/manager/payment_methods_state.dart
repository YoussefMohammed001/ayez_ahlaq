import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_method.dart';

enum PaymentMethodsStatus { initial, loading, success, failure }

class PaymentMethodsState extends Equatable {
  final PaymentMethodsStatus status;
  final List<PaymentMethod> methods;
  final String? errorMessage;

  const PaymentMethodsState({
    this.status = PaymentMethodsStatus.initial,
    this.methods = const [],
    this.errorMessage,
  });

  PaymentMethodsState copyWith({
    PaymentMethodsStatus? status,
    List<PaymentMethod>? methods,
    String? errorMessage,
  }) {
    return PaymentMethodsState(
      status: status ?? this.status,
      methods: methods ?? this.methods,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, methods, errorMessage];
}
