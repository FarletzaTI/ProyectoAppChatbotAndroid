//@dart=2.9
import 'package:app_prueba/models/consultaMovimientos.dart';
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
  final _idclienteController = TextEditingController();
  EntidadMov movimientosList;

  String numerodeRo = '';
  String ro = "";
  bool btnGrabarRuc = true;

  bool btnFinalizarCierre = true;
  bool isEnable2 = true;
  final focusNode = FocusNode();
  bool isChecked = false;

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
                  // FutureBuilder(
                  //  future: NetworkHelper.attemptConsultMovimientos(widget.solicitude.idsolicitud),
                  //   initialData: InitialData,
                  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //    return ;
                  //   },
                  // ),//Registrar Cliente
                  ExpansionTile(
                    title: Text("Registrar Cliente"),
                    leading: Icon(MdiIcons.accountPlus, color: Colors.blue),
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  activeColor: Colors.green,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value;
                                    });
                                  },
                                ),
                                Text("Registro Cliente"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      (isChecked)
                          ? Container(
                              padding: EdgeInsets.fromLTRB(15, 8, 15, 5),
                              child: TextFormField(
                                controller: _idclienteController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  labelText: "Identificacion del Cliente",
                                  hintText:
                                      "Ingrese el numero de identificacion creado",
                                ),
                              ),
                            )
                          : Container(),
                      Row(
                        children: [
                          Visibility(
                            visible: btnGrabarRuc,
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 150.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    guardarMovimientos(
                                        '${widget.solicitude.idsolicitud}',
                                        '',
                                        '8',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        _idclienteController.text,
                                        '');
                                    updateControlTareas(
                                        '8',
                                        '${widget.solicitude.idsolicitud}',
                                        "F");
                                    setState(() {
                                      btnGrabarRuc = false;
                                    });
                                  },
                                  child: Text('Guardar'),
                                ),
                              ),
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
                              // _submitRo();
                              updateControlTareas(
                                  '9', '${widget.solicitude.idsolicitud}', "F");
                              guardarMovimientos(
                                  '${widget.solicitude.idsolicitud}',
                                  '',
                                  '9',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  _roController.text);
                            },
                            child: Text("Grabar"),
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

  Future<String> guardarMovimientos(
      String idsolicitud,
      String metodo,
      String paso,
      String idagente,
      String nombagente,
      String idContactAg,
      String nombContactAg,
      String telContactAg,
      String emailContactAg,
      String estado,
      String idmotivo,
      String observacion,
      String numruc,
      String numRo) async {
    registroafectado = await NetworkHelper.attempGuardarMovimientos(
        idsolicitud,
        metodo,
        paso,
        idagente,
        nombagente,
        idContactAg,
        nombContactAg,
        telContactAg,
        emailContactAg,
        estado,
        idmotivo,
        observacion,
        numruc,
        numRo);
    return registroafectado;
  }

  Future<EntidadMov> obtenerMovimientos(String idsolicitud) async {
    movimientosList =
        await NetworkHelper.attemptConsultMovimientos(idsolicitud);
    return movimientosList;
  }
}
