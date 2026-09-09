import 'package:equatable/equatable.dart';
import 'wallet_request_status.dart';
import 'wallet_request_type.dart';

class WalletRequest extends Equatable {
  final int id;
  final String code;
  final String ownerType;
  final int ownerId;
  final String ownerName;
  final String ownerPhone;
  final WalletRequestType type;
  final int amount;
  final String? note;
  final bool hasAttachment;
  final String? attachmentName;
  final WalletRequestStatus status;
  final String? decisionNote;
  final String? decidedByName;
  final DateTime? decidedAt;
  final DateTime? createdAt;

  const WalletRequest({
    required this.id,
    required this.code,
    required this.ownerType,
    required this.ownerId,
    required this.ownerName,
    required this.ownerPhone,
    required this.type,
    required this.amount,
    this.note,
    required this.hasAttachment,
    this.attachmentName,
    required this.status,
    this.decisionNote,
    this.decidedByName,
    this.decidedAt,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    ownerType,
    ownerId,
    ownerName,
    ownerPhone,
    type,
    amount,
    note,
    hasAttachment,
    attachmentName,
    status,
    decisionNote,
    decidedByName,
    decidedAt,
    createdAt,
  ];
}
