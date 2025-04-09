import 'dart:isolate';

import 'package:flutter/material.dart';
class IsolateTestPage extends StatelessWidget {
  const IsolateTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        CircularProgressIndicator(),
        ElevatedButton(onPressed: (){
          countWithoutIsolate(400000000);
        }, child: Text('Start Method Without Isolate')),
        ElevatedButton(onPressed: (){
          useIsolate();
        }, child: Text('Start Method With Isolate')),
      ],
    );
  }

  int countWithoutIsolate(int interation){
    int value = 0;
    for(int i = 0;i<interation;i++) {
      value=i++;
    }
    debugPrint('$value');
    return value;
  }

  useIsolate() async{
    final ReceivePort receivePort = ReceivePort();

    try{
      await Isolate.spawn(runTask, [receivePort.sendPort,4000000000]);
    } on Object{
      debugPrint("Isolate Failed");
      receivePort.close();
    }
    final response = await receivePort.first;
    debugPrint('data Processed $response');
  }

  int runTask(List<dynamic> args){
    SendPort  resultPort = args[0];
    int value = 0;
    for(int i = 0;i<args[1];i++) {
      value=i++;
    }

    Isolate.exit(resultPort,value);
  }
}
