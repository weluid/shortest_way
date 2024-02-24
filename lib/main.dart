import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shortest_way/utils/app_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runAppWithBloc();
}