import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../documents/presentation/manager/barber_documents_cubit.dart';
import '../../../documents/presentation/manager/barber_documents_state.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../manager/profile_setup_cubit.dart';

class ProfileSetupLocalSync extends StatefulWidget {
  final Widget child;

  const ProfileSetupLocalSync({super.key, required this.child});

  @override
  State<ProfileSetupLocalSync> createState() => _ProfileSetupLocalSyncState();
}

class _ProfileSetupLocalSyncState extends State<ProfileSetupLocalSync> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _sync(context);
    });
  }

  void _sync(BuildContext context) {
    final profile = context.read<BarberProfileCubit>().state;
    final documents = context.read<BarberDocumentsCubit>().state;

    final photoKnown =
        profile.imageStatus == ProfileImageStatus.loaded ||
        profile.imageStatus == ProfileImageStatus.empty;
    final documentsKnown = documents.status == DocumentsStatus.success;
    if (!photoKnown || !documentsKnown) return;

    context.read<ProfileSetupCubit>().syncLocal(
      hasPhoto: profile.imageStatus == ProfileImageStatus.loaded,
      documentsComplete: documents.missingRequiredCount == 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BarberProfileCubit, BarberProfileState>(
          listenWhen: (a, b) => a.imageStatus != b.imageStatus,
          listener: (context, _) => _sync(context),
        ),
        BlocListener<BarberDocumentsCubit, BarberDocumentsState>(
          listener: (context, _) => _sync(context),
        ),
      ],
      child: widget.child,
    );
  }
}
