import 'dart:convert';
import 'dart:io';

import 'package:neurocheck/data/repository/tasks/taskRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/notification/notification_api.dart';
import '../../firestore_service/firestore_service.dart';
import '../../models/competidor_entity.dart';
import '../../models/image_data_entity.dart';
import '../../models/task_entity.dart';
import '/presentation/tasks/supervised/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../global_var/globals.dart' as globals;
import 'package:http/http.dart' as http;

class TasksRepositoryImpl extends TasksRepository {
  final FirestoreService _tareaFirestoreService;

  TasksRepositoryImpl(this._tareaFirestoreService);

  @override
  Future<List<Task>> getTasksByEmail(String email)  async {
    var tareas =  await _tareaFirestoreService.getTasksByEmail(email);
    return tareas;
  }

  @override
  Future<List<Task>> getTasks() async {
    var tareas =  await _tareaFirestoreService.getTasks();
    return tareas;
  }


  @override
  Future<Task> getOneTask(String tarea) async {
    var task =  await _tareaFirestoreService.getOneTask(tarea);
    return task;
  }


  @override
  addTask(String nombreTarea, String horaInicio, String horaFinal, String repe, String modificable, String days) async {
    await _tareaFirestoreService.addTask(nombreTarea, horaInicio, horaFinal, repe, modificable, days);
  }

  @override
  deleteTask(String nombreTarea) {
    _tareaFirestoreService.deleteTarea(nombreTarea);
  }

  @override
  modHechoTarea(String nombretarea, String check) {
     _tareaFirestoreService.modHechoTarea(nombretarea, check);
  }

  @override
   modHoraIniTarea(String nombreT, String horaIni) {
     _tareaFirestoreService.modHoraIniTarea(nombreT, horaIni);

  }

  @override
   modHoraFinTarea(String nombreT, String horaFin) {
    _tareaFirestoreService.modHoraFinTarea(nombreT, horaFin);
  }

  @override
   modRepeticionesTarea(String nombreT, String repe) {
    _tareaFirestoreService.modRepeticionesTarea(nombreT, repe);
  }

  @override
   modId(String nombreT, List<dynamic> id) {
    _tareaFirestoreService.modId(nombreT, id);
  }


  @override
  List getIDs(String nombreTarea) {
    return _tareaFirestoreService.getIDs(nombreTarea);
  }

 /* @override
  addSupervisado(String user_email, String fullname, String rol) {
    return _tareaFirestoreService.addSupervisado(user_email, fullname, rol);
  }

  @override
  addSupervisor(String userEmail, String fullname, String rol) {
    return _tareaFirestoreService.addSupervisor(userEmail, fullname, rol);
  }*/

  /*@override
  addUsuarioASupervisor() {
    return _tareaFirestoreService.addUsuarioASupervisor();
  }*/

  @override
  cambiarSupervisado(String email) {
    return _tareaFirestoreService.cambiarSupervisado(email);
  }

  @override
  Future<String> getFullName(String correo) {
    return _tareaFirestoreService.getFullName(correo);
  }

  @override
  Future<String> getRol(String correo) {
    return _tareaFirestoreService.getRol(correo);
  }

  @override
  modDays(String nombreT, String days) {
    return _tareaFirestoreService.modDays(nombreT, days);
  }



  @override
  notificarTareas(BuildContext context, List<Task> listaTareas) async {
    for (var element in listaTareas) {
      var nameTarea = element.nombre_tarea;
      if (nameTarea != 'tarea0') {
          if (element.hecho == 'false') {
            List<dynamic> mapa = [];
            var horaIni = element.hora_inicio;
            var horaFin = element.hora_fin;
            var repeticiones = element.repeticiones;
            var days = element.days;
            //makeNotification(name, horaIni, horaFin, repeticiones, context);
            var inputFormat = DateFormat.Hm();
            var inputDateInicio = inputFormat.parse(horaIni);
            var inputDateFin = inputFormat.parse(horaFin);
            if (inputDateInicio.isAfter(inputDateFin)) {
              print('Fecha de inicio despues que final');
            } else {

              print('nombre: $nameTarea');
              var rangoHoras = DateTimeRange(start: inputDateInicio, end: inputDateFin);

              // el tiempo total de la tarea ejemplo 60 min
              var rango = rangoHoras.duration.inMinutes;


              // las veces que se va a repetir durante ese rango ejemplo cada 10 min
              // 60 / 10 = se va repetir 6 veces durante esos 6 minutos
              var timesD = rango / int.parse(repeticiones);
              //redondeamos para que sean int
              var times = timesD.round(); // 6

              //repetir cada "repeticiones"
              var minRepeticion = int.parse(repeticiones); // 10

              //veces que hay que repetir la notificacion según el rango horario
              //es decir si son 3 repeticiones en 30 min times serán 10 min

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

              print('rango $rango');
              print('inicio: $inicioHora final: $inicioMin');

              //primera notificación según la primera hora estipulada
              NotificationApi.showScheludeNotificationDailyBasis(
                id: globals.channelId,
                title: nameTarea,
                body: ('$horaIni - $horaFin'),
                payload: 'Hola!, ¿has hecho ya esto?',
                //+(horaIni + ' - ' + horaFin),
                hora: inicioHora,
                minuto: inicioMin,
                days: listaInt,
              );
              mapa.add(globals.channelId.toString());

              //repetimos la notificacion según cuantas vecces nos han indicado que lo repitamos
              var addMinutos = minRepeticion;
              var addHoras = 0;
              //si la diferencia es de más de 60 min es una hora
              if (addMinutos > 60) {
                addHoras = 1;
                //lo restante son minutos a ñadir
                addMinutos = addMinutos - 60;
              }

              //resto de notis
              for (int i = 0; i <= minRepeticion; i++) {
                //print(horaFin + ' == '+ inicioHora.toString()+':'+ inicioMin.toString());
                if (horaFin !=
                    '$inicioHora:$inicioMin') {
                  //print('horas loop : '+ (inicioHora).toString() + ' : ' + (inicioMin).toString());
                  print('hola');
                  globals.channelId++;
                  NotificationApi.showScheludeNotificationDailyBasis(
                    id: globals.channelId,
                    title: nameTarea,
                    body: 'Hola!, ¿has hecho ya esto?',
                    //+(horaIni + ' - ' + horaFin),
                    payload: '',
                    hora: inicioHora + addHoras,
                    minuto: inicioMin + addMinutos,
                    days: listaInt,
                  );
                  inicioHora += addHoras;
                  inicioMin += addMinutos;

                  mapa.add(globals.channelId.toString());
                }

                modId(nameTarea, mapa);

                if (globals.channelId == 999) {
                  globals.channelId = 0;
                }
              }
            }
          }
        }
      }
  }

  @override
  Future<void> cancelarUNAtarea(BuildContext context, String nameTarea) async {
    var task = getOneTask(nameTarea);
    task.then((value) {
      value.id?.forEach((element) {
        NotificationApi.cancel(int.parse(element));
      });
    });

  }


  Future<void> notificarUNAtarea(BuildContext context, String nameTarea) async {
    //context.watch<TaskProvider>();
    if(globals.user_rol == 'supervisado') {
      var task = getOneTask(nameTarea);
      if (nameTarea != 'tarea0') {
        task.then((value) {
          if (value.hecho == 'false') {
            List<dynamic> mapa = [];
            var horaIni = value.hora_inicio;
            var horaFin = value.hora_fin;
            var repeticiones = value.repeticiones;
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

              /*
               si tenemos un tiempo de 10:00 a 11:00, y quiere que se repita cada 10 min
               el rango es de 60 min entonces
               primera notificacion a las 10:00 y luego sería a
               10:10, 10:20, 10:30, 10:40, 10:50, 11:00 -> 6 repeticiones + la inicial

            */

              // el tiempo total de la tarea ejemplo 60 min
              var rango = rangoHoras.duration.inMinutes;


              // las veces que se va a repetir durante ese rango ejemplo cada 10 min
              // 60 / 10 = se va repetir 6 veces durante esos 6 minutos
              var timesD = rango / int.parse(repeticiones);
              //redondeamos para que sean int
              var times = timesD.round(); // 6

              //repetir cada "repeticiones"
              var minRepeticion = int.parse(repeticiones); // 10

              //veces que hay que repetir la notificacion según el rango horario
              //es decir si son 3 repeticiones en 30 min times serán 10 min

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

              print('rango $rango');
              print('inicio: $inicioHora final: $inicioMin');

              //primera notificación según la primera hora estipulada
              NotificationApi.showScheludeNotificationDailyBasis(
                id: globals.channelId,
                title: nameTarea,
                body: ('$horaIni - $horaFin'),
                payload: 'Hola!, ¿has hecho ya esto?',
                //+(horaIni + ' - ' + horaFin),
                hora: inicioHora,
                minuto: inicioMin,
                days: listaInt,
              );
              mapa.add(globals.channelId.toString());

              //repetimos la notificacion según cuantas vecces nos han indicado que lo repitamos
              var addMinutos = minRepeticion;
              var addHoras = 0;
              //si la diferencia es de más de 60 min es una hora
              if (addMinutos > 60) {
                addHoras = 1;
                //lo restante son minutos a ñadir
                addMinutos = addMinutos - 60;
              }

              //resto de notis
              for (int i = 0; i <= minRepeticion; i++) {
                //print(horaFin + ' == '+ inicioHora.toString()+':'+ inicioMin.toString());
                if (horaFin !=
                    '$inicioHora:$inicioMin') {
                  //print('horas loop : '+ (inicioHora).toString() + ' : ' + (inicioMin).toString());
                  print('hola');
                  globals.channelId++;
                  NotificationApi.showScheludeNotificationDailyBasis(
                    id: globals.channelId,
                    title: nameTarea,
                    body: 'Hola!, ¿has hecho ya esto?',
                    //+(horaIni + ' - ' + horaFin),
                    payload: '',
                    hora: inicioHora + addHoras,
                    minuto: inicioMin + addMinutos,
                    days: listaInt,
                  );
                  inicioHora += addHoras;
                  inicioMin += addMinutos;

                  mapa.add(globals.channelId.toString());
                }

                modId(nameTarea, mapa);

                if (globals.channelId == 999) {
                  globals.channelId = 0;
                }
              }
            }
          }
        });
      }
    }
  }

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
        if (element.contains('Lunes')) { orden.add(DateTime.monday);}

        if (element.contains('Martes')) {orden.add(DateTime.tuesday);}

        if (element.contains('Miércoles')) { orden.add(DateTime.wednesday);}

        if (element.contains('Jueves')) { orden.add(DateTime.thursday);}

        if (element.contains('Viernes')) { orden.add(DateTime.friday);}

        if (element.contains('Sábado')) { orden.add(DateTime.saturday);}

        if (element.contains('Domingo')) { orden.add(DateTime.sunday);}
          }
      }
    return orden;
  }

  @override
  modDias(String nombreT, String days) {
    _tareaFirestoreService.modDays(nombreT, days);
  }

  @override
  Future<String>fotoGato() async{
    List<String> varios = [];
    var foto = loadImages();

    await foto.then((value) {
      for (var element in value) {
        varios.add(element.url) ;
      }
    } );

    print('urls ${varios.first}');

    return varios.first.toString();
  }

  @override
  Future<String> fotoPerro() async {
    List<String> varios = [];
    var foto = randomImages();

    await foto.then((value) {
      varios.add(value);
    });

    print('urls ${varios.first}');

    return varios.first.toString();
  }


  static const CACHED_IMAGES = 'CACHED_IMAGES';

  Future<http.Response> getData(String uri, Map<String, String> headers) async {
    return await http.get(Uri.parse(uri), headers: headers);
  }

  Future<List<ImagesData>> loadImages() async {
    final sharedPreference = await SharedPreferences.getInstance();
    try {
      var response = await getData(
          'https://api.thecatapi.com/v1/images/search?limit=2',
          {'x-api-key': '2fd2fbe2-6ccb-4c6b-b60e-debc1f5e2711'});

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ImagesData> list = data.isNotEmpty
            ? data
            .map((e) =>
            ImagesData(url: e['url'].toString(), id: e['id'].toString()))
            .toList()
            : [];

        sharedPreference.setStringList(
            CACHED_IMAGES, data.map(
              (e) => json.encode({'url': e['url'], 'id': e['id']}),
        ).toList());

        return list;
      } else {
        return [];
      }
    } on SocketException {
      final cachedData = sharedPreference.getStringList(CACHED_IMAGES);
      if (cachedData == null) {
        return [];
      }

      return Future.value(cachedData.map((e) {
        final decodedImage = json.decode(e);
        return ImagesData(url: decodedImage['url'], id: decodedImage['id']);
      }).toList());
    } catch (error) {
      return [];
    }
  }

  Future<http.Response> getDataDog(String uri) async {
    return await http.get(Uri.parse(uri));
  }

  Future<List<ImagesData>> loadImagesDog() async {
    final sharedPreference = await SharedPreferences.getInstance();
    try {
      var response = await getDataDog('https://dog.ceo/api/breeds/image/random');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ImagesData> list = data.isNotEmpty
            ? data
            .map((e) =>
            ImagesData(url: e['url'].toString(), id: e['id'].toString()))
            .toList()
            : [];

        sharedPreference.setStringList(
            CACHED_IMAGES, data.map(
              (e) => json.encode({'url': e['url'], 'id': e['id']}),
        ).toList());

        return list;
      } else {
        return [];
      }
    } on SocketException {
      final cachedData = sharedPreference.getStringList(CACHED_IMAGES);
      if (cachedData == null) {
        return [];
      }

      return Future.value(cachedData.map((e) {
        final decodedImage = json.decode(e);
        return ImagesData(url: decodedImage['url'], id: decodedImage['id']);
      }).toList());
    } catch (error) {
      return [];
    }
  }



//https://dog.ceo/api/breeds/image/random

  Future<String> randomImages({ i = 0}) async {
    http.Response json;
    //print('json '+json.runtimeType.toString());
    json = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random/'));
    var map = jsonDecode(json.body);
    if (map['status'] == 'success') {
      return map['message'];
    } else {
      if (i <= 5) {
        return await randomImages(i: i + 1);
      } else {
        throw "Can't load image";
      }
    }
  }

  Future<int> getPuntos() async {
    var puntos =  await _tareaFirestoreService.getPuntos();
    return puntos;
  }

  Future<List<Competidor>> showDatosCompeticion() async {
    var competidores = await _tareaFirestoreService.showDatosCompeticion();
    return competidores;
  }


  addPuntos() {
     _tareaFirestoreService.addPuntos();
  }
  quitarPuntos(){
    _tareaFirestoreService.quitarPuntos();
  }
  competir(String nombre, String email,int puntos){
    _tareaFirestoreService.competir(nombre, email, puntos);
  }
  getAmigos(String correo){
    _tareaFirestoreService.getAmigos(correo);
  }



}