// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:trackify/core/service/auth_service.dart' as _i7;
import 'package:trackify/core/service/firestore_service.dart' as _i4;
import 'package:trackify/features/auth/domain/login_service.dart' as _i8;
import 'package:trackify/features/auth/domain/sign_up_cubit.dart' as _i9;
import 'package:trackify/features/company/data/company.dart' as _i5;
import 'package:trackify/features/company/data/repository/company_repository.dart'
    as _i3;
import 'package:trackify/features/company/domain/company_storage_service.dart'
    as _i6;

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
    gh.factory<_i4.FirestoreService<_i5.Company>>(
        () => _i6.CompanyStorageService());
    gh.factory<_i7.IAuthService>(() => _i8.LoginService());
    gh.factory<_i9.SignUpCubit>(() => _i9.SignUpCubit(gh<_i7.IAuthService>()));
    return this;
  }
}
