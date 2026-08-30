class TeamMember {
  final String name;
  final String tag;
  final int clientsThisMonth;
  final double rating;
  final bool isYou;

  const TeamMember({
    required this.name,
    required this.tag,
    required this.clientsThisMonth,
    required this.rating,
    this.isYou = false,
  });
}
