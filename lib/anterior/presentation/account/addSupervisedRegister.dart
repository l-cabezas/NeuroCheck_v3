import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neurocheck/presentation/account/textFieldsForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../behaviors/hiddenScrollBehavior.dart';
import '../../device/shared_preferences/shared_preferences.dart';
import '../mensajes/showInfo.dart';

class addSupervisedRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addSupervisedRegister();
}

class _addSupervisedRegister extends State<addSupervisedRegister> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool _passwordVisible = true;
  late SharedPreferences prefs;

  final TextFieldsForm logic = TextFieldsForm(
    TextEditingController(),
    TextEditingController(),
  );

  @override
  void initState() {
    //sharedPre();
  }

  sharedPre()async{
     prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    sharedPre();
    return Scaffold(
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
                const Text(
                  'Registra a tu supervisado : ',
                  style: TextStyle(fontSize: 18),
                ),
                logic.space(12),
                logic.getEmail(context),
                logic.space(30),
                Row(
                  children: [
                    SizedBox(
                        width: 305,
                        child: logic.getPassword(context, _passwordVisible)),
                    const SizedBox(
                      width: 5,
                    ),
                    iconButton(),
                  ],
                ),
                //getPassword(context),
                logic.space(30),
                Row(
                  children: [
                    SizedBox(
                        width: 305,
                        child: logic.getPassword2(context, _passwordVisible)),
                    const SizedBox(
                      width: 5,
                    ),
                    iconButton(),
                  ],
                ),
                logic.space(35),
                addSupervisedButton(context),
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

  Widget iconButton() {
    return IconButton(
      onPressed: () {
        _togglePasswordView();
      },
      icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).bottomAppBarColor),
    );
  }

  Widget addSupervisedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? const CupertinoActivityIndicator()
          : CupertinoButton.filled(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String? pass = logic.passwordController?.text;

                  /* Iniciamos sesion como el supervisado y guardamos las credenciales
                  * luego cerramos sesión y volvemos a abrir la sesión con las credenciales del
                  * supervisor.
                  * Esto tiene que tener otra forma de hacerlo pero de momento fue la más
                  * "limpia" que encontré
                  * */
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: logic.emailController.text,
                          password: pass!)
                      .then((result) {

                    String? uid = FirebaseAuth.instance.currentUser?.uid;

                    //guardamos datos del supervisado
                    SharedPreferencesDatos().setPassword_SupervisedToSF(pass);
                    SharedPreferencesDatos().setUID_SupervisedToSF(uid!);



                    FirebaseAuth.instance.signOut().then((value) {
                      String? email = '';
                      String? password = '';

                      email = prefs.getString('emailUser');
                      password = prefs.getString('password_user');

                      print(email);
                      print(password);
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!)
                          .then((value) {
                        ShowInfo().showDismissableFlushbar(context, '  Supervisado añadido  ');

                        logic.emailController.clear();
                        logic.passwordController?.clear();
                        logic.passwordController2?.clear();
                        Navigator.pushReplacementNamed(context, '/maintabs');
                      });
                    });
                  });
                }
              },
              child: const Text('Registrarse'),
            ),
    );
  }
}
