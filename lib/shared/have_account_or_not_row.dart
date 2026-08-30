import 'package:flutter/material.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/core/widgets/bouncing_widgets.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

import '../core/theme/styles.dart';

class HaveAccountOrNotRow extends StatelessWidget {
  const HaveAccountOrNotRow({super.key, this.isLoginScreen = false});
  final bool isLoginScreen;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginScreen
              ? S().dont_have_account
              : S.of(context).already_have_account,
          style: font16w400.copyWith(color: Color(0xFF757575)),
        ),
        2.wSpace,
        BounceIt(
          // onPressed: () => isLoginScreen
          //     ? context.push(Routes.register)
          //     : context.push(Routes.loginScreen),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1)),
            ),
            child: Text(
              isLoginScreen ? S().register : S.of(context).login,
              style: font16w700.copyWith(height: 1),
            ),
          ),
        ),
      ],
    );
  }
}
