import 'package:equatable/equatable.dart';

class MerchantMemberPermissions extends Equatable {
  final bool canManageProducts;
  final bool canSell;

  const MerchantMemberPermissions({
    this.canManageProducts = false,
    this.canSell = false,
  });

  MerchantMemberPermissions copyWith({bool? canManageProducts, bool? canSell}) {
    return MerchantMemberPermissions(
      canManageProducts: canManageProducts ?? this.canManageProducts,
      canSell: canSell ?? this.canSell,
    );
  }

  @override
  List<Object?> get props => [canManageProducts, canSell];
}
