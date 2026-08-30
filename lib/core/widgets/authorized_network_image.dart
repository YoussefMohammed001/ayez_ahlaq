import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../cache/secure_storage/secure_storage.dart';
import '../constants/strings.dart';
import '../di/services_locator.dart';
import '../network/constants/http_headers.dart';

class AuthorizedNetworkImage extends StatefulWidget {
  final String endPoint;
  final double width;
  final double height;
  final BoxFit fit;
  final WidgetBuilder placeholderBuilder;

  const AuthorizedNetworkImage({
    super.key,
    required this.endPoint,
    required this.width,
    required this.height,
    required this.placeholderBuilder,
    this.fit = BoxFit.cover,
  });

  @override
  State<AuthorizedNetworkImage> createState() => _AuthorizedNetworkImageState();
}

class _AuthorizedNetworkImageState extends State<AuthorizedNetworkImage> {
  late final Future<String?> _token = sl<SecureStorage>().read(
    SecureStorageKeys.userToken,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _token,
      builder: (context, snapshot) {
        final token = snapshot.data;

        if (token == null || token.isEmpty) {
          return widget.placeholderBuilder(context);
        }

        return CachedNetworkImage(
          imageUrl: '${AppStrings.baseUrl}${widget.endPoint}',
          httpHeaders: {HttpHeadersKeys.authorization: 'Bearer $token'},
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          placeholder: (context, _) => widget.placeholderBuilder(context),
          errorWidget: (context, _, __) => widget.placeholderBuilder(context),
        );
      },
    );
  }
}
