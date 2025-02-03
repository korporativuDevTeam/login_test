import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:korporativ/model/modeluser.dart';
import 'package:korporativ/screen/perfil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
        const Center(child: CircularProgressIndicator()),
      );

      final loginUrl =
      Uri.parse('https://stockcontrol.ngstoreapps.com/api/login');
      final loginResponse = await http.post(
        loginUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      Navigator.of(context).pop();

      if (loginResponse.statusCode == 200) {
        final loginData = jsonDecode(loginResponse.body);
        print('Resposta da API: $loginData');

        if (loginData['status'] == 'success') {
          final userData = loginData['user'];
          final token = loginData['authorisation']['token'];
          final user = User.fromJson(userData, token: token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Perfil(user: user)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text('Erro no login: ${loginResponse.statusCode}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fun.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campo de Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: const Icon(Icons.supervised_user_circle_outlined),
                  hintText: 'nahid6996@gmail.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor, insira seu email'
                    : null,
              ),
              const SizedBox(height: 16),
              // Campo de Senha
              TextFormField(
                controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[20],
                  ),
                  child: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                ),
                hintText: 'Password :',
              ),
                obscureText: true,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor, insira sua senha'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
