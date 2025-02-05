import 'package:flutter/material.dart';
import 'login_page.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    awaitLoginPage();
  }

  Future<void> awaitLoginPage() async {
    Future.delayed(const Duration(seconds: 3))
        .then((_) => Navigator.of(context).pushReplacementNamed("/login"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 400,
                height: 500,
                child: Image.asset("assets/images/logo.png")),
            const SizedBox(height: 20,),
            Text('Unitel, lda.',style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.primary),),
            const SizedBox(height: 20,),
            CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)
          ],
        ),
      ),
    );
  }
}
