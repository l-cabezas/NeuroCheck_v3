import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neurocheck/device/shared_preferences/shared_preferences.dart';
import 'package:neurocheck/presentation/tasks/boss/addTask_boss_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/global_var/globals.dart' as globals;
import '/domain/premios/choosePrice.dart';
import '/presentation/mensajes/showInfo.dart';
import '/presentation/providers/task_provider.dart';
import 'bossMod_Supervised_page.dart';


class TasksBossPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TasksBossPageState();
}

class _TasksBossPageState extends State<TasksBossPage> {
  late ScrollController controller;
  String uidUser = '';
  var BaseDatos;
  late SharedPreferences prefs;

  sharedPre()async{
    prefs = await SharedPreferences.getInstance();
    BaseDatos = FirebaseFirestore.instance.collection('usuarios')
        .doc(prefs.getString('uid_supervised')).collection('tareas');
  }

  @override
  void initState() {
    super.initState();
    sharedPre();

  }

  @override
  Widget build(BuildContext context) {
    var taskProvider= Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      //para enseñar la info por pantalla es mucho más cómodo el streamBuilder ya que tarda menos
      //para el resto se usa un provider
      body: listBuilder(),//listView(),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'boton_appTabBoss_bar',
        //padding: EdgeInsets.zero,
        icon: const Icon(Icons.add),
        //color: Colors.white,
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddTaskBossPage()),
          );
        },
        label: const Text('Añadir tarea'),
      ),

    );
  }

  Widget listBuilder(){
    var taskProvider= context.watch<TaskProvider>();
    return StreamBuilder(
        stream: BaseDatos.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('cargando'); //GFLoader(type:GFLoaderType.ios);
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var nombreTarea = snapshot.data
                      ?.docs[index]['nombre_tarea'];
                  var horaInicio = snapshot.data
                      ?.docs[index]['hora_inicio'];
                  var horaFin = snapshot.data?.docs[index]['hora_fin'];
                  var done = snapshot.data?.docs[index]['hecho'];
                  var days = snapshot.data?.docs[index]['days'];
                  var repeticiones = snapshot.data
                      ?.docs[index]['repeticiones'];
                  var mod = snapshot.data?.docs[index]['modificable'];
                  //no contamos la tarea de prueba
                  if (nombreTarea == 'tarea0') {
                    return const Divider(color: Colors.white,);
                  }
                  //print(done);
                  if ((done == 'false') && (mod == 'no')){
                    days = diasToShowClean(days);
                    //no contamos la tarea de prueba
                    if (nombreTarea == 'tarea0') {
                      return const Text(''); //Divider(color: Colors.white,);
                    }
                    return Dismissible(
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          color: const Color(0xFFFD4F4F),
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete),
                        ),
                        key: UniqueKey(),
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmar"),
                                content: const Text(
                                    "¿Seguro que quieres borrar esto?"),
                                actions: <Widget>[
                                  CupertinoButton(
                                      onPressed: () {
                                        if (mod != 'no') {
                                          taskProvider.deleteTarea(
                                              nombreTarea);
                                          taskProvider.getTasks().then((
                                              value) =>
                                              ShowInfo()
                                                  .showDismissableFlushbar(
                                                  context,
                                                  '  Tarea borrada! '));
                                          Navigator.of(context).pop(true);
                                        }
                                      },
                                      child: const Text("BORRAR")
                                  ),
                                  CupertinoButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCELAR"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Card(
                                elevation: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black,),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                //Color(0xFF81D4FA),
                                child: Column(
                                    children: [

                                      ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(30.0)),
                                          title: Center(
                                            //info que saca
                                            child: StatefulBuilder(
                                                builder: (context,
                                                    setState) {
                                                  return ExpansionTile(
                                                      leading: const ImageIcon(
                                                        AssetImage(
                                                            "assets/clipboard.png"),
                                                        size: 25,
                                                        color: Colors
                                                            .white,),
                                                      title:
                                                      Text(
                                                        ' ' + nombreTarea,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white),),
                                                      children: [
                                                        ListTile(
                                                          title: Column(
                                                              children: [
                                                                Row(
                                                                  children: [

                                                                    const SizedBox(
                                                                      width: 5,),

                                                                    const Text(
                                                                        'Rango horario: ',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white)),

                                                                    Text(
                                                                        horaInicio +
                                                                            ' - ',
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white)),

                                                                    Text(
                                                                        horaFin,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white)),

                                                                    const SizedBox(
                                                                      width: 13,),

                                                                  ],
                                                                ),
                                                                Row(children: [
                                                                  const SizedBox(
                                                                    width: 5,),
                                                                  Text(
                                                                      'Día/s: ' +
                                                                          days,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white)),
                                                                ]),
                                                                Row(children: [
                                                                  const SizedBox(
                                                                    width: 5,),
                                                                  Text(
                                                                      '${'Avisar cada : ' +
                                                                          repeticiones} min',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white)),
                                                                ]),
                                                              ]),
                                                        ),
                                                      ]);
                                                }),
                                          )
                                      ),

                                      //linea que separa el boton
                                      const Divider(color: Colors.white,
                                        thickness: 1,
                                        height: 0,),
                                      //color de esa parte
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Theme
                                                .of(context)
                                                .dividerColor,
                                            borderRadius: const BorderRadius
                                                .vertical(
                                                bottom: Radius.circular(
                                                    15.0)),
                                          ),
                                          //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30.0)),
                                          child:
                                          IntrinsicHeight(
                                              child: Row(
                                                  children: [
                                                    //Item 1/3
                                                    modSioNo(
                                                        mod, nombreTarea,
                                                        horaInicio,
                                                        horaFin,
                                                        repeticiones),

                                                  ]
                                              )

                                          )
                                      ),

                                    ]),
                              ),
                            ]));
                  } else {
                    return Container();
                  }
                }
            );
          }
        });
  }


  Widget vertical(String mod){
    if(mod == 'si'){return const VerticalDivider(color: Colors.white, thickness: 2,);}
    else{return const Text('');}
  }

  Widget modSioNo(String mod, String nombreTarea, String horaInicio,
      String horaFin, String repeticiones){
      return Expanded(
        child: Container(
            padding: const EdgeInsets.only(left: 8),
            child: TextButton(
              onPressed: () =>
              {
                globals.nombre_tarea = nombreTarea,
                globals.hora_inicio = horaInicio,
                globals.hora_fin = horaFin,
                globals.repeticiones = repeticiones,
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => BossModSupervisedPage()
                  ),
                )
              },
              child: const Text(
                'Modificar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Color(0xFF24468E),)
                ,),
            )
        ),
      );
  }

  String diasToShowClean(String dias){
    var split = dias.replaceAll('[', '');
    split = split.replaceAll(']', '');
    split = split.replaceAll(',', '');
    dias = split.trim();
    return dias;
  }






}
