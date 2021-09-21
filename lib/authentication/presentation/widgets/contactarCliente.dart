//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:app_prueba/authentication/presentation/widgets/seleccontactos.dart';
import 'package:app_prueba/const/gradient.dart';
import 'package:app_prueba/models/actualizaRo.dart';
import 'package:app_prueba/models/agentes.dart';
import 'package:app_prueba/models/contactosagentes.dart';
import 'package:app_prueba/models/motivosrechazo.dart';
import 'package:app_prueba/models/solicitudes.dart';
import 'package:app_prueba/models/uploadRes.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_state_button/progress_button.dart';
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
  bool btncontinuar = true;
  bool btnSubirArchivos2 = false;
  bool btnSubirArchivos3 = false;
  bool btnSubirArchivosCot = false;

  bool btnFinalizarCierre = true;
  bool btnNextInfoEmb = true;

  String agenteSelected = '';
  List<DropdownMenuItem> listaDropDownAgentes = [];
  ButtonState stateTextWithIcon = ButtonState.idle;

  List<ListaAgentes> agentesList = [];
  String fileName = "";
  String fileName3 = "";
  String fileName4 = "";
  List<Adjunto> listaAdjunto = [];
  String emailContactoAgente = '';
  String telfContactoAgente = '';
  String nombreContactoAg = "";
  String ro = "";
  String numerodeRo = '';
  String nombreAgenteSele = '';
  FilePickerResult result;
  FilePickerResult result1;

  void changeEmail(String email) {
    setState(() {
      emailContactoAgente = email;
    });
  }

  void changeTelefono(String telefono) {
    setState(() {
      telfContactoAgente = telefono;
    });
  }

  String registroafectado = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String lineaNg = widget.solicitude.lineaNegocio;
    String nombrePais = '';
    listaDropDownAgentes = [];
    int index = 0;
    String estado = "";
    bool isEnable = true;
    bool isEnable2 = true;
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
                    style: TextStyle(
                        fontSize: 16.0), //, fontWeight: FontWeight.w500),
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
                                updateControlTareas('2',
                                    '${widget.solicitude.idsolicitud}', "P");
                              },
                              icon: Icon(MdiIcons.phoneOutline)),
                          VerticalDivider(
                            color: Colors.black87,
                            width: 1,
                          ),
                          IconButton(
                              onPressed: () {
                                launchWhatsApp(widget.solicitude.telefono);
                                updateControlTareas('2',
                                    '${widget.solicitude.idsolicitud}', "P");
                              },
                              icon: Icon(MdiIcons.whatsapp)),
                          VerticalDivider(
                            color: Colors.black87,
                            width: 1,
                          ),
                          IconButton(
                              onPressed: () {
                                launch("mailto:${widget.solicitude.email}");
                                updateControlTareas('2',
                                    '${widget.solicitude.idsolicitud}', "P");
                              },
                              icon: Icon(MdiIcons.emailOutline))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: btncontinuar,
                      child: Container(
                          child: MaterialButton(
                        onPressed: () {
                          opcion2 = false;

                          setState(() {
                            isEnable = false;
                            if (btncontinuar == true) btncontinuar = false;
                          });
                          updateControlTareas(
                              '2', '${widget.solicitude.idsolicitud}', "F");
                        },
                        child: Text("Siguiente"),
                        color: Colors.blue,
                        textColor: Colors.white,
                      )),
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
                                  updateControlTareas('3',
                                      '${widget.solicitude.idsolicitud}', "P");
                                },
                                icon: Icon(MdiIcons.phoneOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launchWhatsApp(widget.solicitude.telefono);
                                  updateControlTareas('3',
                                      '${widget.solicitude.idsolicitud}', "P");
                                },
                                icon: Icon(MdiIcons.whatsapp)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launch("mailto:${widget.solicitude.email}");
                                  updateControlTareas('3',
                                      '${widget.solicitude.idsolicitud}', "P");
                                },
                                icon: Icon(MdiIcons.emailOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () async {
                                  FilePickerResult result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    File file = File(result.files.single.path);
                                    setState(() {
                                      fileName = file.path;
                                      btnSubirArchivos2 = true;
                                    });
                                  } else {}
                                },
                                icon: Icon(MdiIcons.fileUpload)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Visibility(
                            visible: btnSubirArchivos2,
                            child: MaterialButton(
                              minWidth: 200.0,
                              height: 40.0,
                              onPressed: () {
                                subirArchivos(fileName,
                                    '${widget.solicitude.idsolicitud}', '3');
                                updateControlTareas('3',
                                    '${widget.solicitude.idsolicitud}', "P");
                              },
                              color: Colors.lightBlue,
                              child: Text('Subir Archivo',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: (listaAdjunto.length != 0) ? true : false,
                        child: Container(
                          height: 200,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                              itemCount: listaAdjunto.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    onTap: () {
                                      launch(listaAdjunto[index].linkDescarga);
                                    },
                                    leading: Icon(Icons.file_present),
                                    trailing: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 15),
                                    ),
                                    title: Text(
                                        "${listaAdjunto[index].nombreArchivo}"));
                              }),
                        ),
                      ),
                      Visibility(
                        visible: btnNextInfoEmb,
                        child: Container(
                          child: MaterialButton(
                            child: Text("Siguiente"),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                btnNextInfoEmb = false;
                              });
                              updateControlTareas(
                                  '3', '${widget.solicitude.idsolicitud}', "F");
                              opcion3 = false;
                            },
                          ),
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
                            future: NetworkHelper.attemptAgentes(
                                lineaNg, nombrePais),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ListaAgentes>> snapshot) {
                              List<Widget> children;

                              if (!snapshot.hasData) {
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
                              } else if (snapshot.hasData) {
                                agentesList = snapshot.data;
                                listaDropDownAgentes = [];
                                agentesList.forEach((value) {
                                  listaDropDownAgentes.add(DropdownMenuItem(
                                    child: _menuItem('${value.nombreAggente}',
                                        MdiIcons.ferry),
                                    value:
                                        '${value.nombreAggente}|${value.idagente}',
                                  ));
                                });
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
                                        Text("Cargando Agentes")
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
                                }
                                return Container(
                                  height: MediaQuery.of(context).size.height *
                                      .2, //200,
                                  child: ListView.builder(
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
                                                subtitle: Text(
                                                    "Tipo Carga: ${contactosClientes.tipoCarga}"),
                                                leading: Icon(MdiIcons.account),
                                                onTap: () {
                                                  List<MediosdeContacto>
                                                      listaEmail =
                                                      contactosClientes
                                                          .mediosdeContacto
                                                          .where((element) =>
                                                              element.codigo ==
                                                              "E")
                                                          .toList();
                                                  nombreAgenteSele =
                                                      contactosClientes.nombre
                                                          .toString();
                                                  List<MediosdeContacto>
                                                      listaTelf =
                                                      contactosClientes
                                                          .mediosdeContacto
                                                          .where((element) =>
                                                              element.codigo ==
                                                              "T")
                                                          .toList();
                                                  if (listaTelf.length >= 2 ||
                                                      listaEmail.length >= 2) {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AgentContactModalPage(
                                                          listaEmail:
                                                              listaEmail,
                                                          listaTelf: listaTelf,
                                                          cambiarEmail:
                                                              changeEmail,
                                                          cambiarTelf:
                                                              changeTelefono,
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    if (listaEmail.length ==
                                                        1) {
                                                      setState(() {
                                                        emailContactoAgente =
                                                            listaEmail[0].valor;
                                                      });
                                                    }
                                                    if (listaTelf.length == 1) {
                                                      setState(() {
                                                        telfContactoAgente =
                                                            listaTelf[0].valor;
                                                      });
                                                    }
                                                  }
                                                },
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                        );
                                      }),
                                );
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: RichText(
                        text: TextSpan(
                          text: 'Nombre : $nombreAgenteSele',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[TextSpan(text: "")],
                        ),
                      )),
                      Container(
                          child: RichText(
                        text: TextSpan(
                          text: 'Telefono : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: telfContactoAgente)
                          ],
                        ),
                      )),
                      Container(
                          child: RichText(
                        text: TextSpan(
                          text: 'Email : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: "$emailContactoAgente")
                          ],
                        ),
                      )),
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
                                  launch("tel://$telfContactoAgente");
                                  updateControlTareas('4',
                                      '${widget.solicitude.idsolicitud}', "P");
                                },
                                icon: Icon(MdiIcons.phoneOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launchWhatsApp(telfContactoAgente);
                                  updateControlTareas('4',
                                      '${widget.solicitude.idsolicitud}', "P");
                                },
                                icon: Icon(MdiIcons.whatsapp)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  launch("mailto:$emailContactoAgente");
                                  updateControlTareas('4',
                                      '${widget.solicitude.idsolicitud}', "P");
                                },
                                icon: Icon(MdiIcons.emailOutline)),
                            VerticalDivider(
                              color: Colors.black87,
                              width: 1,
                            ),
                            IconButton(
                                onPressed: () async {
                                  result1 =
                                      await FilePicker.platform.pickFiles();
                                  if (result1 != null) {
                                    File file = File(result1.files.single.path);
                                    setState(() {
                                      fileName3 = file.path;
                                      btnSubirArchivos3 = true;
                                    });
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                icon: Icon(MdiIcons.fileUpload)),
                          ],
                        ),
                      ),
                      if (result1 != null)
                        RichText(
                          text: TextSpan(
                            //text: '',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Archivo cargado:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      Text("$fileName3"),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: btnSubirArchivos3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              minWidth: 200.0,
                              height: 40.0,
                              onPressed: () {
                                subirArchivos(fileName3,
                                    '${widget.solicitude.idsolicitud}', '4');
                                updateControlTareas('4',
                                    '${widget.solicitude.idsolicitud}', "P");
                              },
                              color: Colors.lightBlue,
                              child: Text('Subir Archivo',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: (listaAdjunto.length != 0) ? true : false,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                              itemCount: listaAdjunto.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {
                                    launch(listaAdjunto[index].linkDescarga);
                                  },
                                  leading: Icon(Icons.file_present),
                                  title: Text(
                                      "${listaAdjunto[index].nombreArchivo}"),
                                  trailing: Text(
                                    "",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                );
                              }),
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
                            updateControlTareas(
                                '4', '${widget.solicitude.idsolicitud}', "F");
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
                    children: [
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //  children: [
                      TextButton.icon(
                        onPressed: () async {
                          result = await FilePicker.platform.pickFiles();
                          if (result != null) {
                            File file = File(result.files.single.path);
                            setState(() {
                              fileName4 = file.path;
                              btnSubirArchivosCot = true;
                            });
                          } else {}
                        },
                        icon: Icon(MdiIcons.fileUpload, size: 18),
                        label: Text("Cargar Archivo"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (result != null)
                        RichText(
                          text: TextSpan(
                            //text: '',
                            style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Archivo cargado:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      Text("$fileName4"),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: btnSubirArchivosCot,
                        child: MaterialButton(
                          minWidth: 100.0,
                          height: 40.0,
                          onPressed: //fileName4 != ""?
                              () {
                            subirArchivos(fileName4,
                                '${widget.solicitude.idsolicitud}', '5');
                            updateControlTareas(
                                '5', '${widget.solicitude.idsolicitud}', "F");
                          },
                          //: null,
                          color: Colors.lightBlue,
                          child: Text('Subir Cotizacion',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: (listaAdjunto.length != 0) ? true : false,
                        child: Container(
                          height: 200,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                              itemCount: listaAdjunto.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    onTap: () {
                                      launch(listaAdjunto[index].linkDescarga);
                                    },
                                    leading: Icon(Icons.file_present),
                                    trailing: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 15),
                                    ),
                                    title: Text(
                                        "${listaAdjunto[index].nombreArchivo}"));
                              }),
                        ),
                      ),
                    ],
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
                                      idsolicitud:
                                          "${widget.solicitude.idsolicitud}",
                                    );
                                  }
                              }
                            })),
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
                    Text("Ro asignado: $numerodeRo "),
                    CustomTextForm(
                      changed: (value) => {ro = value},
                      function: (input) => {ro = input},
                      hintText: 'Ingrese el numero Ro',
                      prefixIcon: MdiIcons.noteTextOutline,
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                _submitRo();
                                updateControlTareas('9',
                                    '${widget.solicitude.idsolicitud}', "P");
                              });
                            },
                            child: Text("Actualizar Ro"),
                            color: Colors.blue,
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 20.0,
                        ),
                        Visibility(
                            visible: btnFinalizarCierre,
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  isEnable2 = false;
                                  btnFinalizarCierre = false;
                                });
                                updateControlTareas('9',
                                    '${widget.solicitude.idsolicitud}', "F");
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
    );
  }

  launchWhatsApp(String phone) async {
    final link = WhatsAppUnilink(
      phoneNumber: phone,
      text: "Hola",
    );
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

  Future<List<ListaAgentes>> loadListAgentes(
      String lineaNg, String nombrePais) async {
    agentesList = await NetworkHelper.attemptAgentes(lineaNg, nombrePais);
    agentesList.forEach((value) {
      listaDropDownAgentes.add(DropdownMenuItem(
        child: _menuItem('${value.nombreAggente}', MdiIcons.ferry),
        value: '${value.nombreAggente}|${value.idagente}',
      ));
    });
    setState(() {});
    return agentesList;
  }

  Future<String> updateControlTareas(
      String idtarea, String idsolicitud, String estado) async {
    registroafectado = await NetworkHelper.attempUpdatecontrolTareas(
        idtarea, idsolicitud, estado);
    return registroafectado;
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

  void subirArchivos(String path, String solicitudId, String tareaId) async {
    if (path == '') {
      exit(200);
    }

    String body = await NetworkHelper.enviarArchivo(path, solicitudId, tareaId);

    Map<String, dynamic> consult = jsonDecode(body);
    var lista = List<Adjunto>.from(
        consult['ListaArchivos'].map((x) => Adjunto.fromJson(x)));
    setState(() {
      listaAdjunto = lista;
    });
  }

  _submitRo() async {
    try {
      numerodeRo = await NetworkHelper.attempUpdateNumeroRo(
          ro, '${widget.solicitude.idsolicitud}');
      setState(() {
        stateTextWithIcon = ButtonState.success;
      });
    } catch (e) {
      stateTextWithIcon = ButtonState.fail;
    }
  }
}
