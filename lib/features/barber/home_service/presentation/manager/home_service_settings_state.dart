import 'package:equatable/equatable.dart';
import '../../domain/entities/home_service_settings.dart';

enum HomeServiceSettingsStatus { initial, loading, success, failure }

class HomeServiceSettingsState extends Equatable {
  final HomeServiceSettingsStatus status;
  final HomeServiceSettings settings;
  final String? errorMessage;
  final bool isSubmitting;

  const HomeServiceSettingsState({
    this.status = HomeServiceSettingsStatus.initial,
    this.settings = const HomeServiceSettings(
      enabled: false,
      price: null,
      note: null,
    ),
    this.errorMessage,
    this.isSubmitting = false,
  });

  HomeServiceSettingsState copyWith({
    HomeServiceSettingsStatus? status,
    HomeServiceSettings? settings,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return HomeServiceSettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, settings, errorMessage, isSubmitting];
}
