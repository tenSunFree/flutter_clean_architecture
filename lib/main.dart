import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/common/app.dart';
import 'common/dependency_injection.dart';

void main() {
  DependencyInjector().loadModules();
  runApp(App());
}
