// @dart=2.9
import 'dart:convert';

import 'package:app_prueba/authentication/presentation/pages/chatbot_page.dart';
import 'package:app_prueba/authentication/presentation/pages/solicitudesCustomers_page.dart';
import 'package:app_prueba/const/constants.dart';
import 'package:app_prueba/models/instruccionEmbarque.dart';
import 'package:app_prueba/providers/contact_customer_provider.dart';
import 'package:app_prueba/search_items.dart';
import 'package:app_prueba/services/database.dart';
import 'package:app_prueba/services/requests.dart';
import 'package:app_prueba/widgets/customAnimatedButtom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/domain/entities/view_app.dart';
import 'authentication/domain/repositories/authentication_repository.dart';
import 'authentication/domain/repositories/user_repository.dart';
import 'authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'authentication/presentation/pages/basc_page.dart';
import 'authentication/presentation/pages/login_page.dart';
import 'authentication/presentation/pages/splash_page.dart';
import 'const/gradient.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'form.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_prueba/models/weeks.dart';
import 'package:app_prueba/widgets/add_tipo_carga.dart';
import 'package:app_prueba/condicion_embarque.dart';
import 'package:app_prueba/widgets/dropdown_widget.dart';

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const MyApp(
      {Key key,
      @required this.authenticationRepository,
      @required this.userRepository})
      : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
          create: (_) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository,
              ),
          child: AppView()),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactCustomerprovider()),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        theme: ThemeData(errorColor: Colors.red),
        builder: (context, child) {
          return Scaffold(
            body: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      MyHomePage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.failed:
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Usuario incorrecto!'),
                      duration: const Duration(seconds: 1),
                    ));
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationFailed());

                    //showDialog(context: context, builder: (_) => AlertDialog(title: Text("failed"),));
                    break;

                  default:
                    break;
                }
              },
              child: child,
            ),
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyHomePage());
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  ButtonState stateTextWithIcon = ButtonState.idle;

  String zipCode = "";
  String shipper = "";
  String naviera = "";
  String origenSelected = "GUAYAQUIL|41";
  String destinoSelected = "";
  String consigSelected = "";
  String contrato = "";
  String codeHS = "";
  String producto = "";

  int _radioValue = 0;
  List<DropdownMenuItem> items = [];
  List<DropdownMenuItem> itemsNaviera = [];
  List<DropdownMenuItem> origenList = [];
  List<DropdownMenuItem> destinoList = [];
  List<DropdownMenuItem> consigList = [];
  List<DropdownMenuItem<Week>> _dropdownMenuItems;
  List<DropdownMenuItem<ConEmbarque>> _dropdownMenuItems2;
  String nombreVend = "";
  bool isLoadView = false;
  List<Widget> _viewApp = [];

  Week _selectedWeek;
  ConEmbarque _selectedCondicion;

  //INITIAL VALUES FOR SEARCHABLE DROPDOWN

  String initialOrigen = "GUAYAQUIL|41";

  @override
  void initState() {
    _loadView();
    _dropdownMenuItems = Week.buildDropdownMenuItems();
    _dropdownMenuItems2 = ConEmbarque.buildDropdownMenuItems();
    nombreVend = Constants.nombreVendedor;

    _selectedWeek = _dropdownMenuItems[0].value;
    setState(() {});
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Gestion Chatbot Farletza ",
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
          ),
          leading: IconButton(
            icon: Image.asset(
              "images/SoloLogo.png",
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
                icon: Icon(
                  Icons.restore,
                  color: primaryColor,
                ))
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Image.asset('images/SoloLogo.png'),
                              backgroundColor: Colors.white,
                              radius: MediaQuery.of(context).size.width * 0.10,
                            ),
                            Text(
                              nombreVend,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),

                    //Data dynami, of OptionModels, in future change with providers
                    isLoadView
                        ? Container(
                            child: Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Cargando vistas....."),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            child: Column(
                              children: _viewApp,
                            ),
                          ),

                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Opciones',
                      ),
                    ),
                    ListTile(
                      leading: Icon(MdiIcons.logout),
                      title: Text('Cerrar Sesión'),
                      onTap: () => {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested())
                      },
                    ),
                  ],
                ),
              ),
              Text("Versión: 1.0.2")
            ],
          ),
        ),
        body: _home());
  }

  Widget _appBarPersonalizado(String titulopag) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          titulopag,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
        ),
        leading: IconButton(
          icon: Image.asset(
            "images/SoloLogo.png",
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //_formKey.currentState.reset();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              },
              icon: Icon(
                Icons.restore,
                color: primaryColor,
              ))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            child: Image.asset('images/SoloLogo.png'),
                            backgroundColor: Colors.white,
                            radius: MediaQuery.of(context).size.width * 0.10,
                          ),
                          Text(
                            nombreVend,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  isLoadView
                      ? Container(
                          child: Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Cargando vistas....."),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: Column(
                            children: _viewApp,
                          ),
                        ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Opciones',
                    ),
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.logout),
                    title: Text('Cerrar Sesión'),
                    onTap: () => {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested())
                    },
                  ),
                ],
              ),
            ),
            Text("Versión: 0.9.2")
          ],
        ),
      ),
    );
  }

  Widget _home() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Expanded(child: Image.asset('images/SoloLogo.png'))],
    );
  }

  Widget _buildForm() {
    return Stack(children: [
      Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 16),
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
                    child: FutureBuilder(
                        future: Future.wait([
                          loadListConsign(),
                          loadListNavi(),
                          loadListPuertos(),
                          loadListShippers(),
                        ]),
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
                                child: Text('Cargando catálogos...'),
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
                ),
                InfoTipoCarga(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CustomAnimatedButtom(
                    onPressed: onPressedIconWithText,
                    stateTextWithIcon: stateTextWithIcon,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  List<Widget> _buildFormChildren(BuildContext context) {
    return [
      SearchableDropdown.single(
        items: items,
        onChanged: (value) {
          setState(() {
            shipper = value;
          });
        },
        isExpanded: true,
        displayClearIcon: false,
        hint: _menuItemHint("Shipper", MdiIcons.truck),
      ),
      CustomTextForm(
        function: (input) => {producto = input},
        changed: (value) => {producto = value},
        hintText: 'Producto',
        prefixIcon: MdiIcons.noteTextOutline,
        keyboardType: TextInputType.text,
      ),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      CustomTextForm(
        function: (input) => {codeHS = input},
        hintText: 'HS Code (opcional)',
        changed: (value) => {codeHS = value},
        prefixIcon: MdiIcons.noteTextOutline,
        keyboardType: TextInputType.text,
      ),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      CustomDropdown(
        hintText: "# de semana",
        listaItems: _dropdownMenuItems,
        selectedItem: _selectedWeek,
        onChanged: (selectedElement) {
          setState(() {
            _selectedWeek = selectedElement;
          });
        },
        prefixIcon: MdiIcons.calendarWeek,
      ),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      SearchableDropdown.single(
        items: itemsNaviera,
        onChanged: (value) {
          setState(() {
            naviera = value;
          });
        },
        isExpanded: true,
        clearIcon: Icon(MdiIcons.domain),
        hint: _menuItemHint("Naviera", MdiIcons.shipWheel),
        displayClearIcon: false,
      ),
      SearchableDropdown.single(
        value: origenSelected,
        items: origenList,
        onChanged: (value) {
          setState(() {
            origenSelected = value;
          });
        },
        isExpanded: true,
        clearIcon: Icon(MdiIcons.domain),
        hint: _menuItemHint("Puerto Origen", MdiIcons.ferry),
        displayClearIcon: false,
      ),
      SearchableDropdown.single(
        items: destinoList,
        onChanged: (value) {
          setState(() {
            destinoSelected = value;
          });
        },
        isExpanded: true,
        clearIcon: Icon(MdiIcons.domain),
        hint: _menuItemHint("Puerto Destino", MdiIcons.ferry),
        displayClearIcon: false,
      ),
      CustomTextForm(
        function: (input) => {zipCode = input},
        changed: (value) => {zipCode = value},
        hintText: 'Zip Code (opcional)',
        prefixIcon: MdiIcons.numeric,
        keyboardType: TextInputType.number,
      ),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      Row(
        children: [
          new Radio(
            value: 0,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange,
          ),
          new Text(
            'MBL',
            style: new TextStyle(fontSize: 16.0),
          ),
          new Radio(
            value: 1,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange,
          ),
          new Text(
            'HBL',
            style: new TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      CustomDropdown(
          hintText: "Condición del Flete",
          prefixIcon: MdiIcons.toolboxOutline,
          listaItems: _dropdownMenuItems2,
          selectedItem: _selectedCondicion,
          onChanged: (selectedElement) {
            setState(() {
              _selectedCondicion = selectedElement;
            });
          }),
      Divider(
        color: Colors.indigo[100],
        height: 0.5,
      ),
      SearchableDropdown.single(
        items: consigList,
        onChanged: (value) {
          setState(() {
            consigSelected = value;
          });
        },
        isExpanded: true,
        clearIcon: Icon(MdiIcons.domain),
        hint: _menuItemHint("Consignatario", MdiIcons.accountArrowLeft),
        displayClearIcon: false,
      ),
      CustomTextForm(
        changed: (value) => {contrato = value},
        function: (input) => {contrato = input},
        hintText: 'Contrato (opcional)',
        prefixIcon: MdiIcons.noteTextOutline,
        keyboardType: TextInputType.number,
      ),
    ];
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

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  _submitInstruccion() async {
    InstruccionEmbarque instruccion = new InstruccionEmbarque(
      shipperId: int.parse(shipper.split("|")[1]),
      producto: producto,
      codeHS: codeHS,
      numeroSemana: _selectedWeek.id,
      navieraId: int.parse(naviera.split("|")[1]),
      puertoOrigenId: int.parse(origenSelected.split("|")[1]),
      puertoDestinoId: int.parse(destinoSelected.split("|")[1]),
      zipCode: zipCode,
      hbl: _radioValue == 1 ? true : false,
      mbl: _radioValue == 0 ? true : false,
      condicionFlete: _selectedCondicion.name,
      consignatarioId: int.parse(consigSelected.split("|")[1]),
      contrato: contrato,
      carga: listaCarga,
    );

    try {
      await NetworkHelper.enviarInstruccion(instruccion.toJson());
      setState(() {
        stateTextWithIcon = ButtonState.success;
      });
    } catch (e) {
      stateTextWithIcon = ButtonState.fail;
    }
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        if (_formKey.currentState.validate() && _validateForm()) {
          _submitInstruccion();
        } else {
          stateTextWithIcon = ButtonState.fail;
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Center(
                        child: Row(
                      children: [
                        Icon(
                          MdiIcons.exclamation,
                          color: Colors.red,
                        ),
                        Text(
                          'Error',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    )),
                    content:
                        Text("Faltan de agregar campos que son requeridos"),
                  ));
        }
        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  Future<List<dynamic>> loadListConsign() async {
    consignatarios = await DBProvider.db.getAllConsignatarios();
    consignatarios.forEach((value) {
      consigList.add(DropdownMenuItem(
        child: _menuItem('${value.nombre}', MdiIcons.accountArrowLeft),
        value: '${value.nombre}|${value.id}',
      ));
    });
    return consignatarios;
  }

  Future<List<dynamic>> loadListNavi() async {
    navieras = await DBProvider.db.getAllNavieras();
    navieras.forEach((value) {
      itemsNaviera.add(DropdownMenuItem(
        child: _menuItem('${value.nombre}', MdiIcons.shipWheel),
        value: '${value.nombre}|${value.id}',
      ));
    });
    return navieras;
  }

  Future<List<dynamic>> loadListPuertos() async {
    puertos = await DBProvider.db.getAllPuertos();
    puertos.forEach((value) {
      origenList.add(DropdownMenuItem(
        child: _menuItem('${value.nombre} - ${value.codPais}', MdiIcons.ferry),
        value: '${value.nombre}|${value.id}',
      ));
    });
    puertos.forEach((value) {
      destinoList.add(DropdownMenuItem(
        child: _menuItem('${value.nombre}', MdiIcons.ferry),
        value: '${value.nombre}|${value.id}',
      ));
    });
    return puertos;
  }

  Future<List<dynamic>> loadListShippers() async {
    shippers = await DBProvider.db.getAllShippers();
    shippers.forEach((value) {
      items.add(DropdownMenuItem(
        child: _menuItem('${value.nombre}', MdiIcons.truck),
        value: '${value.nombre}|${value.id}',
      ));
    });
    return shippers;
  }

  _validateForm() {
    if (naviera == "" ||
        origenSelected == "" ||
        destinoSelected == "" ||
        consigSelected == "" ||
        listaCarga.length == 0 ||
        producto == "") {
      return false;
    } else {
      return true;
    }
  }

  void _loadView() {
    final opciones = Constants.opcionesModel;
    final opcionvenes = Constants.nombreVendedor;

    opciones.forEach((opcionesModel) {
      if (opcionesModel.codigoVista.contains("CB")) {
        _viewApp.add(ListTile(
          leading: Icon(MdiIcons.robot),
          title: Text(opcionesModel.descripcion),
          onTap: () {
            MaterialPageRoute route;
            route = MaterialPageRoute(
                builder: (BuildContext context) => ChatBotPage());
            Navigator.push(context, route);
          },
        ));
      }
      if (opcionesModel.codigoVista.contains("RC")) {
        _viewApp.add(ListTile(
          leading: Icon(MdiIcons.bookCheckOutline),
          title: Text(opcionesModel.descripcion),
          onTap: () {
            MaterialPageRoute route;
            route = MaterialPageRoute(
                builder: (BuildContext context) => solicitudesCustomerPage());
            Navigator.push(context, route);
          },
        ));
      }
      if (opcionesModel.codigoVista.contains("BSC")) {
        _viewApp.add(ListTile(
          leading: Icon(MdiIcons.earth),
          title: Text(opcionesModel.descripcion),
          onTap: () {
            MaterialPageRoute route;
            route = MaterialPageRoute(
                builder: (BuildContext context) => opcBascPages());
            Navigator.push(context, route);
          },
        ));
      }
      if (opcionesModel.codigoVista.contains("IE")) {
        _viewApp.add(ListTile(
          leading: Icon(MdiIcons.shipWheel),
          title: Text(opcionesModel.descripcion),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SingleChildScrollView(child: _buildForm())));
          },
        ));
      }
    });
  }
}
