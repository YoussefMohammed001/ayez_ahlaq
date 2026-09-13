import 'package:equatable/equatable.dart';
import '../../domain/entities/own_service.dart';

enum OwnServicesStatus { initial, loading, success, failure }

class OwnServicesState extends Equatable {
  final OwnServicesStatus status;
  final List<OwnService> services;
  final String? errorMessage;
  final bool isSubmitting;
  final bool isDeleting;

  const OwnServicesState({
    this.status = OwnServicesStatus.initial,
    this.services = const [],
    this.errorMessage,
    this.isSubmitting = false,
    this.isDeleting = false,
  });

  OwnServicesState copyWith({
    OwnServicesStatus? status,
    List<OwnService>? services,
    String? errorMessage,
    bool? isSubmitting,
    bool? isDeleting,
  }) {
    return OwnServicesState(
      status: status ?? this.status,
      services: services ?? this.services,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    services,
    errorMessage,
    isSubmitting,
    isDeleting,
  ];
}
