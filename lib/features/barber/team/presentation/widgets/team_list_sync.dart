import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/barber_team_cubit.dart';
import '../manager/team_member_detail_cubit.dart';
import '../manager/team_member_detail_state.dart';

class TeamListSync extends StatelessWidget {
  final Widget child;

  const TeamListSync({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamMemberDetailCubit, TeamMemberDetailState>(
      listenWhen: (previous, current) =>
          current.member != null &&
          previous.member?.id == current.member!.id &&
          previous.member != current.member,
      listener: (context, _) => context.read<BarberTeamCubit>().loadTeam(),
      child: child,
    );
  }
}
