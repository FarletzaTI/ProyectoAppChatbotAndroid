//@dart=2.9
import 'package:app_prueba/models/solicitudes_Customer.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../form.dart';

class RegistroCustomersPage extends StatefulWidget {
  final Solicitudes solicitude;

  const RegistroCustomersPage({Key key, this.solicitude}) : super(key: key);

  @override
  _RegistroCustomersPage createState() => _RegistroCustomersPage();
}

class _RegistroCustomersPage extends State<RegistroCustomersPage> {
  String registroafectado = "";
  ButtonState stateTextWithIcon = ButtonState.idle;
  final _roController = TextEditingController();
  String numerodeRo = '';
  String ro = "";
  bool btnFinalizarCierre = true;
  bool isEnable2 = true;
  final focusNode = FocusNode();
  bool isChecked = false;
  String _value = "";

  Future<bool> _onBackPressed() {
    focusNode.unfocus();
    //FocusScope.of(context).unfocus();
    Navigator.of(context).pop(true);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registro"),
        ),
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Registrar Cliente
                  ExpansionTile(
                    title: Text("Registrar Cliente"),
                    leading: Icon(MdiIcons.accountPlus, color: Colors.blue),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value;
                                          if (value) {
                                            Container(
                                              child: CustomTextForm(
                                                function: (input) =>
                                                    {_value = input},
                                                changed: (value) =>
                                                    {_value = value},
                                                hintText:
                                                    'Ingrese el Ruc del cliente',
                                                prefixIcon: MdiIcons.textBox,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    Text("Registro Cliente"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //CREAR RO
                  ExpansionTile(
                    title: Text("Crear Ro"),
                    leading: Icon(MdiIcons.pencilBox, color: Colors.blue),
                    children: [
                      Text("Ro asignado: $numerodeRo "),
                      CustomTextForm(
                        controller: _roController,
                        focusNode: focusNode,
                        changed: (value) => {ro = value},
                        function: (input) => {ro = input},
                        hintText: 'Ingrese el Ro',
                        prefixIcon: MdiIcons.noteTextOutline,
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /* Container(
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _submitRo();
                                  /*     updateControlTareas('9',
                                      '${widget.solicitude.idsolicitud}', "P");
                                */
                                });
                              },
                              child: Text("Actualizar Ro"),
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                          ), */
                          SizedBox(
                            height: 20,
                            width: 20.0,
                          ),
                          Visibility(
                              //   visible: _solicitudeModel.opcFinalizar,
                              child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                isEnable2 = false;
                                btnFinalizarCierre = false;
                              });
                              _submitRo();
                              updateControlTareas(
                                  '9', '${widget.solicitude.idsolicitud}', "F");

                              /*   updateControlTareas('9',
                                      '${widget.solicitude.idsolicitud}', "F");
                                  _solicitudeModel = _solicitudeModel.copyWith(
                                      opcFinalizar: false);
                                  contactProvider.setSolicitude(_solicitudeModel);
                                */
                            },
                            child: Text("Finalizar"),
                            color: Colors.blue,
                            textColor: Colors.white,
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> updateControlTareas(
      String idtarea, String idsolicitud, String estado) async {
    registroafectado = await NetworkHelper.attempUpdatecontrolTareas(
        idtarea, idsolicitud, estado);
    return registroafectado;
  }

  _submitRo() async {
    try {
      numerodeRo = await NetworkHelper.attempUpdateNumeroRo(
          ro, '${widget.solicitude.idsolicitud}');
      /*  _solicitudeModel = _solicitudeModel.copyWith(numRo: _roController.text);
      contactProvider.setSolicitude(_solicitudeModel); */

      setState(() {
        stateTextWithIcon = ButtonState.success;
      });
    } catch (e) {
      stateTextWithIcon = ButtonState.fail;
    }
  }
}
