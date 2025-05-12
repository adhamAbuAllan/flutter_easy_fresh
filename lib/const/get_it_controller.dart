import 'package:get_it/get_it.dart';

import 'coordination.dart';


final GetIt getIt = GetIt.instance;

//@injectableInit
Future<void> configureInjection() async {

  getIt.registerLazySingleton(
    () => AppDimension(),
  );
}

