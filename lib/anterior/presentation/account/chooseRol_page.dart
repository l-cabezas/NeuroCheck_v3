import 'package:flutter/material.dart';

import '/domain/resources/Strings.dart';
import '/data/global_var/globals.dart' as globals;




class ChooseRol extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChooseRolState();

}

class _ChooseRolState extends State<ChooseRol>{

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
        title:  Text('Elige rol',style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        ),
        body: Center(

        child: Column(
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MaterialButton(
              minWidth: 200,
              height:170,
              onPressed: (){
                globals.user_rol='supervisado';
                Navigator.of(context).pushReplacementNamed('/registerSupervisado');
              },
              //color: Colors.blue,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xff001858),
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text("Supervisado",style: TextStyle(
                fontWeight: FontWeight.w600,fontSize: 20,color: Color(0xff001858)
              ),),
            ),
            const SizedBox(height: 80),
            MaterialButton(
                minWidth: 200,
                height:170,
              onPressed: (){
                globals.user_rol='supervisor';
                Navigator.of(context).pushReplacementNamed('/registerSupervisor');
              },
              //color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xfff25042),
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Text("Supervisor",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xfff25042)
                  ),),
            )
          ]
          )
        )
      );
  }


}