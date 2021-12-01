//@dart=2.9

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PowerBIPage extends StatefulWidget {
  final email;
  final token;

  const PowerBIPage({Key key, this.email, this.token}) : super(key: key);

  @override
  _PowerBIPage createState() => _PowerBIPage();
}

class _PowerBIPage extends State<PowerBIPage> {
  @override
  void initState() {
    // loadPagina();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue,
          title: Text("Tablero BI")),
      /* Text("Tableros BI",
              style: TextStyle(fontSize: 15, color: Colors.black87)),
          centerTitle: false) */
      body: SafeArea(
        child: WebView(
          initialUrl: "https://farletza.com/farletza/powerbi/?token=" +
              widget.token +
              "&email=" +
              widget.email,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
