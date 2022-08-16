import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neurocheck/presentation/tasks/boss/bossMod_Supervised_page.dart';

import '/presentation/mensajes/showInfo.dart';
import '/presentation/providers/task_provider.dart';
import '/presentation/tasks/boss/addTask_boss_page.dart';
import '/presentation/tasks/boss/modTask_boss_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/global_var/globals.dart' as globals;



class CompleteTasksBossPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CompleteTasksBossPageState();
}

class _CompleteTasksBossPageState extends State<CompleteTasksBossPage> {

  late ScrollController controller;

  // value set to false
  bool _value = false;



  @override
  void initState() {
    super.initState();
    var taskProvider= Provider.of<TaskProvider>(context, listen: false);
    taskProvider.getTasks();

  }

  @override
  Widget build(BuildContext context) {
    var taskProvider= Provider.of<TaskProvider>(context, listen: false);

    return
      Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: listView(),
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: Theme.of(context).primaryColor,
          heroTag: 'boton_appTab_bar',
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

  var BaseDatos = FirebaseFirestore.instance.collection('usuarios').doc(globals.user_email).collection('tareas');

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
                  var modificable = snapshot.data?.docs[index]['modificable'];
                  //no contamos la tarea de prueba
                  if (nombreTarea == 'tarea0') {
                    return const Divider(color: Colors.white,);
                  } else {
                    if (done == 'true') {
                      _value = true;
                    } else {
                      _value = false;
                    }
                  }

                  //print(done);
                  if (done == 'true') {
                    days = diasToShowClean(days);
                    //no contamos la tarea de prueba
                    if (nombreTarea == 'tarea0') {
                      return const Text(''); //Divider(color: Colors.white,);
                    } else {
                      if (done == 'true') {
                        _value = true;
                      } else {
                        _value = false;
                      }
                    }

                    return Dismissible(
                        key:UniqueKey(),
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          color: const Color(0xFFFD4F4F),
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete),
                        ),
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmar"),
                                content: const Text("¿Seguro que quieres borrar esto?"),
                                actions: <Widget>[
                                  CupertinoButton(
                                      onPressed: () {
                                        taskProvider.deleteTarea(nombreTarea);
                                        taskProvider.getTasks().then((value) =>
                                            ShowInfo().showDismissableFlushbar(context,
                                                '  Tarea borrada! '));
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("BORRAR")
                                  ),
                                  CupertinoButton(
                                    onPressed: () => Navigator.of(context).pop(false),
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
                                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                color: Theme.of(context).cardColor,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black,),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),//Color(0xFF81D4FA),
                                child: Column(
                                    children: [
                                      ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)),
                                          title: Center(
                                            //info que saca
                                            child: StatefulBuilder(builder: (context, setState){
                                              return ExpansionTile(
                                                  leading: const ImageIcon(AssetImage("assets/clipboard.png"),
                                                    size: 25, color: Colors.white,),
                                                  title:
                                                  Text(' ' + nombreTarea, style: const TextStyle(color: Colors.white),),
                                                  children : [
                                                    ListTile(
                                                      title : Column(children: [
                                                        Row(children: [

                                                          const SizedBox(width: 5,),

                                                          const Text('Rango horario: ', style: TextStyle(color: Colors.white)),

                                                          Text(horaInicio + ' - ', style: const TextStyle(color: Colors.white)),

                                                          Text(horaFin, style: const TextStyle(color: Colors.white)),

                                                          const SizedBox(width: 13,),

                                                          Text('repe: '+repeticiones, style: const TextStyle(color: Colors.white)),

                                                        ],
                                                        ),
                                                        Row(children: [
                                                          const SizedBox(width: 5,),
                                                          Text('Días: '+days, style: const TextStyle(color: Colors.white)),
                                                        ]),
                                                        Row(children: [
                                                          const SizedBox(width: 5,),
                                                          Text('${'Avisar cada : '+repeticiones} min', style: const TextStyle(color: Colors.white)),
                                                        ]),
                                                      ]),
                                                    ),
                                                  ]);
                                            }),
                                          )
                                      ),

                                      //linea que separa el boton
                                      const Divider(color: Colors.white,thickness: 1, height: 0,),
                                      //color de esa parte
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).dividerColor,
                                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15.0)),
                                          ),
                                          //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30.0)),
                                          child:
                                          IntrinsicHeight(
                                              child: Row(
                                                  children: [
                                                    //Item 1/3
                                                    Expanded(
                                                      child: Container(
                                                          padding: const EdgeInsets.only(left: 8),
                                                          child: TextButton(
                                                            onPressed: () =>
                                                            {

                                                              globals
                                                                  .nombre_tarea =
                                                                  nombreTarea,
                                                              globals
                                                                  .hora_inicio =
                                                                  horaInicio,
                                                              globals
                                                                  .hora_fin =
                                                                  horaFin,
                                                              globals
                                                                  .repeticiones =
                                                                  repeticiones,
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        BossModSupervisedPage()
                                                                ),
                                                              )
                                                            },
                                                            child: const Text(
                                                              'Modificar',
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                fontSize: 17,
                                                                color: Color(
                                                                    0xFF24468E),)
                                                              ,),
                                                          )
                                                      ),
                                                    ),
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

  Widget listView(){
    var taskProvider= Provider.of<TaskProvider>(context, listen: false);
    late var ids;
    if(taskProvider.listaTareas.isEmpty){
      //print(taskProvider.listaTareas.isEmpty);
      if(taskProvider.listaTareas.length ==0){return const Text('');}
      return const Center(child: CupertinoActivityIndicator(radius: 25,));
    }
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskProvider.listaTareas.length,
          itemBuilder: (BuildContext context, int index) {
            var tarea = taskProvider.listaTareas[index];
            var done = tarea.hecho;
            var mod = tarea.modificable;
            //solo vemos las tareas puestas por el supervisor es decir las no modificables
            if (mod == 'no') {
              //print(done);
              if (done == 'true') {
                var nombreTarea = tarea.nombre_tarea;
                //print(nombreTarea);
                var horaInicio = tarea.hora_inicio;
                var horaFin = tarea.hora_fin;
                var repeticiones = tarea.repeticiones;
                var days = tarea.days;
                days = diasToShowClean(days);

                //no contamos la tarea de prueba
                if (nombreTarea == 'tarea0') {
                  return const Text(''); //Divider(color: Colors.white,);
                } else {
                  if (done == 'true') {
                    _value = true;
                  } else {
                    _value = false;
                  }
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
                                    taskProvider.deleteTarea(nombreTarea);
                                    taskProvider.getTasks().then((value) =>
                                        ShowInfo().showDismissableFlushbar(
                                            context,
                                            '  Tarea borrada! '));
                                    Navigator.of(context).pop(true);
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
                                  //Hero(tag: 'apa423423', child: Text(''),),
                                  ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30.0)),
                                      title: Center(
                                        //info que saca
                                        child: StatefulBuilder(
                                            builder: (context, setState) {
                                              return ExpansionTile(
                                                  leading: const ImageIcon(
                                                    AssetImage(
                                                        "assets/clipboard.png"),
                                                    size: 25,
                                                    color: Colors.white,),
                                                  title:
                                                  Text(' ' + nombreTarea,
                                                    style: const TextStyle(
                                                        color: Colors.white),),
                                                  children: [
                                                    ListTile(
                                                      title: Column(children: [
                                                        Row(children: [

                                                          const SizedBox(width: 5,),

                                                          const Text(
                                                              'Rango horario: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),

                                                          Text(horaInicio +
                                                              ' - ',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),

                                                          Text(horaFin,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),

                                                          const SizedBox(width: 13,),

                                                        ],
                                                        ),
                                                        Row(children: [
                                                          const SizedBox(width: 5,),
                                                          Text('Día/s: ' + days,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ]),
                                                        Row(children: [
                                                          const SizedBox(width: 5,),
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
                                        borderRadius: const BorderRadius.vertical(
                                            bottom: Radius.circular(15.0)),
                                      ),
                                      //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30.0)),
                                      child:
                                      IntrinsicHeight(
                                          child: Row(
                                              children: [
                                                //Item 1/3
                                                Expanded(
                                                  child: Container(
                                                      padding: const EdgeInsets.only(
                                                          left: 8),
                                                      child: TextButton(
                                                        onPressed: () =>
                                                        {
                                                          globals.nombre_tarea =
                                                              nombreTarea,
                                                          globals.hora_inicio =
                                                              horaInicio,
                                                          globals.hora_fin =
                                                              horaFin,
                                                          globals.repeticiones =
                                                              repeticiones,
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    ModTaskBossPage()
                                                            ),
                                                          )
                                                        },
                                                        child: const Text(
                                                          'Modificar',
                                                          textAlign: TextAlign
                                                              .center,
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(
                                                                0xFF24468E),)
                                                          ,),
                                                      )
                                                  ),
                                                ),
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
            }else{
              return Container();
            }
          }
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
