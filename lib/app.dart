import 'package:flutter/material.dart';
import 'package:shortest_way/ui/main_page/main_page.dart';


class App extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  const App({super.key});

  static BuildContext get globalContext => navigatorKey.currentState!.context;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: App.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'app',
      navigatorKey: App.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
      home: const MainPage(),
    );
  }
}
