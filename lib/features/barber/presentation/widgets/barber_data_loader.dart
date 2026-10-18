import '../../bookings/presentation/manager/bookings_cubit.dart';
import '../../notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../documents/presentation/manager/barber_documents_cubit.dart';
import '../../home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../home_service_broadcast/presentation/manager/home_service_broadcast_cubit.dart';
import '../../home_service_requests/presentation/manager/home_service_requests_cubit.dart';
import '../../services/presentation/manager/barber_services_cubit.dart';
import '../../store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../storefront/categories/presentation/manager/barber_storefront_categories_cubit.dart';
import '../../storefront/delivery/presentation/manager/barber_storefront_delivery_cubit.dart';
import '../../storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../team/presentation/manager/earnings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarberDataLoader {
  const BarberDataLoader._();

  static void loadCommon(BuildContext context) {
    context.read<BarberProfileCubit>().loadProfile(force: true);
    context.read<BarberNotificationsCubit>().refreshUnseenCount();
    context.read<BookingsCubit>().loadPending();
    context.read<BookingsCubit>().loadQueue();
    context.read<BookingsCubit>().loadHistory();
  }

  static void loadOwner(BuildContext context) {
    context.read<BarberProfileCubit>().loadProfileImage(force: true);
    context.read<BarberDocumentsCubit>().loadDocuments(force: true);
    context.read<BarberServicesCubit>().loadServices(force: true);
    context.read<BarberStoreMerchantsCubit>().loadMerchants(force: true);
    context.read<BarberStorefrontProductsCubit>().loadProducts(force: true);
    context.read<BarberStorefrontCategoriesCubit>().loadCategories(force: true);
    context.read<BarberStorefrontDeliveryCubit>().loadDelivery(force: true);
    context.read<BarberStorefrontOrdersCubit>().loadOrders();
    context.read<EarningsCubit>().loadEarnings();
    context.read<BarberSubscriptionCubit>().load(force: true);
    context.read<HomeServiceSettingsCubit>().loadSettings();
    context.read<HomeServiceRequestsCubit>().loadPending();
    context.read<HomeServiceBroadcastCubit>().loadBroadcasts();
  }
}
