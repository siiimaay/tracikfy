import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/injection/locator.dart';

import '../../data/company.dart';
import '../../data/repository/company_repository.dart';

part 'company_detail_event.dart';

part 'company_detail_state.dart';

part 'company_detail_bloc.freezed.dart';

@injectable
class CompanyDetailBloc extends Bloc<CompanyDetailEvent, CompanyDetailState> {

  CompanyDetailBloc()
      : super(CompanyDetailState.initial()) {
    on<CompanyDetailEvent>((event, emit) {
      event.map(save: (event)  {
        emit(state.copyWith(isLoading: true));
         CompanyRepository().saveCompany(company: event.data);
        emit(state.copyWith(isLoading: false));
      });
    });
  }
}
