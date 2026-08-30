import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_phone.dart';

enum PhonesStatus { initial, loading, success, failure }

class MerchantPhonesState extends Equatable {
  final PhonesStatus status;
  final List<MerchantPhone> phones;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantPhonesState({
    this.status = PhonesStatus.initial,
    this.phones = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  MerchantPhonesState copyWith({
    PhonesStatus? status,
    List<MerchantPhone>? phones,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantPhonesState(
      status: status ?? this.status,
      phones: phones ?? this.phones,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, phones, errorMessage, isSubmitting];
}
