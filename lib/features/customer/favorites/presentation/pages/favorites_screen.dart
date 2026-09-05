import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/favorites_cubit.dart';
import '../manager/favorites_state.dart';
import '../widgets/favorite_barber_row.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        viewLeading: false,
        title: S().favoritesTitle,
        trailing: IconButton(
          icon: const Icon(Icons.link_rounded),
          onPressed: () => context.push(Routes.customerEnterInviteCodeScreen),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final cubit = context.read<FavoritesCubit>();

          if (state.status == FavoritesStatus.loading && state.favorites.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == FavoritesStatus.failure && state.favorites.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadFavorites,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadFavorites),
            );
          }

          if (state.favorites.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadFavorites,
              child: AppEmptyState(icon: Icons.favorite_border_rounded, title: S().noFavoritesYet),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.loadFavorites,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.favorites.length,
              itemBuilder: (_, index) {
                final favorite = state.favorites[index];
                return FavoriteBarberRow(
                  favorite: favorite,
                  isRemoving: state.removingBarberId == favorite.barberId,
                  onTap: () => context.push(
                    Routes.customerShopDetailScreen,
                    extra: favorite.shopId,
                  ),
                  onRemove: () => cubit.removeFavorite(favorite.barberId),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
