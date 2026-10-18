import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_requests_cubit.dart';
import '../widgets/home_service_requests_tab_view.dart';

class HomeServiceRequestsScreen extends StatefulWidget {
  const HomeServiceRequestsScreen({super.key});

  @override
  State<HomeServiceRequestsScreen> createState() =>
      _HomeServiceRequestsScreenState();
}

class _HomeServiceRequestsScreenState extends State<HomeServiceRequestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeServiceRequestsCubit>().loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().homeServiceRequestsTitle),
      body: const HomeServiceRequestsTabView(),
    );
  }
}
