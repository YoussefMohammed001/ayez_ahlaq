import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../categories/presentation/pages/barber_storefront_categories_screen.dart';
import '../../categories/presentation/widgets/add_storefront_category_sheet.dart';
import '../../delivery/presentation/pages/barber_storefront_delivery_screen.dart';
import '../../orders/presentation/pages/barber_storefront_orders_screen.dart';
import '../../products/presentation/pages/barber_storefront_products_screen.dart';

class StorefrontHomeScreen extends StatefulWidget {
  final int initialTabIndex;
  final bool showBackButton;

  const StorefrontHomeScreen({
    super.key,
    this.initialTabIndex = 0,
    this.showBackButton = false,
  });

  @override
  State<StorefrontHomeScreen> createState() => _StorefrontHomeScreenState();
}

class _StorefrontHomeScreenState extends State<StorefrontHomeScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = TabController(
    length: 4,
    vsync: this,
    initialIndex: widget.initialTabIndex,
  )..addListener(() => setState(() {}));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.showBackButton
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: context.colorScheme.onSurface),
                onPressed: () => context.pop(),
              )
            : null,
        automaticallyImplyLeading: widget.showBackButton,
        title: Text(S().storefrontTitle, style: HeadingStyles.h4),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(text: S().storefrontProductsTitle),
            Tab(text: S().storefrontCategoriesTitle),
            Tab(text: S().storefrontDeliveryMenuTitle),
            Tab(text: S().storefrontOrdersTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          BarberStorefrontProductsScreen(),
          BarberStorefrontCategoriesScreen(),
          BarberStorefrontDeliveryScreen(),
          BarberStorefrontOrdersScreen(),
        ],
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget? _buildFab(BuildContext context) {
    switch (_controller.index) {
      case 0:
        return FloatingActionButton(
          heroTag: 'storefrontAddProductFab',
          onPressed: () => context.push(Routes.barberStorefrontProductFormScreen),
          child: const Icon(Icons.add_rounded),
        );
      case 1:
        return FloatingActionButton(
          heroTag: 'storefrontAddCategoryFab',
          onPressed: () => AddStorefrontCategorySheet.show(context),
          child: const Icon(Icons.add_rounded),
        );
      default:
        return null;
    }
  }
}
