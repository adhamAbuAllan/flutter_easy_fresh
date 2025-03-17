import 'package:get_it/get_it.dart';

import 'coordination.dart';
// import 'package:ween_blaqe/features/user/studnet/from_master_home_to_show_more/new_master_home.dart';


final GetIt getIt = GetIt.instance;

//@injectableInit
Future<void> configureInjection() async {

  getIt.registerLazySingleton(
    () => AppDimension(),
  );
}

