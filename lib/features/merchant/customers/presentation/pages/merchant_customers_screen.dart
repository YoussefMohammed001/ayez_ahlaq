import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_customers_cubit.dart';
import '../manager/merchant_customers_state.dart';
import '../widgets/merchant_customer_row.dart';

class MerchantCustomersScreen extends StatefulWidget {
  const MerchantCustomersScreen({super.key});

  @override
  State<MerchantCustomersScreen> createState() => _MerchantCustomersScreenState();
}

class _MerchantCustomersScreenState extends State<MerchantCustomersScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<MerchantCustomersCubit>().loadCustomers();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 200) {
      return;
    }
    context.read<MerchantCustomersCubit>().loadMore();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      context.read<MerchantCustomersCubit>().search(value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().myCustomers),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
            child: TextFormField(
              controller: _searchController,
              style: TextStyle(color: context.colorScheme.onSurface, fontSize: 13.5.sp),
              decoration: AppInputDecoration.build(context, S().customersSearchHint).copyWith(
                prefixIcon: Icon(Icons.search_rounded, color: context.colorScheme.onSurfaceVariant),
              ),
              onChanged: _onSearchChanged,
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<MerchantCustomersCubit, MerchantCustomersState>(
      listenWhen: (previous, current) =>
          current.status == MerchantCustomersStatus.success &&
          current.errorMessage != null &&
          current.errorMessage != previous.errorMessage,
      listener: (context, state) => showError(state.errorMessage!),
      builder: (context, state) {
        if (state.status == MerchantCustomersStatus.loading) {
          return const ListSkeleton();
        }

        if (state.status == MerchantCustomersStatus.failure && state.customers.isEmpty) {
          return AppErrorState(
            message: state.errorMessage,
            onRetry: () => context.read<MerchantCustomersCubit>().loadCustomers(),
          );
        }

        if (state.customers.isEmpty) {
          return AppEmptyState(
            icon: Icons.people_outline_rounded,
            title: S().noCustomersYet,
            message: S().myCustomersSubtitle,
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<MerchantCustomersCubit>().loadCustomers(),
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
            itemCount: state.customers.length +
                (state.status == MerchantCustomersStatus.loadingMore ? 1 : 0),
            itemBuilder: (_, index) {
              if (index >= state.customers.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              }

              return MerchantCustomerRow(customer: state.customers[index]);
            },
          ),
        );
      },
    );
  }
}
