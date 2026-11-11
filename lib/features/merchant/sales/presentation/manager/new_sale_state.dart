import 'package:equatable/equatable.dart';
import '../../../../../shared/payment_methods/payment_method.dart';

class NewSaleState extends Equatable {
  final Map<int, int> quantities;
  final List<PaymentMethod> methods;
  final String? paymentMethod;
  final bool isSubmitting;
  final String? errorMessage;

  const NewSaleState({
    this.quantities = const {},
    this.methods = const [],
    this.paymentMethod,
    this.isSubmitting = false,
    this.errorMessage,
  });

  int quantityOf(int productId) => quantities[productId] ?? 0;

  bool get hasItems => quantities.isNotEmpty;

  NewSaleState copyWith({
    Map<int, int>? quantities,
    List<PaymentMethod>? methods,
    String? paymentMethod,
    bool clearPaymentMethod = false,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return NewSaleState(
      quantities: quantities ?? this.quantities,
      methods: methods ?? this.methods,
      paymentMethod: clearPaymentMethod
          ? null
          : paymentMethod ?? this.paymentMethod,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    quantities,
    methods,
    paymentMethod,
    isSubmitting,
    errorMessage,
  ];
}
