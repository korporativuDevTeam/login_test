import 'package:flutter/material.dart';
import 'package:flutter_app/app_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(appConfigProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(appConfig.appName),
      ),
      body: Center(
        child: Text(appConfig.apiUrl),
      ),
    );
  }
}
