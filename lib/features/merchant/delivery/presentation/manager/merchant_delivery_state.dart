import 'package:equatable/equatable.dart';
import '../../domain/entities/delivery_settings.dart';

enum DeliveryStatus { initial, loading, success, failure }

class MerchantDeliveryState extends Equatable {
  final DeliveryStatus status;
  final DeliverySettings settings;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantDeliveryState({
    this.status = DeliveryStatus.initial,
    this.settings = const DeliverySettings.disabled(),
    this.errorMessage,
    this.isSubmitting = false,
  });

  MerchantDeliveryState copyWith({
    DeliveryStatus? status,
    DeliverySettings? settings,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantDeliveryState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, settings, errorMessage, isSubmitting];
}
