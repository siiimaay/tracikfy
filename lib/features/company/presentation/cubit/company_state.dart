import '../../data/company.dart';

final class CompanyState {
  final List<Company> companies;

  CompanyState({this.companies = const []});

  CompanyState copyWith({
    List<Company>? companies,
  }) {
    return CompanyState(companies: companies ?? this.companies);
  }
}
