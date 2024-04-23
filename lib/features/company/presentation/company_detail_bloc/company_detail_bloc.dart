import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/injection/locator.dart';
import '../../../../core/service/firestore_service.dart';
import '../../data/company.dart';

part 'company_detail_event.dart';

part 'company_detail_state.dart';

part 'company_detail_bloc.freezed.dart';

class CompanyDetailBloc extends Bloc<CompanyDetailEvent, CompanyDetailState> {

  CompanyDetailBloc() : super(CompanyDetailState.initial()) {
    on<CompanyDetailEvent>((event, emit) {
      event.map(save: (event) {
        emit(state.copyWith(isLoading: true));
        companyStorageRepository.saveRecord(data: event.data);
        emit(state.copyWith(isLoading: false));
      });
    });
  }
}
