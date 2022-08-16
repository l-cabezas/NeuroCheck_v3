import '/domain/profile/uploadPhoto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/profile/uploadPhoto.dart';
import 'number_widget.dart';
import '../../domain/profile/profile_widget.dart';
import '/domain/resources/Strings.dart';
import '/data/global_var/globals.dart' as globals;





class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UploadPhoto photoUpload = UploadPhoto();
  TextEditingController Notification_title = TextEditingController();
  TextEditingController Notification_descrp = TextEditingController();

  //static const icon = CupertinoIcons.moon_stars;
  @override
  void initState() {
    super.initState();
    photoUpload.cargaImage();
  }
  String supervisado = '';


  @override
  Widget build(BuildContext context) {
    if(globals.user_rol == 'supervisor')
      {supervisado = 'Supervisor de '+ globals.user_email;}
    return Scaffold(
      body:
      RefreshIndicator(
        onRefresh: () async {
          photoUpload.cargaImage();
          setState(() {});
        },
        //Do whatever you want on refrsh.Usually update the date of the listview
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 40),
            ProfileWidget(
                image: loadImageProfile(),//Image.network(globals.urlIconoInicial),
                onClicked: () {
                  photoUpload.upload('gallery');
                  photoUpload.cargaImage();
                  //loadImageProfile();
                }
            ),

            const SizedBox(height: 24),
            buildName(),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 5),
            Center(child: buildExitButton()),
            const SizedBox(height: 20),
            Center(child: EditarSupervisadoButton()),
            const SizedBox(height: 10),
            Center(child: deleteButton()),

          ],
        ),
      ),
    );
  }

  Image loadImageProfile(){
    if(globals.urlIconoInicial == 'none'){
      return Image.asset('assets/user.png');
    }
    else{
      return Image.network(globals.urlIconoInicial);
    }
  }



  Widget buildName() => Column(
    children: [
      Text(
        globals.nombre_persona,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xff001858)),
      ),
      const SizedBox(height: 10),
      Text(
        'Correo electrónico '+globals.user_email,
        style: const TextStyle(color: Colors.grey,fontSize: 15),
      ),
      const SizedBox(height: 5,),
      Text(
        'Cuenta con rol de '+globals.user_rol,
        style: const TextStyle(color: Colors.grey,fontSize: 15),
      ),
      const SizedBox(height: 5,),
      Text(
        supervisado,
        style: const TextStyle(color: Colors.grey,fontSize: 15),
      )

    ],
  );

  _logout() async{
    await FirebaseAuth.instance.signOut();
    globals.user_email = '';
    globals.user_rol = '';
    globals.nombre_persona='';

    //nombre_tarea = '';
    //hora_tarea = '';

    globals.hora_inicio = '';
    globals.hora_fin = '';

    globals.repeticiones = '';
    globals.email_supervision = '';
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget buildExitButton() =>
      FloatingActionButton.extended(
        heroTag: "desconectarse",
        onPressed: () {
          _logout();
        },
        label: const Text('Desconectarse'), icon: const Icon(Icons.exit_to_app),
        backgroundColor: const Color(0xff8ba5ff),
        foregroundColor: Colors.white,
      );

  Widget deleteButton() =>
      CupertinoButton.filled(
        onPressed: () {
          Navigator.pushNamed(context, '/deleteUserPage');
        },
        child: const Text('Borrar cuenta')
      );

  Widget EditarSupervisadoButton() {
    if(globals.user_rol=='supervisor'){
      return FloatingActionButton.extended(
        heroTag: "editar_supervisado",
        onPressed: () {
          Navigator.of(context).pushNamed('/modsupervisado');
        }, icon: const Icon(Icons.person_add),
        label: const Text('Editar Supervisado'),
        backgroundColor: const Color(0xff8ba5ff),
        foregroundColor: Colors.white,
      );
    }else{
      return const Text('');
    }
  }

}



















