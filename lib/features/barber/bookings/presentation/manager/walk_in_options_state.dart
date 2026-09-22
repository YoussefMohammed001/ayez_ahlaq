import 'package:equatable/equatable.dart';
import '../../domain/entities/walk_in_option.dart';

enum WalkInOptionsStatus { initial, loading, success, failure }

class WalkInOptionsState extends Equatable {
  final WalkInOptionsStatus status;
  final List<WalkInOption> options;
  final String? errorMessage;

  const WalkInOptionsState({
    this.status = WalkInOptionsStatus.initial,
    this.options = const [],
    this.errorMessage,
  });

  WalkInOptionsState copyWith({
    WalkInOptionsStatus? status,
    List<WalkInOption>? options,
    String? errorMessage,
  }) {
    return WalkInOptionsState(
      status: status ?? this.status,
      options: options ?? this.options,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, options, errorMessage];
}
