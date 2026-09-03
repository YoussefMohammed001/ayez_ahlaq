import 'package:equatable/equatable.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../../../services/domain/entities/service_catalog_item.dart';

enum MemberServicesStatus { initial, loading, success, failure }

class MemberServicesState extends Equatable {
  final MemberServicesStatus status;
  final int? memberId;
  final List<ServiceCatalogItem> catalog;
  final List<BarberService> services;
  final String? errorMessage;
  final bool isSubmitting;

  const MemberServicesState({
    this.status = MemberServicesStatus.initial,
    this.memberId,
    this.catalog = const [],
    this.services = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  MemberServicesState copyWith({
    MemberServicesStatus? status,
    int? memberId,
    List<ServiceCatalogItem>? catalog,
    List<BarberService>? services,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MemberServicesState(
      status: status ?? this.status,
      memberId: memberId ?? this.memberId,
      catalog: catalog ?? this.catalog,
      services: services ?? this.services,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    memberId,
    catalog,
    services,
    errorMessage,
    isSubmitting,
  ];
}
