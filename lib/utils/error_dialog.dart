import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:flutter/material.dart';

void errorDailog(BuildContext context,CustomError e){
   showDialog(context: context, builder: (context) {
      return AlertDialog(

        title: Text(e.code),
        content: Text('${e.plugin}\n${e.messgae}'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Ok'))
        ],
      );
  },);
}