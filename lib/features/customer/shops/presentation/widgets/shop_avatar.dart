import 'package:flutter/material.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/authorized_network_image.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../generated/l10n.dart';

class ShopAvatar extends StatelessWidget {
  final int shopId;
  final String shopName;
  final bool hasProfileImage;
  final double size;

  const ShopAvatar({
    super.key,
    required this.shopId,
    required this.shopName,
    required this.size,
    this.hasProfileImage = true,
  });

  Widget _initials() => AvatarCircle(
    initials: shopName.isEmpty ? S().avatarFallback : shopName.substring(0, 1),
    size: size,
  );

  Widget _loading(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: context.colorScheme.surfaceContainerHighest,
      shape: BoxShape.circle,
    ),
    child: SizedBox(
      width: size * 0.4,
      height: size * 0.4,
      child: const CircularProgressIndicator(strokeWidth: 2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (!hasProfileImage) return _initials();

    return ClipOval(
      child: AuthorizedNetworkImage(
        endPoint: EndPoints.customerShopProfileImage(shopId),
        width: size,
        height: size,
        placeholderBuilder: (_) => _initials(),
        loadingBuilder: (context) => _loading(context),
      ),
    );
  }
}
