import 'package:flutter/material.dart';
import 'package:posts_app_with_test/app/app.dart';
import 'package:posts_app_with_test/bootstrap.dart';
import 'package:posts_app_with_test/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocators();
  await bootstrap(() => const App());
}
