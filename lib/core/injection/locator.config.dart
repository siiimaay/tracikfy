// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:trackify/core/service/auth_service.dart' as _i4;
import 'package:trackify/features/auth/domain/login_service.dart' as _i5;
import 'package:trackify/features/auth/domain/sign_up_cubit.dart' as _i6;
import 'package:trackify/features/company/data/repository/company_repository.dart'
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
    gh.factory<_i3.CompanyRepository>(() => _i3.CompanyRepository());
    gh.factory<_i4.IAuthService>(() => _i5.LoginService());
    gh.factory<_i6.SignUpCubit>(() => _i6.SignUpCubit(gh<_i4.IAuthService>()));
    return this;
  }
}
