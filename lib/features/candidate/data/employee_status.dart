enum EmployeeStatus {
  active(name: "Active"),
  deactivated(name: "Deactivated"),
  interviewing(name: "Interviewing"),
  onboarding(name: "Onboarding"),
  rejected(name: "Rejected");
  final String name;
  const EmployeeStatus({required this.name});


  static EmployeeStatus? fromString(String name) {
    for (var status in EmployeeStatus.values) {
      if (status.name.toLowerCase() == name.toLowerCase()) {
        return status;
      }
    }
    return null;
  }
}