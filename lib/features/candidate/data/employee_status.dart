enum EmployeeStatus {
  active(name: "ACTIVE"),
  deactivated(name: "DEACTIVATED"),
  interviewed(name: "INTERVIEWED"),
  onboarding(name: "ONBOARDING");
  final String name;
  const EmployeeStatus({required this.name});
}