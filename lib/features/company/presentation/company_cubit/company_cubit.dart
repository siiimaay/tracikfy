import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/injection/locator.dart';
import 'package:trackify/features/company/data/company.dart';
import 'package:trackify/features/company/data/repository/company_repository.dart';


import 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyState(companies: []));

  void fetchCompanies() async {
   // final companies = await getIt.get<CompanyRepository>().fetchCompanies() as List<Company>;
    //emit(state.copyWith(companies: companies));
  }
}
