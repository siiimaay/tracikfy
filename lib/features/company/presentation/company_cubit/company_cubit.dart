import 'package:bloc/bloc.dart';
import 'package:trackify/features/company/data/repository/company_repository.dart';

import '../../../../core/injection/locator.dart';
import 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyState(companies: []));

  void fetchCompanies() async {
    final companies = await getIt.get<CompanyRepository>().fetchCompanies();
    emit(state.copyWith(companies: companies));
  }
}
