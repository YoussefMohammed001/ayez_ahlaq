import 'package:equatable/equatable.dart';
import '../../domain/entities/storefront_delivery_settings.dart';

enum StorefrontDeliveryStatus { initial, loading, success, failure }

class BarberStorefrontDeliveryState extends Equatable {
  final StorefrontDeliveryStatus status;
  final StorefrontDeliverySettings settings;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberStorefrontDeliveryState({
    this.status = StorefrontDeliveryStatus.initial,
    this.settings = const StorefrontDeliverySettings.disabled(),
    this.errorMessage,
    this.isSubmitting = false,
  });

  BarberStorefrontDeliveryState copyWith({
    StorefrontDeliveryStatus? status,
    StorefrontDeliverySettings? settings,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberStorefrontDeliveryState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, settings, errorMessage, isSubmitting];
}
