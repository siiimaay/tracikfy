enum EmployeeStatus {
  active(name: "Active"),
  deactivated(name: "DEACTIVATED"),
  interviewing(name: "Interviewing"),
  onboarding(name: "Onboarding");
  final String name;
  const EmployeeStatus({required this.name});
}