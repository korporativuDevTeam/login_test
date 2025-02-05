import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/profile_page.dart';
import 'package:flutter_app/pages/splash_page.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:provider/provider.dart';

void main() {


  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserRepository()),
      ],
      child:  const MyApp() ,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash':(context) =>  SplashPage(),
        '/login': (context) =>  LoginPage(),
        '/profile': (context) =>  ProfilePage(),
        //login(email e senha) - admin@gmail.com e 123456
        //verif (barear token, envia o token
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
