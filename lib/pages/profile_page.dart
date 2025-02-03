import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/user_repository.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserRepository>(context);
    String errorMessage = "";

    return
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center
                ,
                children: [
                  Container(
                      width: 300,
                      height: 300,
                      child: Image.asset("assets/images/logo.png", )),
                  Container(

                    child: Column(
                    children: [
                      Text('Nome : ${userProvider.currentUser?.name}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary)),
                      SizedBox(height: 20),
                      Text('E-mail: ${userProvider.currentUser?.email}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal , color: Theme.of(context).colorScheme.primary)),
                      SizedBox(height: 40),
                    ],
                  ),),

                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(onPressed: () async {
                         if(await userProvider.logout(userProvider.currentUser!.token)) {
                           Navigator.of(context).pushReplacementNamed("/login");
                         } else{
                           errorMessage="ERRO AO FAZER LOGOUT";
                           errorMessage="ERRO AO FAZER LOGOUT";
                         }
                        }, child: Text('Logout',style: TextStyle(fontSize: 18)),),
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
                ],
              ),
            )));




  }
}
