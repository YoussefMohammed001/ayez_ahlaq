import '../../../../../core/widgets/badge_tone.dart';
import '../../domain/entities/home_service_request_status.dart';

extension HomeServiceStatusTone on HomeServiceRequestStatus {
  BadgeTone get tone => switch (this) {
    HomeServiceRequestStatus.pending => BadgeTone.gold,
    HomeServiceRequestStatus.accepted => BadgeTone.info,
    HomeServiceRequestStatus.onTheWay => BadgeTone.info,
    HomeServiceRequestStatus.done => BadgeTone.muted,
    HomeServiceRequestStatus.rejected => BadgeTone.danger,
    HomeServiceRequestStatus.cancelled => BadgeTone.danger,
  };
}
