import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_way/bloc/process_page_bloc/process_bloc.dart';
import '../app.dart';
import '../bloc/main_page_bloc/main_page_bloc.dart';

void runAppWithBloc() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainPageBloc()),
        BlocProvider(create: (_) => ProcessBloc()),
      ],
      child: const App(),
    ),
  );
}
