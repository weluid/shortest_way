import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_page_bloc/main_page_bloc.dart';
import '../loading_screen.dart';
import 'main_page_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (BuildContext context, state) {
        if (state is MainPageInitial) {
          return const MainPageView();
        } else if (state is SuccessfulLoadingLoadingState) {
          return const MainPageView();
        } else if (state is FailedLoadingLoadingState) {
          return  MainPageView(errorMessage: state.errorMessage);
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
