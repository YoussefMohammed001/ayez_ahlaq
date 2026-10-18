import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';
import '../../../documents/presentation/widgets/missing_documents_badge.dart';
import '../../domain/entities/barber_profile.dart';
import 'package:ayez_ahlaq/shared/widgets/profile_menu_section_screen.dart';

class BarberShopMenuScreen extends StatelessWidget {
  final BarberProfile? profile;

  const BarberShopMenuScreen({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return ProfileMenuSectionScreen(
      title: S().shopSection,
      rows: [
        MenuRow(
          icon: Icons.content_cut_rounded,
          label: S().servicesTitle,
          onTap: () => context.push(Routes.barberServicesScreen),
        ),
        MenuRow(
          icon: Icons.schedule_rounded,
          label: S().workingHoursTitle,
          onTap: () => context.push(Routes.barberHoursScreen),
        ),
        MenuRow(
          icon: Icons.location_on_outlined,
          label: S().locationTitle,
          onTap: () =>
              context.push(Routes.barberLocationScreen, extra: profile),
        ),
        MenuRow(
          icon: Icons.folder_outlined,
          label: S().myDocuments,
          trailing: const MissingDocumentsBadge(),
          onTap: () => context.push(Routes.barberDocumentsScreen),
        ),
        MenuRow(
          icon: Icons.groups_outlined,
          label: S().teamTitle,
          onTap: () => context.push(Routes.barberTeamScreen),
        ),
        MenuRow(
          icon: Icons.home_repair_service_outlined,
          label: S().homeServiceSettingsTitle,
          onTap: () => context.push(Routes.barberHomeServiceSettingsScreen),
        ),
      ],
    );
  }
}
