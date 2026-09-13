import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/service_catalog_item.dart';

enum BarberServicesStatus { initial, loading, success, failure }

class BarberServicesState extends Equatable {
  final BarberServicesStatus status;
  final List<ServiceCatalogItem> catalog;
  final List<BarberService> services;
  final String? errorMessage;
  final bool isSubmitting;
  final bool isDeleting;

  const BarberServicesState({
    this.status = BarberServicesStatus.initial,
    this.catalog = const [],
    this.services = const [],
    this.errorMessage,
    this.isSubmitting = false,
    this.isDeleting = false,
  });

  BarberServicesState copyWith({
    BarberServicesStatus? status,
    List<ServiceCatalogItem>? catalog,
    List<BarberService>? services,
    String? errorMessage,
    bool? isSubmitting,
    bool? isDeleting,
  }) {
    return BarberServicesState(
      status: status ?? this.status,
      catalog: catalog ?? this.catalog,
      services: services ?? this.services,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    catalog,
    services,
    errorMessage,
    isSubmitting,
    isDeleting,
  ];
}
