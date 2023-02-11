import 'dart:developer';
import 'dart:isolate';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neurocheck/core/services/firebase_services/firebase_caller.dart';
import 'package:neurocheck/features/home/data/models/task_model.dart';

import '../../../core/services/firebase_services/firestore_paths.dart';
import '../../simple_notifications/notifications.dart';

bool checkRange(String ini, String fin, String avisar){

  var splitIni = ini.split(':');
  //pasamos all a minutos
  int iniH = int.parse(splitIni[0])*60 + int.parse(splitIni[1]);

  var splitFin = fin.split(':');
  //pasamos all a minutos
  int finH = int.parse(splitFin[0])*60 + int.parse(splitFin[1]);

  log('AVISAR ${avisar}');
  if(finH - iniH  < int.parse(avisar)) {
    return false;
  }

  return true;
}

readDBU(SendPort sendPort) async {
  var db = await FirebaseFirestore.instance.collection('users/XaEKsoOcAjPLJg5YriKs6RRxvHz2/tasks');
  db.snapshots().listen(
        (event) {
      print("current data: ${event.docs.asMap()}");
      event.docs.forEach((element) {

        print("list data: ${element.id}");
        db.doc(element.id).get().then(
              (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            var task = TaskModel.fromMap(data, element.id);
            //hacemos las notis y obtenemos su id
            if(task.isNotificationSet == 'false'){

            }
            print("list2 data: ${task.taskName}");
            // ...
          },);
        //TaskModel.fromMap(task, element.id)

      });

    },
    onError: (error) => print("Listen failed: $error"),
  );

  var dBss = await FirebaseFirestore.instance.collection('users/XaEKsoOcAjPLJg5YriKs6RRxvHz2/tasksBoss');
  dBss.snapshots().listen(
        (event) => print("current data: ${event.size}"),
    onError: (error) => print("Listen failed: $error"),
  );
}


String getStrDay(int day){
  String d = '';
  switch(day){
    case 1: d = 'Lunes'; break;
    case 2: d = 'Martes'; break;
    case 3: d = 'Miércoles'; break;
    case 4: d = 'Jueves'; break;
    case 5: d = 'Viernes'; break;
    case 6: d = 'Sábado'; break;
    case 7: d = 'Domingo'; break;
  }

  return d;

}

//hago esto para gestionar de forma más fácil la base de datos
List<String> saveDays(String days){
  if(days == '[Todos los días]'){
    days = '[Lunes, Martes, Miércoles, Jueves, Sábado, Domingo]';
  }

  days = reformDays(days);

  var amountOfDays = days.split(' ');

  return amountOfDays;

  //return days;
}

Future<int> stablishNoti(int day, String hora, String taskName){
  var h = hora.split(':');
  log('**** stablishNoti');
  return createReminderNotification(day,int.parse(h[0]),int.parse(h[1]), taskName);

}

String reformDays(String days){
  var left = days.replaceAll('[','');
  var right = left.replaceAll(']','');
  var center = right.replaceAll(',','');
  return center;

}

Future<List<int>> setNotiInSupervised(TaskModel taskModel){
  List<String> listDays = [];
  taskModel.days?.forEach((element) {
    listDays.add(element);
  });
  log('***** setNOtiInSupervised ${taskModel.taskName}');
  // devuelve ids
  return setNotiHours(taskModel.begin!, taskModel.end!,taskModel.numRepetition!, listDays, taskModel.taskName);

}


Future<List<int>> setNotiHours(String ini, String fin, int avisar, List<String> day, String taskName) async {
  List<int> list = [];
  var splitIni = ini.split(':');
  //pasamos all a minutos
  int iniH = int.parse(splitIni[0])*60 + int.parse(splitIni[1]);

  var splitFin = fin.split(':');
  //pasamos all a minutos
  int finH = int.parse(splitFin[0])*60 + int.parse(splitFin[1]);

  int cantDias = day.length;

  for(int j = 0; j< cantDias;j++) {
    int chooseDay = getNumDay(day.elementAt(j));
    for (int i = iniH; i <= finH; i += avisar) {
      var duration = Duration(minutes: i);
      // para evitar que guarde 8 en vez de 08
      if (duration.inMinutes.remainder(60) < 10) {
        log('**** list add ${taskName}');
        list.add(
            await stablishNoti(chooseDay, '${duration.inHours}:0${duration.inMinutes.remainder(60)}',taskName));
      } else {
        log('**** list add ${taskName}');
        list.add(await stablishNoti(chooseDay,
            '${duration.inHours}:${duration.inMinutes.remainder(60)}',taskName));
      }

    }
  }
  return list;
}


//calcular las horas a las que hay que avisar

List<String> notiHours(String ini, String fin, String avisar){
  var horas = [''];
  var splitIni = ini.split(':');
  //pasamos all a minutos
  int iniH = int.parse(splitIni[0])*60 + int.parse(splitIni[1]);

  var splitFin = fin.split(':');
  //pasamos all a minutos
  int finH = int.parse(splitFin[0])*60 + int.parse(splitFin[1]);

  for(int i = iniH; i <= finH ; i += int.parse(avisar) ){
    var duration = Duration(minutes:i);
    //log('HORAS.ADD ${duration.inHours}:${duration.inMinutes.remainder(60)}');
    // para evitar que guarde 8 en vez de 08

    if(duration.inMinutes.remainder(60)< 10){
      horas.add('${duration.inHours}:0${duration.inMinutes.remainder(60)}');
    }else{
      horas.add('${duration.inHours}:${duration.inMinutes.remainder(60)}');
    }

  }

  horas.removeWhere((item) => item == '');

  return horas;
}


String getTranslateDay(){
  var actualDay = DateTime.now().weekday;
  String day = '';
  switch(actualDay){
    case 1:
      day = 'Lunes';
      break;
    case 2:
      day = 'Martes';
      break;
    case 3:
      day ='Miércoles';
      break;
    case 4:
      day = 'Jueves';
      break;
    case 5:
      day = 'Viernes';
      break;
    case 6:
      day = 'Sábado';
      break;
    case 7:
      day = 'Domingo';
      break;
  }
  return day;
}

Future<List<int>> setNotification(TaskModel taskModel) async {
  log('**** SET NOTIFICATION');
  List<int> allIds = [];
  var splitIni = taskModel.begin?.split(':');
  //pasamos all a minutos
  int iniH = int.parse(splitIni![0])*60 + int.parse(splitIni[1]);

  var splitFin = taskModel.end?.split(':');
  //pasamos all a minutos
  int finH = int.parse(splitFin![0])*60 + int.parse(splitFin[1]);

  int? cantDias = taskModel.days?.length;
  //notificacion por cada día
  for(int j = 0; j< cantDias!;j++) {

    int chooseDay = getNumDay(taskModel.days?.elementAt(j));

    // 13:00 hasta 14:00 cada 4 min
    for (int i = iniH; i <= finH; i += taskModel.numRepetition!) {
      int idNotification = DateTime.now().millisecondsSinceEpoch.remainder(100000);
      allIds.add(idNotification);
      var duration = Duration(minutes: i);
      await makeNotiAwesome(idNotification,taskModel.taskName,
          chooseDay, duration.inHours,(duration.inMinutes-60*duration.inHours));
    }
  }

  if(taskModel.editable == 'true') {
    await FirebaseCaller().updateData(
      path: FirestorePaths.taskById(GetStorage().read('uidUsuario')!,
          taskId: taskModel.taskId),
      data: {
        'idNotification': allIds,
      },
      builder: (data) {},
    );
  } else{
    await FirebaseCaller().updateData(
      path: FirestorePaths.taskBossById(GetStorage().read('uidUsuario')!,
          taskId: taskModel.taskId),
      data: {
        'idNotification': allIds,
      },
      builder: (data) {  },
    );
  }

  return allIds;

}

makeNotiAwesome(int idNotification, String taskName, int day, int hour, int minute ) async {
  //int idNotification, String taskName, int day, int hour, int minute

  log('**** MAKENOTI ${idNotification} ${taskName} ${day} ${hour} ${minute}');
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: idNotification,
      channelKey: 'scheduled_channel',
      title: 'Do ${taskName} ',
      body: 'venga va que toca',//'Rango horario ${taskModel.begin} ${taskModel.end}',
      notificationLayout: NotificationLayout.Default,
      wakeUpScreen: true,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Hecho',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: day,
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      repeats: true,
      preciseAlarm: true,
    ),
  );
}

int getNumDay(String day){
  int num = 0;
  switch(day){
    case 'Lunes': num = 1; break;
    case 'Martes': num = 2; break;
    case 'Miércoles': num = 3; break;
    case 'Jueves': num = 4; break;
    case 'Viernes': num = 5; break;
    case 'Sábado': num = 6; break;
    case 'Domingo': num = 7; break;
  }

  return num;
}
