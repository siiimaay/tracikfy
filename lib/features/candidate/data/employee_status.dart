enum EmployeeStatus {
  active(name: "ACTIVE"),
  deactivated(name: "DEACTIVATED"),
  interviewed(name: "INTERVIEWED");
  final String name;
  const EmployeeStatus({required this.name});
}