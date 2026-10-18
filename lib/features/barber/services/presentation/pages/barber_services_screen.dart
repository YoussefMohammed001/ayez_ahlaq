import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../../../generated/l10n.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../manager/barber_services_cubit.dart';
import '../manager/barber_services_state.dart';
import '../manager/own_services_cubit.dart';
import '../manager/own_services_state.dart';
import '../widgets/barber_services_list.dart';
import '../widgets/own_services_section.dart';
import 'barber_services_actions.dart';

class BarberServicesScreen extends StatefulWidget {
  const BarberServicesScreen({super.key});

  @override
  State<BarberServicesScreen> createState() => _BarberServicesScreenState();
}

class _BarberServicesScreenState extends State<BarberServicesScreen> {
  final _actions = const BarberServicesActions();

  @override
  void initState() {
    super.initState();
    context.read<OwnServicesCubit>().loadOwnServices();
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberServicesCubit, BarberServicesState>(
      isBusy: (state) => state.isSubmitting || state.isDeleting,
      errorMessage: (state) => state.errorMessage,
      child: BusyErrorListener<OwnServicesCubit, OwnServicesState>(
        isBusy: (state) => state.isSubmitting || state.isDeleting,
        errorMessage: (state) => state.errorMessage,
        child: Scaffold(
          appBar: AppTopBar(
            title: S().servicesTitle,
            trailing: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () => _actions.openForm(context),
              ),
            ),
          ),
          body: BlocBuilder<BarberServicesCubit, BarberServicesState>(
            builder: (context, state) {
              if (state.status == BarberServicesStatus.loading && state.services.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == BarberServicesStatus.failure && state.services.isEmpty) {
                return AppErrorState(
                  message: state.errorMessage,
                  onRetry: context.read<BarberServicesCubit>().loadServices,
                );
              }

              return RefreshableStateView(
                onRefresh: () => _actions.refresh(context),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BarberServicesList(
                        onEdit: (service) => _actions.openForm(context, existing: service),
                        onDelete: (service) => _actions.confirmDeleteService(context, service),
                      ),
                      BlocBuilder<BarberProfileCubit, BarberProfileState>(
                        buildWhen: (previous, current) =>
                            previous.profile?.owner != current.profile?.owner,
                        builder: (context, profileState) {
                          if (!(profileState.profile?.owner ?? false)) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 14.h),
                            child: MenuRow(
                              icon: Icons.content_cut_outlined,
                              label: S().haircutStylesTitle,
                              showDivider: false,
                              onTap: () => context.push(
                                Routes.barberHaircutStylePricingScreen,
                              ),
                            ),
                          );
                        },
                      ),
                      SectionTitle(
                        title: S().ownServicesTitle,
                        actionLabel: S().addOwnServiceTitle,
                        onAction: () => _actions.openOwnServiceForm(context),
                      ),
                      OwnServicesSection(
                        onDelete: (service) => _actions.confirmDeleteOwnService(context, service),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
