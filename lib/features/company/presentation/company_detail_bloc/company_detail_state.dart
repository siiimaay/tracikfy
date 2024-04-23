// counter/counter_state.dart

part of 'company_detail_bloc.dart';

@freezed
class CompanyDetailState with _$CompanyDetailState {
  const factory CompanyDetailState({
    bool? isLoading,
    bool? isOperationSuccessful,
  }) = _CompanyDetailState;

  factory CompanyDetailState.initial() {
    return const CompanyDetailState();
  }
}
