import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelapp/screens/home_screen/home_screen.dart';
import 'package:travelapp/screens/login_screen/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4dbedc),
        accentColor: const Color(0xFFD8ECF1),
        scaffoldBackgroundColor: const Color(0xFFf9f9f9),
      ),
      home: LoginScreen(),
    );
  }
}
