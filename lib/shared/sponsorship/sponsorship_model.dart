import 'sponsorship.dart';

class SponsorshipModel extends Sponsorship {
  const SponsorshipModel({
    required super.active,
    required super.monthlyPrice,
    required super.walletBalance,
    required super.walletAvailable,
    required super.canAfford,
    super.startsAt,
    super.endsAt,
    super.lastPrice,
  });

  factory SponsorshipModel.fromJson(Map<String, dynamic> json) {
    return SponsorshipModel(
      active: json['active'] as bool? ?? false,
      monthlyPrice: (json['monthlyPrice'] as num?)?.toInt() ?? 0,
      walletBalance: (json['walletBalance'] as num?)?.toInt() ?? 0,
      walletAvailable: (json['walletAvailable'] as num?)?.toInt() ?? 0,
      canAfford: json['canAfford'] as bool? ?? false,
      startsAt: DateTime.tryParse(json['startsAt'] as String? ?? ''),
      endsAt: DateTime.tryParse(json['endsAt'] as String? ?? ''),
      lastPrice: (json['lastPrice'] as num?)?.toInt(),
    );
  }
}
