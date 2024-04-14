import 'package:bloc/bloc.dart';

import 'company_state.dart';


class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyState(companies: []));


  void fetchCompanies(){

  }
}
