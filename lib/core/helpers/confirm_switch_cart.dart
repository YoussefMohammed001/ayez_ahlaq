import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'show_confirm_dialog.dart';

Future<bool> confirmSwitchCart(BuildContext context) => showConfirmDialog(
  context,
  title: S().switchShopCartTitle,
  message: S().switchShopCartMessage,
  confirmLabel: S().switchShopCartConfirm,
  icon: Icons.remove_shopping_cart_outlined,
);
