import 'package:flutter/material.dart';
import 'package:flutter_app/pages/counter_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/isolate_test_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/post_page.dart';
import 'package:flutter_app/pages/profile_page.dart';
import 'package:flutter_app/pages/splash_page.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {


  /*runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserRepository()),
      ],
      child:  const MyApp() ,
    ),
  );*/

  runApp(
    ProviderScope(child: MyApp(),)
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
      initialRoute: '/post',
      routes: {
        '/splash':(context) =>  SplashPage(),
        '/login': (context) =>  LoginPage(),
        '/profile': (context) =>  ProfilePage(),
        '/home' : (context) =>HomePage(),
        '/counter':(context) => CounterPage(),
        '/post':(context) => PostPage(),
        '/isolate':(context)=> IsolateTestPage(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
