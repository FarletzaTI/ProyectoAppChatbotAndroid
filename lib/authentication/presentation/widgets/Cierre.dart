// @dart=2.9
//import 'dart:html';

import 'package:app_prueba/const/gradient.dart';
import 'package:app_prueba/models/actualizaRo.dart';
import 'package:app_prueba/models/motivosrechazo.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../form.dart';

class MyStatefulWidget extends StatefulWidget {
  final List<ListMotivo> list_item;
  final String idsolicitud;
  const MyStatefulWidget({Key key, this.list_item, @required this.idsolicitud})
      : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

enum SingingCharacter { aprobada, rechazada }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SingingCharacter _character = SingingCharacter.aprobada;
  List<DropdownMenuItem<ListMotivo>> listarechazo;
  ButtonState stateTextWithIcon = ButtonState.idle;
  String _value = "";
  bool btnAceptar = true;

  bool aprobado = false;
  bool isEnable = true;

  ListMotivo _selectedMotivo;
  @override
  void initState() {
    listarechazo = armarLista(widget.list_item);
    _selectedMotivo = listarechazo[0].value;
    aprobado = true;
    super.initState();
  }

  List<DropdownMenuItem<ListMotivo>> armarLista(List<ListMotivo> lista) {
    List<DropdownMenuItem<ListMotivo>> items = [];
    for (ListMotivo motivo in lista) {
      items.add(
        DropdownMenuItem(
          value: motivo,
          child: Text(
            motivo.descripcion,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: primaryColor),
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Aprobado'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.aprobada,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                _character = value;
                _selectedMotivo = listarechazo[0].value;
                aprobado = true;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Rechazada'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.rechazada,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        _character == SingingCharacter.rechazada
            ? Container(
                padding: EdgeInsets.all(20),
                child: DropdownButtonFormField(
                  value: _selectedMotivo,
                  items: listarechazo,
                  onChanged: (value) {
                    setState(() {
                      _selectedMotivo = value;
                    });
                  },
                  isDense: true,
                  isExpanded: true,
                  elevation: 15,
                ),
              )
            : Container(),
        _selectedMotivo.descripcion.trim().toLowerCase().contains("otros")
            ? Container(
                child: CustomTextForm(
                  function: (input) => {_value = input},
                  changed: (value) => {_value = value},
                  hintText: 'Ingrese el motivo de rechazo',
                  prefixIcon: MdiIcons.textBox,
                  keyboardType: TextInputType.text,
                ),
              )
            : Container(),
        Visibility(
          visible: btnAceptar,
          child: Container(
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  isEnable = false;
                  btnAceptar = false;
                });

                _actualziarTarea('1', 'F');
                if (_character == SingingCharacter.aprobada) {
                  _submitMotivo('', widget.idsolicitud, 'A', '');
                } else {
                  _submitMotivo(_value, widget.idsolicitud, 'R',
                      _selectedMotivo.idmotivo.toString());
                }
              },
              child: Text("Aceptar"),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _submitMotivo(
      String motivo, String idsolicitud, String estado, String idmotivo) async {
    try {
      await NetworkHelper.attempUpdateMotivoRechazo(
          motivo, idsolicitud, idmotivo, '7', estado);
      setState(() {
        stateTextWithIcon = ButtonState.success;
        isEnable = true;
      });
    } catch (e) {
      setState(() {
        stateTextWithIcon = ButtonState.fail;
        isEnable = true;
      });
    }
  }

  _actualziarTarea(
    String idsolicitud,
    String estado,
  ) async {
    try {
      await NetworkHelper.attempUpdatecontrolTareas('7', idsolicitud, estado);
      setState(() {
        stateTextWithIcon = ButtonState.success;
      });
    } catch (e) {
      stateTextWithIcon = ButtonState.fail;
    }
  }
}
