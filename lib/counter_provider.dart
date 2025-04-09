import 'package:flutter_riverpod/flutter_riverpod.dart';
final counterStateProvider = StateProvider<int>((ref){
  //defines default value of counterProvider
  return 0;
});