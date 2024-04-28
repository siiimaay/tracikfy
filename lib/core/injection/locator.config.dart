// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:trackify/core/service/auth_service.dart' as _i6;
import 'package:trackify/core/service/firestore_service.dart' as _i4;
import 'package:trackify/features/auth/domain/login_service.dart' as _i7;
import 'package:trackify/features/auth/domain/sign_up_cubit.dart' as _i8;
import 'package:trackify/features/company/domain/comp_storage_service.dart'
    as _i5;
import 'package:trackify/features/company/presentation/company_detail_bloc/company_detail_bloc.dart'
    as _i3;

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
    gh.factory<_i4.FirestoreService<dynamic>>(
      () => _i5.CompanyStorageService(),
      instanceName: 'company_firestore',
    );
    gh.factory<_i6.IAuthService>(() => _i7.LoginService());
    gh.factory<_i8.SignUpCubit>(() => _i8.SignUpCubit(gh<_i6.IAuthService>()));
    return this;
  }
}
