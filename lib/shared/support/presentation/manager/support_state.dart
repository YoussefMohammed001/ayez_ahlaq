import 'package:equatable/equatable.dart';
import '../../domain/entities/support_info.dart';

enum SupportStatus { initial, loading, success, failure }

class SupportState extends Equatable {
  final SupportStatus status;
  final SupportInfo? info;
  final String? errorMessage;

  const SupportState({
    this.status = SupportStatus.initial,
    this.info,
    this.errorMessage,
  });

  SupportState copyWith({
    SupportStatus? status,
    SupportInfo? info,
    String? errorMessage,
  }) {
    return SupportState(
      status: status ?? this.status,
      info: info ?? this.info,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, info, errorMessage];
}
