enum BarberAccountKind {
  owner,
  teamMember;

  static BarberAccountKind fromName(String? value) => values.firstWhere(
    (kind) => kind.name == value,
    orElse: () => BarberAccountKind.owner,
  );

  bool get isTeamMember => this == BarberAccountKind.teamMember;
}
