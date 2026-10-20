import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/cart_icon_button.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_feed_product.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import '../widgets/customer_store_feed_grid.dart';
import '../widgets/customer_store_filters_bar.dart';
import 'store_feed_product_details_args.dart';

class CustomerStoreFeedScreen extends StatefulWidget {
  const CustomerStoreFeedScreen({super.key});

  @override
  State<CustomerStoreFeedScreen> createState() => _CustomerStoreFeedScreenState();
}

class _CustomerStoreFeedScreenState extends State<CustomerStoreFeedScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openProduct(StoreFeedProduct item) {
    context.push(
      Routes.customerStoreFeedProductDetailsScreen,
      extra: StoreFeedProductDetailsArgs(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCartCubit, StoreCartState>(
      buildWhen: (previous, current) => previous.cart != current.cart,
      builder: (context, cartState) {
        return Scaffold(
          appBar: AppTopBar(
            title: S().storeTitle,
            viewLeading: false,
            trailing: cartState.isEmpty
                ? null
                : CartIconButton(
                    itemCount: cartState.cart.itemCount,
                    onPressed: () => context.push(Routes.customerStoreCartScreen),
                  ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                CustomerStoreFiltersBar(searchController: _searchController),
                Expanded(child: CustomerStoreFeedGrid(onOpenProduct: _openProduct)),
              ],
            ),
          ),
        );
      },
    );
  }
}
