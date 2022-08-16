/*


import 'anterior/data/global_var/globals.dart'

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'domain/di/injector.dart';
import 'firebase_options.dart';

Widget _rootPage = ChooseLife();

Future<Widget> getRootPage() async =>
    FirebaseAuth.instance.currentUser == null
        ? LoginPage()
        : MainTabsPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences.setMockInitialValues({});
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  getRootPage().then((Widget page) {
    _rootPage = page;
  });
  setUp();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(NeuroCheckApp());
}

class NeuroCheckApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NeuroCheckAppState();
}

class _NeuroCheckAppState extends State<NeuroCheckApp> {
  @override
  void initState() {
    //initUsers();
    getRootPage().then((Widget page) {
      _rootPage = page;
    });
    super.initState();
  }

  Future<void> initUsers() async {
    var emailF = FirebaseAuth.instance.currentUser?.uid;
    var checkEmail = emailF;
    //obtener el email del usuario actual
    if (checkEmail != null) {
      globals.user_email = emailF.toString();
      var result = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(globals.user_email)
          .get();
      var datos = result.reference.snapshots();
      datos.forEach((element) {
        globals.nombre_persona = element['fullname'];
        globals.user_rol = element['rol'];
        if (globals.user_rol == 'supervisor') {
          globals.user_supervisor_email = globals.user_email;
          globals.user_email = element['supervisado'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I<TaskProvider>()..getTasks(),
        ),
        ChangeNotifierProvider(create: (context) => GetIt.I<UserAppProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.title,
        home: SplashScreen(
          useLoader: false,
          loadingTextPadding: const EdgeInsets.all(0),
          loadingText: const Text(""),
          navigateAfterSeconds: _rootPage,
          seconds: 3,
          title: const Text(
            'Cargando..',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          //image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
          image: Image.asset('assets/splash_screen_logo.png'),
          backgroundColor: Theme.of(context).backgroundColor,
          styleTextUnderTheLoader: const TextStyle(),
          photoSize: 100.0,
        ),
        routes: buildAppRoutes(),
        theme: dayData(),
        darkTheme: darkData(),
      ),
    );
  }

  AssetImage carga() {
    return AssetImage("assets/256x256.gif");
  }

}
*/
