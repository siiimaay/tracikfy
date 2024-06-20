part of 'dashboard_cubit.dart';

final class DashboardState extends Equatable {
  final int currentIndex;
  final List<Interview> interviews;
  final List<Employee> employees;

  const DashboardState(
      {this.currentIndex = 0,
      this.interviews = const [],
      this.employees = const []});

  DashboardState copyWith({
    int? currentIndex,
    List<Interview>? interviews,
    List<Employee>? employees,
  }) {
    return DashboardState(
      currentIndex: currentIndex ?? this.currentIndex,
      interviews: interviews ?? this.interviews,
      employees: employees ?? this.employees,
    );
  }

  @override
  List<Object?> get props => [currentIndex, interviews, employees];
}
