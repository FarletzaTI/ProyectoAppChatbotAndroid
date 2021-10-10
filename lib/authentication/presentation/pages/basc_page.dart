//@dart=2.9

import 'package:app_prueba/authentication/presentation/pages/consultaAPI_Basc.dart';
import 'package:app_prueba/authentication/presentation/widgets/mostrar_respuesta.dart';
import 'package:app_prueba/models/EntidadesBASC/entidadFuncionJudicial.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fswitch/fswitch.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../form.dart';

class opcBascPages extends StatefulWidget {
  opcBascPages({Key key}) : super(key: key);

  @override
  _BascPagestate createState() => _BascPagestate();
}

class _BascPagestate extends State<opcBascPages> {
  int customerId = 0;
  String _ruc = "";
  String _razonsocial = "";
  bool v_resultado = false;
  final myControllerRUC = TextEditingController();
  final myControllerNameSocial = TextEditingController();
  bool resultadoValidacion = false;

  List<RespuestaConsulta> resp_ConsSRI = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Basc"),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 5),
                      child: TextFormField(
                        controller: myControllerRUC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          labelText: "Ruc",
                          hintText: "Ingrese el Ruc",
                        ),
                      )),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 5),
                    child: TextFormField(
                      controller: myControllerNameSocial,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        labelText: "Nombre o Razon Social",
                        hintText: "Ingrese Nombre o Razon Social",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                v_resultado = true;
                              });
                              consultasri(myControllerRUC.text,
                                  myControllerNameSocial.text);
                              /*  consultaAPIBascPage(
                                    myControllerRUC.text, myControllerNameSocial.text); */
                            },
                            child: Text('Consultar'),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                v_resultado = false;
                              });
                            },
                            child: Text('Limpiar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (v_resultado == true)
                    ExpansionTileCard(
                      baseColor: Colors.green[50],
                      expandedColor: Colors.red[50],
                      trailing: (resultadoValidacion == true)
                          ? LiteRollingSwitch(
                              //initial value
                              value: false,
                              textOn: 'Disponible',
                              //textOff: 'ocupado',
                              colorOn: Colors.greenAccent[700],
                              //colorOff: Colors.redAccent[700],
                              iconOn: Icons.check,
                              // iconOff: Icons.remove_circle_outline,
                              textSize: 16.0,
                              onChanged: (bool state) {},
                            )
                          : LiteRollingSwitch(
                              //initial value
                              value: true,
                              //textOn: 'disponible',
                              textOff: 'X',
                              //colorOn: Colors.greenAccent[700],
                              colorOff: Colors.redAccent[700],
                              // iconOn: Icons.done,
                              iconOff: Icons.flag,
                              textSize: 16.0,
                              onChanged: (bool state) {},
                            ),
                      /*  ? FSwitch(
                              //true
                              open: resultadoValidacion,
                              onChanged: (v) {},
                              closeChild: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.black,
                              ),
                              openChild: Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.black,
                              ),
                              openColor: Colors.green,
                            )
                          : FSwitch(
                              //false
                              open: resultadoValidacion,
                              onChanged: (v) {},
                              closeChild: Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.black,
                              ), 
                            ), */
                      title: Text("Lista Clinton"),
                      children: <Widget>[
                        Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "Lista de Mensajes que devuelve el api " +
                                  '\n' +
                                  "Lista de Mensajes que devuelve el api ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    )
                  /* if (v_resultado == true)
                         */
                  else
                    Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<RespuestaConsulta>> consultasri(String ruc, String nombre) async {
    resp_ConsSRI = await NetworkHelper.attemptConsultaSRI(ruc, nombre);
  }
}
