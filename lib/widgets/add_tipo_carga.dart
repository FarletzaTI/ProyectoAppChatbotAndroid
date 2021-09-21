// @dart=2.9
import 'package:app_prueba/const/gradient.dart';
import 'package:app_prueba/form.dart';
import 'package:app_prueba/models/carga.dart';
import 'package:app_prueba/models/contenedor.dart';
import 'package:app_prueba/search_items.dart';
import 'package:app_prueba/services/database.dart';
import 'package:app_prueba/widgets/listViewCarga.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'listViewTile.dart';

class InfoTipoCarga extends StatefulWidget {
  const InfoTipoCarga({Key key}) : super(key: key);

  @override
  _InfoTipoCargaState createState() => _InfoTipoCargaState();
}

class _InfoTipoCargaState extends State<InfoTipoCarga> {
  final _cantidadController = TextEditingController(text: "1");
  final _tempController = TextEditingController();
  final _humedadController = TextEditingController();
  final _ventController = TextEditingController();
  List<DropdownMenuItem<Contenedor>> _dropdownMenuItems3;
  Contenedor _selectedContenedor;
  String tipoCarga = "";
  String cantidad = "1";
  String ventilacion = "";
  String temperatura = "";
  String humedad = "";
  bool visible = false;
  final ButtonStyle style = ElevatedButton.styleFrom(
    primary: primaryColor,
  );

  @override
  void initState() {
    iniciarControles();

    super.initState();
  }

  iniciarControles() async {
    List<Contenedor> contenedores = await DBProvider.db.getAllContenedors();
    _dropdownMenuItems3 = Contenedor.buildDropdownMenuItems(contenedores);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Información de la carga",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.black12,
                        offset: Offset(0, 3)),
                  ]),
              child: Column(
                children: _buildFormChildren(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormChildren(BuildContext context) {
    return [
      LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: constraints.maxWidth * 0.60,
                        child: _dropDownMenu3()),
                    VerticalDivider(
                      color: Colors.black87,
                      width: 1,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.39,
                      child: CustomTextForm(
                        controller: _cantidadController,
                        changed: (input) => {cantidad = input},
                        hintText: 'Cant',
                        prefixIcon: MdiIcons.numeric,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: visible,
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.indigo[100],
                        height: 0.5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: constraints.maxWidth * 0.60,
                            child: CustomTextForm(
                              controller: _tempController,
                              changed: (input) => {temperatura = input},
                              hintText: 'temp',
                              prefixIcon: MdiIcons.temperatureCelsius,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.indigo[100],
                        height: 0.5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: constraints.maxWidth * 0.50,
                            child: CustomTextForm(
                              controller: _humedadController,
                              changed: (input) => {humedad = input},
                              hintText: 'humedad',
                              prefixIcon: MdiIcons.waterPercent,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.black87,
                            width: 1,
                          ),
                          Container(
                            width: constraints.maxWidth * 0.49,
                            child: CustomTextForm(
                              controller: _ventController,
                              changed: (input) => {ventilacion = input},
                              hintText: 'Vent',
                              prefixIcon: MdiIcons.fan,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              listaCarga.add(
                Carga(
                    tipoCarga: _selectedContenedor.id,
                    descripcion: _selectedContenedor.nombre,
                    cantidad: int.parse(_cantidadController.text),
                    temperatura:
                        temperatura != "" ? double.parse(temperatura) : null,
                    ventilacion:
                        ventilacion != "" ? double.parse(ventilacion) : null,
                    humedad: humedad != "" ? double.parse(humedad) : null),
              );
              _cantidadController.text = "1";
              _selectedContenedor = null;
              _tempController.clear();
              _ventController.clear();
              _humedadController.clear();
              visible = false;
              FocusScope.of(context).requestFocus(new FocusNode());
            });
          },
          child: const Text('Añadir Contenedor'),
          style: style,
        ),
      ),
      Container(
        height: 200,
        child: ListViewBuilder<Carga>(
          lista: listaCarga,
          itemBuilder: (context, carga) => Dismissible(
              key: Key('job-${carga.tipoCarga}'),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => {listaCarga.remove(carga)},
              child: CargaListTile(
                carga: carga,
                onTap: () {},
              )),
        ),
      )
    ];
  }

  Widget _dropDownMenu3() {
    return DropdownButtonFormField(
      hint: Text("Tipo de Carga"),
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.toolboxOutline),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(16),
      ),
      value: _selectedContenedor,
      items: _dropdownMenuItems3,
      onChanged: (selectedElement) {
        setState(() {
          _selectedContenedor = selectedElement;
          if (_selectedContenedor.id == 8 || _selectedContenedor.id == 9) {
            visible = true;
          } else {
            visible = false;
          }
        });
      },
    );
  }
}
