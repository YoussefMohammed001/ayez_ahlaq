import '../../../features/merchant/sponsorship/presentation/manager/merchant_sponsorship_cubit.dart';
import '../../../features/merchant/wallet/presentation/manager/merchant_wallet_cubit.dart';
import '../../../features/merchant/wallet/presentation/manager/merchant_wallet_requests_cubit.dart';
import '../../../features/merchant/subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../../features/merchant/subscription/presentation/manager/merchant_subscription_requests_cubit.dart';
import '../../../features/merchant/broadcast/presentation/manager/merchant_broadcast_cubit.dart';
import '../../../features/merchant/broadcast/presentation/manager/merchant_broadcast_list_cubit.dart';
import '../../../features/merchant/auth/presentation/manager/merchant_auth_cubit.dart';
import '../../../features/merchant/categories/presentation/manager/merchant_categories_cubit.dart';
import '../../../features/merchant/dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../../features/merchant/documents/presentation/manager/merchant_documents_cubit.dart';
import '../../../features/merchant/customers/presentation/manager/merchant_customers_cubit.dart';
import '../../../features/merchant/delivery/presentation/manager/merchant_delivery_cubit.dart';
import '../../../features/merchant/discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../../features/merchant/orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../features/merchant/products/presentation/manager/merchant_products_cubit.dart';
import '../../../features/merchant/profile/presentation/manager/merchant_profile_cubit.dart';
import '../../../features/merchant/profile/presentation/manager/merchant_phones_cubit.dart';
import '../../../features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../../features/merchant/attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../features/merchant/team/presentation/manager/my_merchant_member_cubit.dart';
import '../../session/session_scope.dart';

MerchantAuthCubit get merchantAuthCubit =>
    SessionScope.cubit<MerchantAuthCubit>();
MerchantBroadcastCubit get merchantBroadcastCubit =>
    SessionScope.cubit<MerchantBroadcastCubit>();
MerchantBroadcastListCubit get merchantBroadcastListCubit =>
    SessionScope.cubit<MerchantBroadcastListCubit>();
MerchantCategoriesCubit get merchantCategoriesCubit =>
    SessionScope.cubit<MerchantCategoriesCubit>();
MerchantCustomersCubit get merchantCustomersCubit =>
    SessionScope.cubit<MerchantCustomersCubit>();
MerchantDashboardCubit get merchantDashboardCubit =>
    SessionScope.cubit<MerchantDashboardCubit>();
MerchantDeliveryCubit get merchantDeliveryCubit =>
    SessionScope.cubit<MerchantDeliveryCubit>();
MerchantDiscountsCubit get merchantDiscountsCubit =>
    SessionScope.cubit<MerchantDiscountsCubit>();
MerchantDocumentsCubit get merchantDocumentsCubit =>
    SessionScope.cubit<MerchantDocumentsCubit>();
MerchantNotificationsCubit get merchantNotificationsCubit =>
    SessionScope.cubit<MerchantNotificationsCubit>();
MerchantOrdersCubit get merchantOrdersCubit =>
    SessionScope.cubit<MerchantOrdersCubit>();
MerchantPhonesCubit get merchantPhonesCubit =>
    SessionScope.cubit<MerchantPhonesCubit>();
MerchantProductsCubit get merchantProductsCubit =>
    SessionScope.cubit<MerchantProductsCubit>();
MemberAttendanceCubit get memberAttendanceCubit =>
    SessionScope.cubit<MemberAttendanceCubit>();
MyMerchantMemberCubit get myMerchantMemberCubit =>
    SessionScope.cubit<MyMerchantMemberCubit>();
MerchantProfileCubit get merchantProfileCubit =>
    SessionScope.cubit<MerchantProfileCubit>();
MerchantSponsorshipCubit get merchantSponsorshipCubit =>
    SessionScope.cubit<MerchantSponsorshipCubit>();
MerchantSubscriptionCubit get merchantSubscriptionCubit =>
    SessionScope.cubit<MerchantSubscriptionCubit>();
MerchantSubscriptionRequestsCubit get merchantSubscriptionRequestsCubit =>
    SessionScope.cubit<MerchantSubscriptionRequestsCubit>();
MerchantWalletCubit get merchantWalletCubit =>
    SessionScope.cubit<MerchantWalletCubit>();
MerchantWalletRequestsCubit get merchantWalletRequestsCubit =>
    SessionScope.cubit<MerchantWalletRequestsCubit>();
