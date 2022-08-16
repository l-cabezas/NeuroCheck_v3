/*
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:neurocheck/device/shared_preferences/shared_preferences.dart';
import 'package:neurocheck/presentation/providers/userApp_provider.dart';
import 'package:provider/provider.dart';

import '/data/global_var/globals.dart' as globals;
import '/presentation/competicion/competition_page.dart';
import '/presentation/profile/profile_page.dart';
import '/presentation/providers/task_provider.dart';
import '/presentation/tasks/supervised/completedTasks_page.dart';
import '/presentation/tasks/supervised/tasks_page.dart';
import '/presentation/tasks/boss/completeTasks_boss_page.dart';
import '/presentation/tasks/boss/tasksBoss_page.dart';
import '../../domain/notification/SendNotification.dart';
import '../../domain/notification/notification_api.dart';
import '../domain/users/GestionUsuarios.dart';


class MainTabsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainTabsPageState();

}

class _MainTabsPageState extends State<MainTabsPage>{
  GestionUsuarios gestionUsuarios = GestionUsuarios();
  SendNotificacion sendNotificacion =  SendNotificacion();
  //tiempo reinicio
  late Timer _timer;
  late DateTime _now;
  Widget? _widget;

  @override
  void initState() {
    super.initState();
    //notis
    NotificationApi.init(initScheduled: true);
    listenNotification();
    initUser();

  }

  void postFrame(void Function() callback) =>
      WidgetsBinding.instance.addPostFrameCallback(
            (_) {
          // Execute callback if page is mounted
          if (mounted) callback();
        },
      );

  //setState rebuild
  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }




  Future<void> initNotis() async {
    var taskProvider= Provider.of<TaskProvider>(context, listen: false);
    taskProvider.notificarTareas(context, taskProvider.listaTareas);
  }

  Future<void> initUser() async {
    var userProvider= Provider.of<UserAppProvider>(context, listen: false);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    userProvider.inicializarUser(uid!);
  }




  @override
  Widget build(BuildContext context) {
    //var taskProvider= context.watch<TaskProvider>();

    //Provider.of<TaskProvider>(context,listen: false);
    //RESET TAREAS
    */
/*var inputFormat = DateFormat.Hm();
    // Sets the current date time.
    _now = DateTime.now();
    // Creates a timer that fires every minute.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Updates the current date time.
        _now = DateTime.now();
        String horaActual = inputFormat.format(_now);
        String cambio = '00:00';

        if(horaActual == cambio){
          taskProvider.listaTareas.forEach((element) {
            taskProvider.modHechoTarea(element.nombre_tarea, 'false');
          });
        }

      });
    },
    );*//*



    /////////////////////////
    return  (globals.user_rol == 'supervisor')
        ? tablaSupervisor()
        : tabla();

  }



  Widget tabla(){
    //Isolate.spawn(reChargeNotifications(), 'hecho');
    return DefaultTabController(
      //headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
          elevation: 0,
          centerTitle: true,

          bottom: const TabBar(
            physics: BouncingScrollPhysics(),
            labelColor: Color(0xFF464646),
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            isScrollable: true,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.task),
                text: "   Tareas  ",
              ),
              Tab(icon: Icon(Icons.done_all),
                  text: "   Tareas Hechas  "
              ),

              Tab(icon: Icon(Icons.account_circle),
                  text: "    Perfil    "
              ),
              Tab(icon: Icon(Icons.tab),
                  text: " Competicion "
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TasksPage(),
            CompleteTasksPage(),
            //AddTaskPage(),
            ProfilePage(),
            CompetitionPage()
          ],
        ),
      ),
    );
  }

  Widget tablaSupervisor(){
    return DefaultTabController(
      //headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
          //title: Text('NeuroCheck'),
          elevation: 0,
          centerTitle: true,
          title:  IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/cambiarEmail');
            },
          ),
          bottom: const TabBar(
            physics: BouncingScrollPhysics(),
            labelColor: Color(0xFF464646),
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            isScrollable: true,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.task),
                text: " Tareas sin hacer ",
              ),
              Tab(icon: Icon(Icons.done_all),
                  text: "  Tareas Hechas "
              ),
              Tab(icon: Icon(Icons.account_circle),
                  text: "    Perfil    "
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TasksBossPage(),
            CompleteTasksBossPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }



  void listenNotification() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      //Navigator.of(context).push(MaterialPageRoute(builder:(context)=> SecondPage(payload: payload), ));
  Navigator.of(context).pushReplacementNamed('/maintabs');

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  void resetTask(List tareas){

  }

  reChargeNotifications(){
    var taskProvider= Provider.of<TaskProvider>(context, listen: false);
    taskProvider.getTasks();
    taskProvider.notificarTareas(context, taskProvider.listaTareas);
  }


}*/
