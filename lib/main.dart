import 'package:fake_chat/route.dart';
import 'package:fake_chat/splash_screen.dart';
import 'package:fake_chat/view/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Chat',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: MColors.naver_green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routers.generateRoute,
      home: SplashScreen(),
    );
  }
}
