import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/core/provider/validation_provider.dart';

var myInjection = GetIt.instance;

Future<void> init() async {
  myInjection.registerLazySingleton(
    () => MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ValidationProvider())],
    ),
  );
}
