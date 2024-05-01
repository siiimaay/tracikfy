import 'package:equatable/equatable.dart';

import '../../data/company.dart';

class CompanyState extends Equatable {
  final List<Company> companies;
  final bool isLoading;

  const CompanyState({
    this.companies = const [],
    this.isLoading = false,
  });

  CompanyState copyWith({
    List<Company>? companies,
    bool? isLoading,
  }) {
    return CompanyState(
      companies: companies ?? this.companies,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [companies, isLoading];
}
