import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = "";


  @override
  Widget build(BuildContext context) {
    final UserRepository user = UserRepository();
    final userProvider = Provider.of<UserRepository>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                    style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 40,),
                TextFormField(controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'The E-mail can not be empty!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'The Password can not be empty!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30,),

                Row(
                  children: [
                    Expanded(
                      child:
                      ElevatedButton(onPressed: () async {
                        if(formKey.currentState!.validate()){
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  UserModel? usuarioModel = UserModel.fromMap(jsonDecode((await user.fazerLoginAPI(email, password)).body));
                                  userProvider.alterCurrentUser(usuarioModel);
                                  if(await userProvider.verificarToken(userProvider.currentUser!.token)){
                                    Navigator.of(context).pushReplacementNamed("/profile");
                                  }else{
                                    errorMessage="ERRO AO FAZER LOGIN";
                                  }

                        }
                        }, child: Text('Login',style: TextStyle(fontSize: 18)),),
                    ),
                  ],
                ),



                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}



class ExitPage extends StatelessWidget {
  const ExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Exit Page',style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.primary),),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed("/login");
            }, child: Text('Go to Login page',style: TextStyle(fontSize: 18))),

          ],
        ),
      ),
    );

  }
}

