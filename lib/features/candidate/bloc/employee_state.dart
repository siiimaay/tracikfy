
part of 'employee_bloc.dart';

@freezed
class EmployeeDetailState with _$EmployeeDetailState {
  const factory EmployeeDetailState({
    bool? isLoading,
    bool? isOperationSuccessful,
  }) = _EmployeeDetailState;

  factory EmployeeDetailState.initial() {
    return const EmployeeDetailState();
  }
}
