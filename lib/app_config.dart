//Provider folder for mutable data
//Define a provider for a specific class, for manage data mutable

import 'package:flutter_riverpod/flutter_riverpod.dart';

final appConfigProvider = Provider<AppConfig>((ref){
  return AppConfig(
      appName: "Riverpod Example",
      apiUrl: "http://ep.example.com"
  );
});

class AppConfig{
  final String appName;
  final String apiUrl;

  AppConfig({required this.appName, required this.apiUrl});
}