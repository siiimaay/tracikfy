// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:trackify/core/service/auth_service.dart' as _i11;
import 'package:trackify/core/service/firestore_service.dart' as _i7;
import 'package:trackify/features/auth/domain/login_service.dart' as _i12;
import 'package:trackify/features/auth/domain/sign_up_cubit.dart' as _i14;
import 'package:trackify/features/candidate/bloc/employee_bloc.dart' as _i5;
import 'package:trackify/features/candidate/data/employee_repository.dart'
    as _i6;
import 'package:trackify/features/candidate/domain/employee_storage_service.dart'
    as _i8;
import 'package:trackify/features/company/data/repository/company_repository.dart'
    as _i4;
import 'package:trackify/features/company/domain/comp_storage_service.dart'
    as _i9;
import 'package:trackify/features/company/presentation/company_detail_bloc/company_detail_bloc.dart'
    as _i3;
import 'package:trackify/features/meeting/data/repository/interview_repository.dart'
    as _i13;
import 'package:trackify/features/meeting/domain/meeting_storage_service.dart'
    as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.CompanyDetailBloc>(() => _i3.CompanyDetailBloc());
    gh.factory<_i4.CompanyRepository>(() => _i4.CompanyRepository());
    gh.factory<_i5.EmployeeBloc>(() => _i5.EmployeeBloc());
    gh.factory<_i6.EmployeeRepository>(() => _i6.EmployeeRepository());
    gh.factory<_i7.FirestoreService<dynamic>>(
      () => _i8.CompanyStorageService(),
      instanceName: 'employee_firestore',
    );
    gh.factory<_i7.FirestoreService<dynamic>>(
      () => _i9.CompanyStorageService(),
      instanceName: 'company_firestore',
    );
    gh.factory<_i7.FirestoreService<dynamic>>(
      () => _i10.MeetingStorageService(),
      instanceName: 'interview_firestore',
    );
    gh.factory<_i11.IAuthService>(() => _i12.LoginService());
    gh.factory<_i13.InterviewRepository>(() => _i13.InterviewRepository());
    gh.factory<_i14.SignUpCubit>(
        () => _i14.SignUpCubit(gh<_i11.IAuthService>()));
    return this;
  }
}
