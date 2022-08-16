import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:neurocheck/presentation/account/textFieldsForm.dart';
import 'package:provider/provider.dart';

import '../../data/models/userApp_entity.dart';
import '../../device/shared_preferences/shared_preferences.dart';
import '../mensajes/showInfo.dart';
import '../providers/userApp_provider.dart';
import '/behaviors/hiddenScrollBehavior.dart';
import '/domain/users/GestionUsuarios.dart';
import '/domain/resources/Strings.dart';
import 'package:flutter/material.dart';
import '/data/global_var/globals.dart' as globals;



class RegisterBossPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterBossPageState();

}

class _RegisterBossPageState extends State<RegisterBossPage>{
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool _passwordVisible = true;

  //TextEditingController passwordController = TextEditingController();
  //TextEditingController passwordController2 = TextEditingController();

  final TextFieldsForm logic =
  TextFieldsForm(
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  );

  GestionUsuarios gestionUsuarios = GestionUsuarios();
  bool val = false;

  @override
  void initState() {
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //para poder presentar menus contextuales con info al usuario
      // lo que serian Toast
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      key: _scaffoldKey,
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
                const Text('Registrarse como supervisor : ',
                  style: TextStyle(fontSize: 18),),
                logic.space(12),
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



  Widget registerButton(BuildContext context){
    var authProvider= context.watch<UserAppProvider>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? const CupertinoActivityIndicator()
          : FloatingActionButton.extended(
        heroTag: 'registerBoss',
        //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
        backgroundColor: const Color(0xff3f60d5),
        foregroundColor: Colors.white,
        onPressed: () {
          if (_formKey.currentState!.validate()){
            String? pass = logic.passwordController?.text;

            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: logic.emailController.text, password: pass!)
                .then((result) {
              ShowInfo().showDismissableFlushbar(context, '  Usuario añadido  ');
              //guardamos datos
              SharedPreferencesDatos().setPassword_userToSF(pass);
              var uidUser = result.user?.uid;
              SharedPreferencesDatos().setUID_userToSF(uidUser!);
              var email = result.user?.email;
              SharedPreferencesDatos().setEmailToSF(email!);

              UserApp userApp = UserApp.fromMap({
              'uid': result.user?.uid,
              'email': logic.emailController.text,
              'fullname': logic.nameController?.text,
              'rol': 'supervisor',
              'supervisado': ''
              });


              logic.nameController?.clear();
              logic.emailController.clear();
              logic.passwordController?.clear();
              logic.passwordController2?.clear();
              authProvider.addSupervised(userApp);
              Navigator.pushReplacementNamed(context, '/add_supervisado');

            });

          }
        },
        label: const Text('Registrarse'),
      ),
    );
  }


}
