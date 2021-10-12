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

  bool resultadoValidacionSRI = true;
  String mostrarTextoSRI = "";

  bool resultadoValidacionLC = true;
  String mostrarTextoLC = "";

  bool resultadoValidacionFJ = false;
  String mostrarTextoFJ = "";
  bool finishSRI = false;
  bool finishFJ = false;
  bool finishLC = false;

  RespuestaConsulta resp_ConsSRI;
  RespuestaConsulta resp_ConsFJ;
  RespuestaConsulta resp_ConsLC;

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
                              consultaListaClinton(myControllerRUC.text,
                                  myControllerNameSocial.text);
                              consultafuncionJudicial(myControllerRUC.text,
                                  myControllerNameSocial.text);
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
                                myControllerRUC.text = "";
                                myControllerNameSocial.text = "";
                                resultadoValidacionSRI = true;
                                mostrarTextoSRI = "";
                                resultadoValidacionLC = false;
                                mostrarTextoLC = "";
                                resultadoValidacionFJ = false;
                                mostrarTextoFJ = "";
                                finishFJ = false;
                                finishLC = false;
                                finishSRI = false;
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

                  //CONSULTA DE OFAC SDN LIST
                  if (v_resultado == true)
                    if (finishLC == true)
                      IgnorePointer(
                        ignoring:
                            (resultadoValidacionLC == false) ? false : true,
                        child: ExpansionTileCard(
                          expandedTextColor: Colors.blue,
                          baseColor: Colors.blueAccent[50],
                          expandedColor: Colors.red[50],
                          trailing: (resultadoValidacionLC == false)
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: LiteRollingSwitch(
                                    value: false,
                                    textOn: "X",
                                    colorOn: Colors.redAccent[700],
                                    iconOn: Icons.flag,
                                    textSize: 16.0,
                                    onChanged: (bool state) {},
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 10),
                                  child: LiteRollingSwitch(
                                    value: true,
                                    textOn: "Ok",
                                    colorOn: Colors.greenAccent[700],
                                    iconOn: Icons.check,
                                    textSize: 16.0,
                                    onChanged: (bool state) {},
                                  ),
                                ),
                          title: Text("OFAC SDN LIST"),
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
                                  mostrarTextoLC,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Cargando Lista OFAC SDN")
                          ],
                        ),
                      ),

                  //CONSULTA DEL SRI
                  if (v_resultado == true)
                    if (finishSRI == true)
                      IgnorePointer(
                        ignoring:
                            (resultadoValidacionSRI == false) ? false : true,
                        child: ExpansionTileCard(
                          expandedTextColor: Colors.blue,
                          baseColor: Colors.blueAccent[50],
                          expandedColor: Colors.red[50],
                          trailing: (resultadoValidacionSRI == false)
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: LiteRollingSwitch(
                                    value: false,
                                    textOn: "X",
                                    colorOn: Colors.redAccent[700],
                                    iconOn: Icons.flag,
                                    textSize: 16.0,
                                    onChanged: (bool state) {},
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 10),
                                  child: LiteRollingSwitch(
                                    value: true,
                                    textOn: "Ok",
                                    colorOn: Colors.greenAccent[700],
                                    iconOn: Icons.check,
                                    textSize: 16.0,
                                    onChanged: (bool state) {},
                                  ),
                                ),
                          title: Text("SRI"),
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
                                  mostrarTextoSRI,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Cargando SRI")
                          ],
                        ),
                      ),

                  //CONSULTA DE FUNCION JUDICIAL
                  if (v_resultado == true)
                    if (finishFJ == true)
                      IgnorePointer(
                        ignoring:
                            (resultadoValidacionFJ == false) ? false : true,
                        child: ExpansionTileCard(
                          expandedTextColor: Colors.blue,
                          baseColor: Colors.blueAccent[50],
                          expandedColor: Colors.red[50],
                          trailing: (resultadoValidacionFJ == false)
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: LiteRollingSwitch(
                                    value: false,
                                    textOn: "X",
                                    colorOn: Colors.redAccent[700],
                                    iconOn: Icons.flag,
                                    textSize: 16.0,
                                    onChanged: (bool state) {},
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 10),
                                  child: LiteRollingSwitch(
                                    value: true,
                                    textOn: "Ok",
                                    colorOn: Colors.greenAccent[700],
                                    iconOn: Icons.check,
                                    textSize: 16.0,
                                    onChanged: (bool state) {},
                                  ),
                                ),
                          title: Text("FUNCION JUDICIAL"),
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
                                  mostrarTextoFJ,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Cargando Funcion Judicial...")
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<RespuestaConsulta> consultasri(String ruc, String nombre) async {
    resp_ConsSRI = await NetworkHelper.attemptConsultaSRI(ruc, nombre);

    resp_ConsSRI.listaMensajes.forEach((String texto) {
      setState(() {
        mostrarTextoSRI = texto + '\n';
      });
    });
    setState(() {
      finishSRI = true;
      resultadoValidacionSRI = resp_ConsSRI.resultadoValidacion;
    });
  }

  Future<RespuestaConsulta> consultaListaClinton(
      String ruc, String nombre) async {
    resp_ConsLC = await NetworkHelper.attemptConsultaListCLinton(ruc, nombre);

    resp_ConsLC.listaMensajes.forEach((String texto) {
      setState(() {
        mostrarTextoLC = mostrarTextoLC + " " + texto;
      });
    });
    setState(() {
      finishLC = true;
      resultadoValidacionLC = resp_ConsLC.resultadoValidacion;
    });
  }

  Future<RespuestaConsulta> consultafuncionJudicial(
      String ruc, String nombre) async {
    resp_ConsFJ =
        await NetworkHelper.attemptConsultaFuncionJudicial(ruc, nombre);

    resp_ConsFJ.listaMensajes.forEach((String texto) {
      setState(() {
        mostrarTextoFJ = texto + '\n';
      });
    });
    setState(() {
      finishFJ = true;
      resultadoValidacionFJ = resp_ConsFJ.resultadoValidacion;
    });
  }
}
