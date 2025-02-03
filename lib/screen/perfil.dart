import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:korporativ/model/modeluser.dart';
import 'package:korporativ/screen/login.dart';

class Perfil extends StatefulWidget {
  final User user;

  const Perfil({Key? key, required this.user}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  Future<void> _logout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
      const Center(child: CircularProgressIndicator()),
    );

    final logoutUrl =
    Uri.parse('https://stockcontrol.ngstoreapps.com/api/logout');
    final response = await http.post(
      logoutUrl,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${widget.user.token}"
      },
    );

    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao fazer logout: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: widget.user.imageUrl != null &&
                      widget.user.imageUrl!.startsWith('http')
                      ? NetworkImage(widget.user.imageUrl!)
                  as ImageProvider
                      : AssetImage(widget.user.imageUrl ??
                      'images/perfil.jpg'),
                  radius: 40.0,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Email: ${widget.user.email}'),
              const SizedBox(height: 10),
              Text('Id: ${widget.user.id}'),
            ],
          ),
        ),
      ),
    );
  }
}
