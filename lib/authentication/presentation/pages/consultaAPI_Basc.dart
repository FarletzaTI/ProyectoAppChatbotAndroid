//@dart=2.9
import 'package:app_prueba/models/EntidadesBASC/entidadFuncionJudicial.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class consultaAPIBascPage extends StatefulWidget {
  consultaAPIBascPage(
    String ruc,
    String nombresocial, {
    Key key,
  }) : super(key: key);

  @override
  _ConsultaAPIBascPageState createState() => _ConsultaAPIBascPageState();
}

class _ConsultaAPIBascPageState extends State<consultaAPIBascPage> {
  String numRuc;
  String nombresocial;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text("Lista SRI"),
        //leading: Icon(MdiIcons.ballotOutline, color: Colors.blue),
        children: [
          Container(
            child: FutureBuilder(
                future: NetworkHelper.attemptConsultaSRI(numRuc, nombresocial),
                // ignore: missing_return
                builder: (BuildContext context,
                    AsyncSnapshot<RespuestaConsulta> snapshot) {}),
          )
        ]);
    /* Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Lista Clinton",
                ),
              ),
            ],
          ),
          Divider(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("SRI"),
              )
            ],
          ),
          Divider(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Funcion Judicial"),
              )
            ],
          ),
        ],
      ),
    );
     */
  }

  Widget _hiperDetalles(BuildContext context) {
    return new RichText(
      text: new TextSpan(
        children: [
          new TextSpan(
            text: '',
            style: new TextStyle(color: Colors.black),
          ),
          new TextSpan(
            text: 'Ver Detalles',
            style: new TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
