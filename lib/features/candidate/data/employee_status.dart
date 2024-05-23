enum EmployeeStatus {
  active(name: "Active"),
  deactivated(name: "DEACTIVATED"),
  interviewing(name: "Interviewing"),
  onboarding(name: "Onboarding");
  final String name;
  const EmployeeStatus({required this.name});


  static EmployeeStatus? fromString(String name) {
    for (var status in EmployeeStatus.values) {
      if (status.name.toLowerCase() == name.toLowerCase()) {
        return status;
      }
    }
    return null; // or throw an exception if preferred
  }
}