import 'package:get_it/get_it.dart';
import 'package:lab5/Provider.dart';

final getIt = GetIt.instance;

setup() {
  getIt.registerSingleton<Provider>(Provider());
}