
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/core/injection/locator.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
void setupInjection() {
  getIt.init();
}
