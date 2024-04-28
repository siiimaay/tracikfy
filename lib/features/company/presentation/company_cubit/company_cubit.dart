import 'package:bloc/bloc.dart';
import 'package:trackify/core/injection/locator.dart';
import 'package:trackify/features/company/data/company.dart';
import 'package:trackify/features/company/data/repository/company_repository.dart';

import 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(const CompanyState()) {
    fetchCompanies();
  }

  void fetchCompanies() async {
    emit(state.copyWith(isLoading: true));
    final companies =
        await getIt.get<CompanyRepository>().fetchCompanies() as List<Company>;
    emit(state.copyWith(companies: companies, isLoading: false));
  }
}
