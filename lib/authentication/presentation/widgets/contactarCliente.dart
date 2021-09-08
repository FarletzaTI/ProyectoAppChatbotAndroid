//@dart=2.9
import 'dart:io';
import 'dart:ui';

import 'package:app_prueba/const/gradient.dart';
import 'package:app_prueba/models/agentes.dart';
import 'package:app_prueba/models/contactosagentes.dart';
import 'package:app_prueba/models/motivosrechazo.dart';
import 'package:app_prueba/models/solicitudes.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../form.dart';
import 'Cierre.dart';

class ClientDetailPage extends StatefulWidget {
  final Solicitude solicitude;

  const ClientDetailPage({Key key, this.solicitude}) : super(key: key);

  @override
  _ClientDetailPageState createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  bool opcion2 = true;
  bool opcion3 = true;
  bool opcion4 = true;
  String agenteSelected = '';
  List<DropdownMenuItem> listaDropDownAgentes = [];
  List<ListaAgentes> agentesList = [];

  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String lineaNg = widget.solicitude.lineaNegocio;
    String nombrePais = '';
    listaDropDownAgentes = [];
    int index = 0;

    if (lineaNg == 'E')
      nombrePais = widget.solicitude.paisDestino;
    else
      nombrePais = widget.solicitude.paisOrigen;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de Solicitud"),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Contactar prospecto / Cliente
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    "Contactar prospecto / Cliente",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(MdiIcons.account),
                  children: <Widget>[
                    Container(
                        child: RichText(
                      text: TextSpan(
                        text: 'Nombres : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: "${widget.solicitude.nombre}")
                        ],
                      ),
                    )),
                    Container(
                        child: RichText(
                      text: TextSpan(
                        text: 'Email: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: "${widget.solicitude.email}"),
                        ],
                      ),
                    )),
                    Container(
                        child: RichText(
                      text: TextSpan(
                        text: 'Telefono: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: "${widget.solicitude.telefono}"),
                        ],
                      ),
                    )),
                    Divider(
                      height: 12,
                    ),
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width - 70,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 5.5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                launch("tel://${widget.solicitude.telefono}");
                              },
                              icon: Icon(MdiIcons.phoneOutline)),
                          VerticalDivider(
                            color: Colors.black87,
                            width: 1,
                          ),
                          IconButton(
                              onPressed: () {
                                launchWhatsApp(widget.solicitude.telefono);
                              },
                              icon: Icon(MdiIcons.whatsapp)),
                          VerticalDivider(
                            color: Colors.black87,
                            width: 1,
                          ),
                          IconButton(
                              onPressed: () {
                                launch("mailto:${widget.solicitude.email}");
                              },
                              icon: Icon(MdiIcons.emailOutline))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          opcion2 = false;
                          setState(() {});
                        },
                        child: Text("Siguiente"),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                //Solicitar informacion de Embarque
                IgnorePointer(
                  ignoring: opcion2,
                  child: ExpansionTile(
                    title: Text("Solicitar informacion de Embarque"),
                    leading: Icon(MdiIcons.airplane),
                    children: [
                      Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width - 70,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0,
                                  blurRadius: 5.5)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  launch("tel://${widget.solicitude.telefono}");
                                },
                                icon: Icon(MdiIcons.phoneOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launchWhatsApp(widget.solicitude.telefono);
                                },
                                icon: Icon(MdiIcons.whatsapp)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launch("mailto:${widget.solicitude.email}");
                                },
                                icon: Icon(MdiIcons.emailOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(MdiIcons.fileUpload)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            opcion3 = false;
                            setState(() {});
                          },
                          child: Text("Siguiente"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //Negociacion Interna
                IgnorePointer(
                  ignoring: opcion3,
                  child: ExpansionTile(
                    title: Text("Negociacion Interna"),
                    leading: Icon(MdiIcons.ballotOutline),
                    children: [
                      Container(
                        child: FutureBuilder(
                            future: Future.wait(
                                [loadListAgentes(lineaNg, nombrePais)]),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<dynamic>> snapshot) {
                              List<Widget> children;
                              if (snapshot.hasData) {
                                children = _buildFormChildren(context);
                              } else if (snapshot.hasError) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ];
                              } else {
                                children = <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(16),
                                  ),
                                  SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 60,
                                    height: 60,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Text('Cargando Agentes...'),
                                  )
                                ];
                              }
                              return Container(
                                child: Column(
                                  children: children,
                                ),
                              );
                            }),
                        //loadListAgentes(agentesList)
                      ),
                      FutureBuilder(
                          future: NetworkHelper.attemptContactoAgente(
                              agenteSelected),
                          builder: (context,
                              AsyncSnapshot<ContactosSegunAgente> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        Text("Cargando datos")
                                      ],
                                    ),
                                  ),
                                );

                              default:
                                if (snapshot.hasError)
                                  return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.error),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                              "No se pudo cargar los datos, por favor intente mas tarde.")
                                        ],
                                      ));
                                else {
                                  if (!snapshot.hasData)
                                    return Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                                "No se pudo cargar los datos, por favor intente mas tarde.")
                                          ],
                                        ));

                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data.contactosAgente.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        final contactosClientes = snapshot
                                            .data.contactosAgente[index];
                                        return Container(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                    contactosClientes.nombre),
                                                leading: Icon(MdiIcons.account),
                                                onTap: () {},
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                        );
                                      });
                                }
                              // return CircularProgressIndicator();
                            }
                          }),
                      Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width - 70,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0,
                                  blurRadius: 5.5)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  launch("tel://${widget.solicitude.telefono}");
                                },
                                icon: Icon(MdiIcons.phoneOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launchWhatsApp(widget.solicitude.telefono);
                                },
                                icon: Icon(MdiIcons.whatsapp)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launch("mailto:${widget.solicitude.email}");
                                },
                                icon: Icon(MdiIcons.emailOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(MdiIcons.fileUpload)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            opcion4 = false;
                            setState(() {});
                          },
                          child: Text("Siguiente"),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //Cotizacion
                IgnorePointer(
                  ignoring: opcion4,
                  child: ExpansionTile(
                    title: Text("Cotizacion"),
                    leading: Icon(MdiIcons.textBox),
                  ),
                ),
                //Seguimiento
                ExpansionTile(
                  title: Text("Seguimiento"),
                  leading: Icon(MdiIcons.clipboardSearch),
                ),
                //Cierre
                ExpansionTile(
                  title: Text("Cierre"),
                  leading: Icon(MdiIcons.checkboxMarkedCircleOutline),
                  children: [
                    Container(
                        child: FutureBuilder(
                            future: NetworkHelper.attemptMotivoRechazo(),
                            builder: (context,
                                AsyncSnapshot<List<ListMotivo>> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          Text("Cargando datos")
                                        ],
                                      ),
                                    ),
                                  );
                                default:
                                  if (snapshot.hasError)
                                    return Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                                "No se pudo cargar los datos, por favor intente mas tarde.")
                                          ],
                                        ));
                                  else {
                                    if (!snapshot.hasData)
                                      return Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.error),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text(
                                                  "No se pudo cargar los datos, por favor intente mas tarde.")
                                            ],
                                          ));
                                    final motivos = snapshot.data ?? [];

                                    if (motivos.length == 0)
                                      return Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.error),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text(
                                                  "No hay Motivos disponibles.")
                                            ],
                                          ));
                                    return MyStatefulWidget(
                                      list_item: snapshot.data,
                                    );
                                  }
                              }
                            })),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Aceptar"),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                //Registrar Cliente
                ExpansionTile(
                  title: Text("Registrar Cliente"),
                  leading: Icon(MdiIcons.accountPlus),
                ),
                //CREAR RO
                ExpansionTile(
                  title: Text("Crear Ro"),
                  leading: Icon(MdiIcons.pencilBox),
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '# Ro',
                                hintText: 'Ingrese el Ro',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Aceptar"),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  launchWhatsApp(String phone) async {
    final link = WhatsAppUnilink(
      phoneNumber: phone,
      text: "Hola",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }

  Widget _menuItem(String data, IconData icon) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 19,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              data,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: primaryColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ))
        ],
      ),
    );
  }

  Future<List<dynamic>> loadListAgentes(
      String lineaNg, String nombrePais) async {
    agentesList = await NetworkHelper.attemptAgentes(lineaNg, nombrePais);
    agentesList.forEach((value) {
      listaDropDownAgentes.add(DropdownMenuItem(
        child: _menuItem('${value.nombreAggente}', MdiIcons.ferry),
        value: '${value.nombreAggente}|${value.idagente}',
      ));
    });
    return agentesList;
  }

  Widget _menuItemHint(String hint, IconData icon) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 19,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                hint,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: Colors.black26),
              ))
        ],
      ),
    );
  }

  _buildFormChildren(BuildContext context) {
    return [
      SearchableDropdown.single(
        items: listaDropDownAgentes,
        onChanged: (value) {
          setState(() {
            agenteSelected = value;
          });
        },
        isExpanded: true,
        clearIcon: Icon(MdiIcons.domain),
        hint: _menuItemHint("Agentes", MdiIcons.accountSupervisorCircle),
        displayClearIcon: false,
      )
    ];
  }
}
