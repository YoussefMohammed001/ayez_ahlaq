import 'package:flutter/material.dart';
import '../extensions/ext_theme.dart';
import '../widgets/nav_tab_item.dart';
import 'window_size.dart';

class AdaptiveNavScaffold extends StatelessWidget {
  final List<NavTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Widget body;
  final Widget Function(int index, Widget tab)? tabBuilder;
  final Widget? railLeading;
  final Widget? compactBottomBar;
  final Widget? compactFab;
  final FloatingActionButtonLocation? compactFabLocation;

  const AdaptiveNavScaffold({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.body,
    this.tabBuilder,
    this.railLeading,
    this.compactBottomBar,
    this.compactFab,
    this.compactFabLocation,
  });

  @override
  Widget build(BuildContext context) {
    final size = context.windowSize;

    if (size.isCompact) {
      return Scaffold(
        body: body,
        bottomNavigationBar: compactBottomBar,
        floatingActionButton: compactFab,
        floatingActionButtonLocation: compactFabLocation,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            _rail(context, extended: size.isExpanded),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: context.colorScheme.outline,
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }

  Widget _rail(BuildContext context, {required bool extended}) {
    final scheme = context.colorScheme;
    final accent = context.semantic.accentStrong;

    return NavigationRail(
      extended: extended,
      minExtendedWidth: 220,
      backgroundColor: scheme.surfaceContainer,
      indicatorColor: accent.withValues(alpha: 0.16),
      selectedIconTheme: IconThemeData(color: accent),
      unselectedIconTheme: IconThemeData(color: scheme.onSurfaceVariant),
      selectedLabelTextStyle: TextStyle(
        color: accent,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelTextStyle: TextStyle(color: scheme.onSurfaceVariant),
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      leading: railLeading == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: railLeading,
            ),
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        for (final (index, item) in items.indexed)
          NavigationRailDestination(
            icon: _wrap(index, Icon(item.icon)),
            label: Text(item.label),
          ),
      ],
    );
  }

  Widget _wrap(int index, Widget icon) => tabBuilder?.call(index, icon) ?? icon;
}
