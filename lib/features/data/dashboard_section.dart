enum DashboardSection {
  dashboard(name: "Dashboard"),
  candidate(name: "Candidate"),
  companies(name: "Companies");

  final String name;
  const DashboardSection({required this.name});
}
