enum DashboardSection {
  dashboard(name: "Dashboard"),
  candidate(name: "Candidate"),
  companies(name: "Companies"),
  logout(name: "Logout");

  final String name;
  const DashboardSection({required this.name});
}
