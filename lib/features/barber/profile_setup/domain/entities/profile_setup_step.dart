enum ProfileSetupStep {
  hours(required: true),
  services(required: true),
  photo,
  team,
  teamHours,
  teamServices;

  final bool required;

  const ProfileSetupStep({this.required = false});

  bool get dependsOnTeam =>
      this == ProfileSetupStep.teamHours ||
      this == ProfileSetupStep.teamServices;

  bool get isTeamRelated => this == ProfileSetupStep.team || dependsOnTeam;
}
