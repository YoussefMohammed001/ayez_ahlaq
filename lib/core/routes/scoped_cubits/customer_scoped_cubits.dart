import '../../../features/customer/auth/presentation/manager/customer_auth_cubit.dart';
import '../../../features/customer/shops/presentation/manager/customer_shop_detail_cubit.dart';
import '../../../features/customer/shops/presentation/manager/customer_shops_cubit.dart';
import '../../../features/customer/profile/presentation/manager/customer_profile_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_shops_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_request_form_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_requests_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_request_detail_cubit.dart';
import '../../../features/customer/booking/presentation/manager/booking_detail_cubit.dart';
import '../../../features/customer/booking/presentation/manager/booking_flow_cubit.dart';
import '../../../features/customer/booking/presentation/manager/my_bookings_cubit.dart';
import '../../../features/customer/payment_methods/presentation/manager/payment_methods_cubit.dart';
import '../../../features/customer/store/presentation/manager/customer_store_feed_cubit.dart';
import '../../../features/customer/store/presentation/manager/store_cart_cubit.dart';
import '../../../features/customer/store/presentation/manager/store_orders_cubit.dart';
import '../../../features/customer/favorites/presentation/manager/favorites_cubit.dart';
import '../../../features/customer/favorites/presentation/manager/invite_preview_cubit.dart';
import '../../../features/customer/notifications/presentation/manager/customer_notifications_cubit.dart';
import '../../../features/customer/wallet/presentation/manager/customer_wallet_cubit.dart';
import '../../../features/customer/wallet/presentation/manager/customer_wallet_requests_cubit.dart';
import '../../session/session_scope.dart';

BookingFlowCubit get bookingFlowCubit => SessionScope.cubit<BookingFlowCubit>();
CustomerAuthCubit get customerAuthCubit =>
    SessionScope.cubit<CustomerAuthCubit>();
BookingDetailCubit get customerBookingDetailCubit =>
    SessionScope.cubit<BookingDetailCubit>();
FavoritesCubit get customerFavoritesCubit =>
    SessionScope.cubit<FavoritesCubit>();
InvitePreviewCubit get customerInvitePreviewCubit =>
    SessionScope.cubit<InvitePreviewCubit>();
CustomerNotificationsCubit get customerNotificationsCubit =>
    SessionScope.cubit<CustomerNotificationsCubit>();
PaymentMethodsCubit get customerPaymentMethodsCubit =>
    SessionScope.cubit<PaymentMethodsCubit>();
CustomerProfileCubit get customerProfileCubit =>
    SessionScope.cubit<CustomerProfileCubit>();
CustomerShopDetailCubit get customerShopDetailCubit =>
    SessionScope.cubit<CustomerShopDetailCubit>();
CustomerShopsCubit get customerShopsCubit =>
    SessionScope.cubit<CustomerShopsCubit>();
StoreCartCubit get customerStoreCartCubit =>
    SessionScope.cubit<StoreCartCubit>();
CustomerStoreFeedCubit get customerStoreFeedCubit =>
    SessionScope.cubit<CustomerStoreFeedCubit>();
StoreOrdersCubit get customerStoreOrdersCubit =>
    SessionScope.cubit<StoreOrdersCubit>();
CustomerWalletCubit get customerWalletCubit =>
    SessionScope.cubit<CustomerWalletCubit>();
CustomerWalletRequestsCubit get customerWalletRequestsCubit =>
    SessionScope.cubit<CustomerWalletRequestsCubit>();
HomeServiceRequestDetailCubit get homeServiceRequestDetailCubit =>
    SessionScope.cubit<HomeServiceRequestDetailCubit>();
HomeServiceRequestFormCubit get homeServiceRequestFormCubit =>
    SessionScope.cubit<HomeServiceRequestFormCubit>();
HomeServiceRequestsCubit get homeServiceRequestsCubit =>
    SessionScope.cubit<HomeServiceRequestsCubit>();
HomeServiceShopsCubit get homeServiceShopsCubit =>
    SessionScope.cubit<HomeServiceShopsCubit>();
MyBookingsCubit get myBookingsCubit => SessionScope.cubit<MyBookingsCubit>();
