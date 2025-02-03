import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository extends ChangeNotifier{

  UserRepository() {
    _loadCurrentUser();
  }

  UserModel? currentUser;



  void _loadCurrentUser() {
    if (currentUser != null) {
      //currentUser = findUserById(currentUser!.id);
    }
    //debugPrint("Usuario logado - $currentUser");
  }

  void alterCurrentUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }


  Future<http.Response> fazerLoginAPI(String email, String password) {
    return http.post(Uri.parse('https://stockcontrol.ngstoreapps.com/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object?>{'email': email, 'password': password}));
  }


  Future<bool> logout(String token) async {
    final url = Uri.parse("https://stockcontrol.ngstoreapps.com/api/logout");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        debugPrint("Token válido!");
        return true;
      } else {
        debugPrint("Token inválido ou expirado: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Erro ao verificar token: $e");
      return false;
    }
  }


  Future<bool> verificarToken(String token) async {
    final url = Uri.parse("https://stockcontrol.ngstoreapps.com/api/verifyUser");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        debugPrint("Token válido!");
        return true;
      } else {
        debugPrint("Token inválido ou expirado: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Erro ao verificar token: $e");
      return false;
    }
  }





}

