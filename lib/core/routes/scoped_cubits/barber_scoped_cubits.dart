import '../../../features/barber/auth/presentation/manager/barber_auth_cubit.dart';
import '../../../features/barber/bookings/presentation/manager/bookings_cubit.dart';
import '../../../features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import '../../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import '../../../features/barber/home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../../features/barber/home_service/presentation/manager/home_service_hours_cubit.dart';
import '../../../features/barber/home_service_requests/presentation/manager/home_service_requests_cubit.dart'
    as barber_hsr;
import '../../../features/barber/home_service_broadcast/presentation/manager/home_service_broadcast_cubit.dart';
import '../../../features/barber/drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../../features/barber/discounts/presentation/manager/barber_discounts_cubit.dart';
import '../../../features/barber/sponsorship/presentation/manager/barber_sponsorship_cubit.dart';
import '../../../features/barber/services/presentation/manager/barber_services_cubit.dart';
import '../../../features/barber/services/presentation/manager/own_services_cubit.dart';
import '../../../features/barber/services/presentation/manager/shop_haircut_styles_cubit.dart';
import '../../../features/barber/documents/presentation/manager/barber_documents_cubit.dart';
import '../../../features/barber/wallet/presentation/manager/barber_wallet_requests_cubit.dart';
import '../../../features/barber/money/presentation/manager/money_pin_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_cart_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_feed_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_orders_cubit.dart';
import '../../../features/barber/storefront/categories/presentation/manager/barber_storefront_categories_cubit.dart';
import '../../../features/barber/storefront/delivery/presentation/manager/barber_storefront_delivery_cubit.dart';
import '../../../features/barber/storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../../features/barber/storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../../features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
import '../../../features/barber/reviews/presentation/manager/barber_reviews_cubit.dart';
import '../../../features/barber/invite/presentation/manager/barber_invite_cubit.dart';
import '../../../features/barber/subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../../features/barber/subscription/presentation/manager/barber_subscription_requests_cubit.dart';
import '../../../features/barber/broadcast/presentation/manager/barber_broadcast_cubit.dart';
import '../../../features/barber/broadcast/presentation/manager/broadcast_list_cubit.dart';
import '../../../features/barber/notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../../features/barber/team/presentation/manager/barber_team_cubit.dart';
import '../../../features/barber/team/presentation/manager/earnings_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_clients_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_earnings_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_hours_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_services_cubit.dart';
import '../../../features/barber/team/presentation/manager/team_member_detail_cubit.dart';
import '../../session/session_scope.dart';

BarberAuthCubit get barberAuthCubit => SessionScope.cubit<BarberAuthCubit>();
BarberBroadcastCubit get barberBroadcastCubit =>
    SessionScope.cubit<BarberBroadcastCubit>();
BroadcastListCubit get barberBroadcastListCubit =>
    SessionScope.cubit<BroadcastListCubit>();
BarberDiscountsCubit get barberDiscountsCubit =>
    SessionScope.cubit<BarberDiscountsCubit>();
BarberDocumentsCubit get barberDocumentsCubit =>
    SessionScope.cubit<BarberDocumentsCubit>();
BarberDrinksCubit get barberDrinksCubit =>
    SessionScope.cubit<BarberDrinksCubit>();
barber_hsr.HomeServiceRequestsCubit get barberHomeServiceRequestsCubit =>
    SessionScope.cubit<barber_hsr.HomeServiceRequestsCubit>();
BarberHoursCubit get barberHoursCubit => SessionScope.cubit<BarberHoursCubit>();
BarberInviteCubit get barberInviteCubit =>
    SessionScope.cubit<BarberInviteCubit>();
BarberNotificationsCubit get barberNotificationsCubit =>
    SessionScope.cubit<BarberNotificationsCubit>();
BarberProfileCubit get barberProfileCubit =>
    SessionScope.cubit<BarberProfileCubit>();
BarberReviewsCubit get barberReviewsCubit =>
    SessionScope.cubit<BarberReviewsCubit>();
BarberServicesCubit get barberServicesCubit =>
    SessionScope.cubit<BarberServicesCubit>();
BarberSponsorshipCubit get barberSponsorshipCubit =>
    SessionScope.cubit<BarberSponsorshipCubit>();
BarberStoreCartCubit get barberStoreCartCubit =>
    SessionScope.cubit<BarberStoreCartCubit>();
BarberStoreFeedCubit get barberStoreFeedCubit =>
    SessionScope.cubit<BarberStoreFeedCubit>();
BarberStoreMerchantsCubit get barberStoreMerchantsCubit =>
    SessionScope.cubit<BarberStoreMerchantsCubit>();
BarberStoreOrdersCubit get barberStoreOrdersCubit =>
    SessionScope.cubit<BarberStoreOrdersCubit>();
BarberStorefrontCategoriesCubit get barberStorefrontCategoriesCubit =>
    SessionScope.cubit<BarberStorefrontCategoriesCubit>();
BarberStorefrontDeliveryCubit get barberStorefrontDeliveryCubit =>
    SessionScope.cubit<BarberStorefrontDeliveryCubit>();
BarberStorefrontOrdersCubit get barberStorefrontOrdersCubit =>
    SessionScope.cubit<BarberStorefrontOrdersCubit>();
BarberStorefrontProductsCubit get barberStorefrontProductsCubit =>
    SessionScope.cubit<BarberStorefrontProductsCubit>();
BarberSubscriptionCubit get barberSubscriptionCubit =>
    SessionScope.cubit<BarberSubscriptionCubit>();
BarberSubscriptionRequestsCubit get barberSubscriptionRequestsCubit =>
    SessionScope.cubit<BarberSubscriptionRequestsCubit>();
BarberTeamCubit get barberTeamCubit => SessionScope.cubit<BarberTeamCubit>();
BarberWalletCubit get barberWalletCubit =>
    SessionScope.cubit<BarberWalletCubit>();
BarberWalletRequestsCubit get barberWalletRequestsCubit =>
    SessionScope.cubit<BarberWalletRequestsCubit>();
BookingsCubit get bookingsCubit => SessionScope.cubit<BookingsCubit>();
EarningsCubit get earningsCubit => SessionScope.cubit<EarningsCubit>();
HomeServiceBroadcastCubit get homeServiceBroadcastCubit =>
    SessionScope.cubit<HomeServiceBroadcastCubit>();
HomeServiceHoursCubit get homeServiceHoursCubit =>
    SessionScope.cubit<HomeServiceHoursCubit>();
HomeServiceSettingsCubit get homeServiceSettingsCubit =>
    SessionScope.cubit<HomeServiceSettingsCubit>();
MemberClientsCubit get memberClientsCubit =>
    SessionScope.cubit<MemberClientsCubit>();
MemberEarningsCubit get memberEarningsCubit =>
    SessionScope.cubit<MemberEarningsCubit>();
MemberHoursCubit get memberHoursCubit => SessionScope.cubit<MemberHoursCubit>();
MemberServicesCubit get memberServicesCubit =>
    SessionScope.cubit<MemberServicesCubit>();
MoneyPinCubit get moneyPinCubit => SessionScope.cubit<MoneyPinCubit>();
OwnServicesCubit get ownServicesCubit => SessionScope.cubit<OwnServicesCubit>();
ShopHaircutStylesCubit get shopHaircutStylesCubit =>
    SessionScope.cubit<ShopHaircutStylesCubit>();
TeamMemberDetailCubit get teamMemberDetailCubit =>
    SessionScope.cubit<TeamMemberDetailCubit>();
