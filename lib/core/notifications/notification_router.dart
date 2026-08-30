import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/shared/user_type.dart';

abstract class NotificationRouter {
  void route({
    required String type,
    String? typeId,
    required UserType role,
    required BuildContext context,
  });
}
