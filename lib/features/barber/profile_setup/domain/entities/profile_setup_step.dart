enum ProfileSetupStep {
  hours,
  services,
  photo,
  team,
  teamHours,
  teamServices;

  bool get dependsOnTeam =>
      this == ProfileSetupStep.teamHours ||
      this == ProfileSetupStep.teamServices;

  bool get isTeamRelated => this == ProfileSetupStep.team || dependsOnTeam;
}
