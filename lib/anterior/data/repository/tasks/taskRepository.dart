import 'package:flutter/cupertino.dart';

import '../../models/competidor_entity.dart';
import '../../models/task_entity.dart';

abstract class TasksRepository{
  // get todas las tareas
  Future<List<Task>> getTasks();
  Future<List<Task>> getTasksByEmail(String email);

  //get UNA tarea
  Future<Task> getOneTask(String tarea);

  //get datos
  Future<String> getRol(String correo);
  Future<String> getFullName(String correo);
  cambiarSupervisado(String email);


  //añadir y borrar
  addTask(String nombreTarea,String horaInicio,
      String horaFinal, String repe, String modificable, String days);
  deleteTask(String nombreTarea);

  //usuarios
  //addSupervisado(String user_email, String fullname, String rol);
  //addSupervisor(String userEmail, String fullname, String rol);
  //solo supervisor
  //addUsuarioASupervisor();

  //mod hora_inicio, hora_fin, repeticiones y hecho
   modHechoTarea(String nombretarea,String check);
   modRepeticionesTarea(String nombreT,String repe);
   modHoraIniTarea(String nombreT,String horaIni);
   modHoraFinTarea(String nombreT,String horaFin);
   modId(String nombreT,List<dynamic> id);
   modDays(String nombreT,String days);

 //------------------SOLO SUPERVISADO---------------------------------------
  List<dynamic> getIDs(String nombreTarea);


  //notis
  notificarTareas(BuildContext context, List<Task> listaTareas);
  Future<void> notificarUNAtarea(BuildContext context, String nameTarea);
  Future<void> cancelarUNAtarea(BuildContext context, String nameTarea);
  modDias(String nombreT,String days);

  //gatos
  Future<String> fotoGato();
  Future<String> fotoPerro();

  //puntos
  Future<int> getPuntos();

  //competicion
  addPuntos();
  quitarPuntos();
  competir(String nombre, String email,int puntos);
  getAmigos(String correo);
  Future<List<Competidor>> showDatosCompeticion();

}