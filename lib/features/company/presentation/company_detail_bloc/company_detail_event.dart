
part of 'company_detail_bloc.dart';

@freezed
class CompanyDetailEvent with _$CompanyDetailEvent {
  const factory CompanyDetailEvent.save(Company data) = _Save;
}