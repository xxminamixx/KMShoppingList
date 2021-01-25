import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('設定',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
      body: Container(
        child: Center(
          child: Text('準備中',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          )),
      ),
    );
  }
}