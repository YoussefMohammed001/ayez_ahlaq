import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NavTabItem {
  final IconData icon;
  final String label;
  const NavTabItem(this.icon, this.label);
}

/// Custom bottom navigation matching the brass/ink design system —
/// Flutter's stock [BottomNavigationBar] doesn't give quite the right
/// look for a 5-tab RTL bar, so this is a thin bespoke replacement.
class AppBottomNavBar extends StatelessWidget {
  final List<NavTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({super.key, required this.items, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
      decoration: const BoxDecoration(
        color: AppColors.ink800,
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: InkWell(
                  onTap: () => onTap(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[i].icon,
                          size: 22,
                          color: i == currentIndex ? AppColors.brass400 : AppColors.ivory500,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          items[i].label,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: i == currentIndex ? AppColors.brass400 : AppColors.ivory500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
