import 'package:equatable/equatable.dart';
import '../../domain/entities/own_service.dart';

enum OwnServicesStatus { initial, loading, success, failure }

class OwnServicesState extends Equatable {
  final OwnServicesStatus status;
  final List<OwnService> services;
  final String? errorMessage;
  final bool isSubmitting;

  const OwnServicesState({
    this.status = OwnServicesStatus.initial,
    this.services = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  OwnServicesState copyWith({
    OwnServicesStatus? status,
    List<OwnService>? services,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return OwnServicesState(
      status: status ?? this.status,
      services: services ?? this.services,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, services, errorMessage, isSubmitting];
}
