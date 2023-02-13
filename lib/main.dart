import 'package:flutter/material.dart';
import 'package:to_do_bloc/presentation/screens/home_screen.dart';
import 'package:to_do_bloc/routes.dart';

void main() {
  runApp(MyApp(routes : Routes()));
}

class MyApp extends StatelessWidget {
  final Routes routes;
  const MyApp({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => routes.onGenerateRoute(settings),
      initialRoute: HomeScreen.route,
    );
  }
}
