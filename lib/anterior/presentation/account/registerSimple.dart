import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:neurocheck/data/models/userApp_entity.dart';
import 'package:neurocheck/device/shared_preferences/shared_preferences.dart';
import 'package:neurocheck/presentation/account/textFieldsForm.dart';
import 'package:neurocheck/presentation/providers/userApp_provider.dart';
import 'package:provider/provider.dart';

import '../mensajes/showInfo.dart';
import '/behaviors/hiddenScrollBehavior.dart';
import '/domain/users/GestionUsuarios.dart';
import '/domain/competicion/CompeticionUsuarios.dart';
import '/domain/resources/Strings.dart';
import 'package:flutter/material.dart';
import '/data/global_var/globals.dart' as globals;


class RegisterSimplePage extends StatefulWidget {
  @override
  //State<StatefulWidget> createState() => _RegisterSupervisedPageState();
  RegisterSimplePageState createState() {
    return RegisterSimplePageState();
  }
}

class RegisterSimplePageState extends State<RegisterSimplePage> {
  final _formKey = GlobalKey<FormState>();

  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _passwordVisible = true;
  bool isLoading = false;


  final TextFieldsForm logic = TextFieldsForm(
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  );

  //GestionUsuarios addUsuarios = GestionUsuarios();
  //CompeticionUsuarios tablaUsuarios = CompeticionUsuarios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Registrarse',style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      //key: _scaffoldKey,
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(25.0),
        //en caso de pantallas pequeñas no se derbode teclado
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                logic.space(5),
                logic.getName(context),
                logic.space(30),
                logic.getEmail(context),
                logic.space(30),
                Row(
                  children: [
                    SizedBox(
                        width: 305,
                        child:logic.getPassword(context,_passwordVisible)
                    ),
                    const SizedBox(width: 5,),
                    iconButton(),
                  ],
                ),
                //getPassword(context),
                logic.space(30),
                Row(
                  children: [
                    SizedBox(
                        width: 305,
                        child:logic.getPassword2(context,_passwordVisible)
                    ),
                    const SizedBox(width: 5,),
                    iconButton(),
                  ],
                ),
                logic.space(35),
                registerButton(context),
                logic.space(10),
                logic.haveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }



  Widget iconButton(){
    return IconButton(
      onPressed: (){ _togglePasswordView();},
      icon: Icon(
          _passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).bottomAppBarColor),
    );

  }


  Widget registerButton(BuildContext context) {
    var authProvider = context.watch<UserAppProvider>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? const CupertinoActivityIndicator()
          : CupertinoButton.filled(

        //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
        onPressed: () {
          if (_formKey.currentState!.validate()) {

            setState(() {
              isLoading = true;
            });

            String? pass = logic.passwordController?.text;
            String email = logic.emailController.text;

            FirebaseAuth.instance
                .createUserWithEmailAndPassword(email: email, password: pass!)
                .then((result) {

              ShowInfo().showDismissableFlushbar(context, '  Usuario añadido  ');

              String? uid = result.user?.uid;

              SharedPreferencesDatos().setUID_userToSF(uid!);
              SharedPreferencesDatos().setPassword_userToSF(pass);

              UserApp userApp = UserApp.fromMap({
                'uid': uid,
                'email': logic.emailController.text,
                'fullname': logic.nameController?.text,
                'rol': 'supervisado'
              });


              authProvider.addSupervised(userApp);

              isLoading = false;

              Navigator.pushReplacementNamed(context, '/maintabs');

              logic.nameController?.clear();
              logic.emailController.clear();
              logic.passwordController?.clear();
              logic.passwordController2?.clear();

              /*if (userApp.rol == 'supervisado') {
                //tablaUsuarios.Competir(name_person, user_email, 0);
              }*/
            });
          }
        },
        child: const Text('Registrarse'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    logic.emailController.dispose();
    logic.nameController?.dispose();
    logic.passwordController?.dispose();
    logic.passwordController2?.dispose();
  }

}
