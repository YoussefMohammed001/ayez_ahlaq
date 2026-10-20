import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../cache/auth_token_memory_cache.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../cache/preferences_storage/preferences_storage_keys.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../constants/strings.dart';
import '../di/services_locator.dart';
import '../network/constants/http_headers.dart';
import '../../shared/user_type.dart';

class AuthorizedNetworkImage extends StatefulWidget {
  final String endPoint;
  final double width;
  final double height;
  final BoxFit fit;
  final WidgetBuilder placeholderBuilder;
  final WidgetBuilder? loadingBuilder;

  const AuthorizedNetworkImage({
    super.key,
    required this.endPoint,
    required this.width,
    required this.height,
    required this.placeholderBuilder,
    this.loadingBuilder,
    this.fit = BoxFit.cover,
  });

  static Future<bool> evict(String endPoint) {
    return CachedNetworkImage.evictFromCache('${AppStrings.baseUrl}$endPoint');
  }

  @override
  State<AuthorizedNetworkImage> createState() => _AuthorizedNetworkImageState();
}

class _AuthorizedNetworkImageState extends State<AuthorizedNetworkImage> {
  late final Future<String?> _token = sl<SecureStorage>()
      .read(SecureStorageKeys.userToken)
      .then((token) {
        AuthTokenMemoryCache.remember(token);
        return token;
      });

  bool _requiresClientHeader() {
    final userType = sl<PreferencesStorage>().getString(key: PreferencesKeys.userType);
    return userType == UserType.barber.name || userType == UserType.customer.name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _token,
      initialData: AuthTokenMemoryCache.token,
      builder: (context, snapshot) {
        final token = snapshot.data;

        if (token == null && snapshot.connectionState != ConnectionState.done) {
          return (widget.loadingBuilder ?? widget.placeholderBuilder)(context);
        }

        if (token == null || token.isEmpty) {
          return widget.placeholderBuilder(context);
        }

        return CachedNetworkImage(
          imageUrl: '${AppStrings.baseUrl}${widget.endPoint}',
          httpHeaders: {
            HttpHeadersKeys.authorization: 'Bearer $token',
            if (_requiresClientHeader()) HttpHeadersKeys.client: 'MOBILE',
          },
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
          placeholderFadeInDuration: Duration.zero,
          placeholder: (context, _) =>
              (widget.loadingBuilder ?? widget.placeholderBuilder)(context),
          errorWidget: (context, _, __) => widget.placeholderBuilder(context),
        );
      },
    );
  }
}
