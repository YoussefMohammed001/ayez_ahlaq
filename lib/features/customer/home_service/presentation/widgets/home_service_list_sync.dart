import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/home_service_request_detail_cubit.dart';
import '../manager/home_service_request_detail_state.dart';
import '../manager/home_service_requests_cubit.dart';

class HomeServiceListSync extends StatelessWidget {
  final Widget child;

  const HomeServiceListSync({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      HomeServiceRequestDetailCubit,
      HomeServiceRequestDetailState
    >(
      listenWhen: (previous, current) =>
          current.request != null &&
          previous.request?.id == current.request!.id &&
          previous.request != current.request,
      listener: (context, state) =>
          context.read<HomeServiceRequestsCubit>().replace(state.request!),
      child: child,
    );
  }
}
