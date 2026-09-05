import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_invite_preview.dart';

enum InvitePreviewStatus { initial, loading, loaded, failure, adding, added }

class InvitePreviewState extends Equatable {
  final InvitePreviewStatus status;
  final BarberInvitePreview? preview;
  final String? errorMessage;

  const InvitePreviewState({
    this.status = InvitePreviewStatus.initial,
    this.preview,
    this.errorMessage,
  });

  InvitePreviewState copyWith({
    InvitePreviewStatus? status,
    BarberInvitePreview? preview,
    String? errorMessage,
  }) {
    return InvitePreviewState(
      status: status ?? this.status,
      preview: preview ?? this.preview,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, preview, errorMessage];
}
