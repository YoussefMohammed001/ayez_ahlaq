import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'scoped_cubits/merchant_scoped_cubits.dart';

Widget merchantProviders({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider.value(value: merchantDashboardCubit),
      BlocProvider.value(value: merchantProductsCubit),
      BlocProvider.value(value: merchantOrdersCubit),
      BlocProvider.value(value: merchantProfileCubit),
      BlocProvider.value(value: merchantCategoriesCubit),
      BlocProvider.value(value: merchantDiscountsCubit),
      BlocProvider.value(value: merchantDocumentsCubit),
      BlocProvider.value(value: merchantNotificationsCubit),
      BlocProvider.value(value: merchantSubscriptionCubit),
    ],
    child: child,
  );
}
