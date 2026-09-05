import 'package:equatable/equatable.dart';

class SubscriptionRequest extends Equatable {
  final int id;
  final String code;
  final String ownerType;
  final int ownerId;
  final String ownerName;
  final int planId;
  final String planName;
  final int price;
  final String type;
  final String status;
  final String? decisionNote;
  final String? decidedByName;
  final DateTime? decidedAt;
  final DateTime createdAt;

  const SubscriptionRequest({
    required this.id,
    required this.code,
    required this.ownerType,
    required this.ownerId,
    required this.ownerName,
    required this.planId,
    required this.planName,
    required this.price,
    required this.type,
    required this.status,
    this.decisionNote,
    this.decidedByName,
    this.decidedAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    ownerType,
    ownerId,
    ownerName,
    planId,
    planName,
    price,
    type,
    status,
    decisionNote,
    decidedByName,
    decidedAt,
    createdAt,
  ];
}
