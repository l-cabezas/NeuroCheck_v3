import 'package:neurocheck/device/shared_preferences/shared_preferences.dart';
import 'package:neurocheck/presentation/account/registerSupervised_page.dart';
import 'package:neurocheck/presentation/account/textFieldsForm.dart';

import '/behaviors/hiddenScrollBehavior.dart';
import '/domain/resources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/data/global_var/globals.dart' as globals;


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late bool _passwordVisible;

  final TextFieldsForm logic = TextFieldsForm(
    TextEditingController(),
    TextEditingController(),
  );

  @override
  void initState() {
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("Iniciar sesión",style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        ),
        body: Container(
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.all(25.0),
            child: ScrollConfiguration(
                behavior: HiddenScrollBehavior(),
                child: Form(
                    key: _formKey,
                    child: ListView(children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      logic.getEmail(context),
                      logic.space(30),
                      Row(
                        children: [
                          SizedBox(
                              width: 305,
                              child:
                                  logic.getPassword(context, _passwordVisible)),
                          const SizedBox(
                            width: 5,
                          ),
                          iconButton(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0), //EdgeInsets.all(20.0),
                        child: isLoading
                            ? const CupertinoActivityIndicator()
                            : CupertinoButton.filled(

                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    logInToFb();
                                    getRol();
                                  }
                                },
                                child: const Text('Iniciar sesión'),
                              ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CupertinoButton(
                              child: const Text("¿Olvidaste tu contraseña?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      )
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/reset');

                              })),
                      const SizedBox(
                        height: 50,
                      ),
                        const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('¿Todavía no tienes cuenta?',
                            style: TextStyle(
                                color: Color(0xff172c66))
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(padding: const EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
                        child:
                        CupertinoButton.filled(
                          //padding: const EdgeInsets.all(5.0),
                          child: const Text('Regístrate'),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/chooseLife');
                          },
                        ),
                      ),
                    ]
                    )
                )
            )
        )
    );
  }

  void logInToFb() {
    setState(() {
      isLoading = true;
    });
    globals.user_email = logic.emailController.text;
    String? pass = logic.passwordController?.text.toString();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: logic.emailController.text,
            password: pass.toString())
        .then((result) {
      isLoading = false;

      String? uid = result.user?.uid;
      SharedPreferencesDatos().setUID_userToSF(uid!);

      Navigator.of(context).pushReplacementNamed('/maintabs');
    }).catchError((err) {
      print(err.message);
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            logic.passwordController?.clear();
            return AlertDialog(
              title: const Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  getRol() async {
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(globals.user_email)
        .get()
        .then((value) => globals.user_rol = value.data()!['rol']);
  }

  @override
  void dispose() {
    super.dispose();
    logic.emailController.dispose();
    logic.passwordController?.dispose();
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

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
