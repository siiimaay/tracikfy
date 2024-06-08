part of 'dashboard_cubit.dart';

final class DashboardState extends Equatable {
  final int currentIndex;
  final List<Interview> interviews;

  const DashboardState({this.currentIndex = 0, this.interviews = const []});

  DashboardState copyWith({
    int? currentIndex,
    List<Interview>? interviews,
  }) {
    return DashboardState(
        currentIndex: currentIndex ?? this.currentIndex,
        interviews: interviews ?? this.interviews);
  }

  @override
  List<Object?> get props => [currentIndex, interviews];
}
