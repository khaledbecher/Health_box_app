import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/auth_page.dart';
import 'package:untitled/states/main_state.dart';

import 'custom_widjets/custom_texts/title_text.dart';
import 'helpers/dimensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MainState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            centered: true,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.blue,
            splash: Center(
              child: Column(
                children: [
                  TitleText(
                      text: "Health box",
                      fontSize: Dimensions.size(40),
                      color: Colors.white),
                  Container(
                    height: Dimensions.height(6),
                    width: Dimensions.width(200),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            nextScreen: AuthPage(),
            duration: 1000),
      ),
    );
  }
}
