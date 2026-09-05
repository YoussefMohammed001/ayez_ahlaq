import 'package:equatable/equatable.dart';

class SubscriptionQuota extends Equatable {
  final int? cap;
  final int used;
  final int? remaining;

  const SubscriptionQuota({this.cap, required this.used, this.remaining});

  @override
  List<Object?> get props => [cap, used, remaining];
}
