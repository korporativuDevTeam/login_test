import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'models/post_model.dart';

final postProvider = FutureProvider<List<Post>>((ref) async{
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  if(response.statusCode==200){
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json)=> Post.fromJson(json)).toList();

  }else{
    throw Exception('Failed to load data');
  }
});