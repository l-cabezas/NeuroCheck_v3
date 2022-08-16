import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/models/task_entity.dart';
import '../../presentation/providers/task_provider.dart';
import 'notification_api.dart';
import '/data/global_var/globals.dart' as globals;


class SendNotificacion {
  //hasta 'tareas'
  //var tareas = FirebaseFirestore.instance.collection('usuarios').doc(user_email).collection('tareas');
  int channelId = 0;
  var id;

  removeNotification(String nombre, BuildContext context) async {
    var taskProvider= Provider.of<TaskProvider>(context,listen: false);

    var ids;

    var tareas = FirebaseFirestore.instance.collection('usuarios').doc(
        globals.user_email).collection('tareas');

    var data = tareas.doc(nombre);

    await data.get().then((value) => ids = value['id']);

    List<dynamic> ID = ids;

    print('nombre remove ${nombre}id ${ID.isEmpty}');

    if (ID.isNotEmpty) {
      print('tareas canceladas');
      for (var element in ID) {
        NotificationApi.cancel(int.parse(element));
      }

      for (var element in ID) {
        data.update({'id': null});
      }
      print('IDs borrados');
    } else {
      print('no hay id');
    }
  }


  Future<void> notificarUNAtarea(BuildContext context, String nameTarea) async {
    var taskProvider= Provider.of<TaskProvider>(context,listen: false);
    //context.watch<TaskProvider>();
    var task =  taskProvider.getOneTask(nameTarea);
    if (nameTarea != 'tarea0') {
    task.then((value) {
      if (value.hecho == 'false') {
        List<dynamic> mapa = [];
          var horaIni = value.hora_inicio;
          var horaFin = value.hora_fin;
          var repeticiones = value.repeticiones;
          var id = value.id;
          var days = value.days;
          //makeNotification(name, horaIni, horaFin, repeticiones, context);
          var inputFormat = DateFormat.Hm();
          var inputDateInicio = inputFormat.parse(horaIni);
          var inputDateFin = inputFormat.parse(horaFin);
          if (inputDateInicio.isAfter(inputDateFin)) {
            print('Fecha de inicio despues que final');
          } else {
            print('nombre: $nameTarea');
            var rangoHoras = DateTimeRange(
                start: inputDateInicio, end: inputDateFin);
            var rango = rangoHoras.duration.inMinutes;
            var timesD = rango / int.parse(repeticiones);

            //veces que hay que repetir la notificacion según el rango horario
            var times = timesD.round();
            var inicioHora = inputDateInicio.hour;
            var inicioMin = inputDateInicio.minute;


            List<String> listaString = parseDiasString(days);
            List<String> cleanDays = [];

            for (var element in listaString) {
              if (element != '') {
                cleanDays.add(element);
              }
            }
            List<int> listaInt = parseDiasInt(listaString);

            NotificationApi.showScheludeNotificationDailyBasis(
              id: globals.channelId,
              title: nameTarea,
              body: (horaIni + ' - ' + horaFin),
              payload: '',
              hora: inicioHora,
              minuto: inicioMin,
              days: listaInt,
            );
            mapa.add(globals.channelId.toString());

            for (int i = 0; i < int.parse(repeticiones) - 1; i++) {
              globals.channelId++;
              NotificationApi.showScheludeNotificationDailyBasis(
                id: globals.channelId,
                title: nameTarea,
                body: (horaIni + ' - ' + horaFin),
                payload: '',
                hora: inicioHora,
                minuto: inicioMin,
                days: listaInt,
              );
              inicioMin += times;
              if (inicioMin >= 60) {
                inicioHora += 1;
                inicioMin = 0;
              }
              mapa.add(channelId.toString());
            }

            taskProvider.modId(nameTarea, mapa);
            print('$mapa mapa');

            if (globals.channelId == 999) {
              globals.channelId = 0;
            }
          }
        }
      });
    }
  }


   notificarTareas(BuildContext context, List<Task> listaTareas) async {
//List<Task> listaTareas, List<dynamic> mapa
   TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
   List<dynamic> mapa = [];
    for (var element in listaTareas) {
      var name = element.nombre_tarea;
      if (name != 'tarea0') {
        var done = element.hecho;
        if (done == 'false') {
          var horaIni = element.hora_inicio;
          var horaFin = element.hora_fin;
          var repeticiones = element.repeticiones;
          id = element.id;
          var days = element.days;
          //makeNotification(name, horaIni, horaFin, repeticiones, context);
          var inputFormat = DateFormat.Hm();
          var inputDateInicio = inputFormat.parse(horaIni);
          var inputDateFin = inputFormat.parse(horaFin);
          if(inputDateInicio.isAfter(inputDateFin)){
            print('Fecha de inicio despues que final');
          }else{
            print('nombre: $name');
            var rangoHoras = DateTimeRange(
                start: inputDateInicio, end: inputDateFin);
            var rango = rangoHoras.duration.inMinutes;
            var timesD = rango / int.parse(repeticiones);

            //veces que hay que repetir la notificacion según el rango horario
            var times = timesD.round();
            var inicioHora = inputDateInicio.hour;
            var inicioMin = inputDateInicio.minute;


            List<String> listaString = parseDiasString(days);
            List<String> cleanDays = [];

            for (var element in listaString) {
              if (element != ''){
                cleanDays.add(element);
              }
            }
            List<int> listaInt = parseDiasInt(listaString);

            NotificationApi.showScheludeNotificationDailyBasis(
              id: globals.channelId,
              title: name,
              body: ('$horaIni - $horaFin'),
              payload: '',
              hora: inicioHora,
              minuto: inicioMin,
              days: listaInt,
            );
            mapa.add(globals.channelId.toString());

            for (int i = 0; i < int.parse(repeticiones) - 1; i++) {
              globals.channelId++;
              NotificationApi.showScheludeNotificationDailyBasis(
                id: globals.channelId,
                title: name,
                body: ('$horaIni - $horaFin'),
                payload: '',
                hora: inicioHora,
                minuto: inicioMin,
                days: listaInt,
              );
              inicioMin += times;
              if (inicioMin >= 60) {
                inicioHora += 1;
                inicioMin = 0;
              }
              mapa.add(channelId.toString());
            }

            taskProvider.modId(name, mapa);
            print('$mapa mapa');

            if (globals.channelId == 999) {
              globals.channelId = 0;
            }
            print('tareas notificadas');

          }
        }else{
          //print('hechos');
        }
      } else {
        print('noup');
      }
    }

  }

  /*notificar(String name, String horaIni, String horaFin, String repeticiones, String days){
    List<dynamic> mapa = [];
    print('notificar');
    var inputFormat = DateFormat.Hm();
    var inputDateInicio = inputFormat.parse(horaIni);
    var inputDateFin = inputFormat.parse(horaFin);
    var rangoHoras = DateTimeRange(start: inputDateInicio, end: inputDateFin);
    var rango = rangoHoras.duration.inMinutes;
    var timesD = rango / int.parse(repeticiones);
    //veces que hay que repetir la notificacion según el rango horario
    var times = timesD.round();
    var inicioHora = inputDateInicio.hour;
    var inicioMin = inputDateInicio.minute;

    List<String> listaString = parseDiasString(days);
    List<int> listaInt = parseDiasInt(listaString);



    NotificationApi.showScheludeNotificationDailyBasis(
      id: channelId,
      title: name,
      body: (horaIni + ' - ' + horaFin),
      payload: '',
      hora: inicioHora,
      minuto: inicioMin,
      days: listaInt,
    );

    for (int i = 0; i < int.parse(repeticiones) - 1; i++) {
      channelId++;
      NotificationApi.showScheludeNotificationDailyBasis(
        id: channelId,
        title: name,
        body: (horaIni + ' - ' + horaFin),
        payload: '',
        hora: inicioHora,
        minuto: inicioMin,
        days: listaInt,
      );
      inicioMin += times;
      if (inicioMin >= 60) {
        inicioHora += 1;
        inicioMin = 0;
      }
      mapa.add(channelId.toString());
    }

    //await tareas.doc(name).update({'id': mapa});

  if (channelId == 999) {channelId = 0;}
  }*/

  List<String> parseDiasString(String days){
    List<String> lista = [];
    days = days.replaceAll('[', '');
    days = days.replaceAll(']', '');
    lista = days.split(',');
    return lista;
  }

  List<int> parseDiasInt(List<String> selectedDia){
    List<int> orden = [];
    for (var element in selectedDia) {
      if (element.contains('Todos los días')) {
        orden = [DateTime.monday,DateTime.tuesday,DateTime.wednesday,
        DateTime.thursday,DateTime.friday,DateTime.saturday,DateTime.sunday];
      } else {
        var i = selectedDia.length;
        for (int l = 0; l < i; l++) {
          switch (selectedDia[l]) {
            case 'Lunes':
              orden[0] = DateTime.monday;
              break;
            case 'Martes':
              orden[1] = DateTime.tuesday;
              break;
            case 'Miércoles':
              orden[2] = DateTime.wednesday;
              break;
            case 'Jueves':
              orden[3] = DateTime.thursday;
              break;
            case 'Viernes':
              orden[4] = DateTime.friday;
              break;
            case 'Sábado':
              orden[5] = DateTime.saturday;
              break;
            case 'Domingo':
              orden[6] = DateTime.sunday;
              break;
          }
        }
      }
    }
    return orden;
  }

}
