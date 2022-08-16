import '../../data/models/competidor_entity.dart';
import '../../data/repository/tasks/taskRepository.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/task_entity.dart';

class GetTasksUC {
  final TasksRepository _tasksRepository;

  GetTasksUC(this._tasksRepository);


  Future<List<Task>> getTasks() async {
    var tareas = await _tasksRepository.getTasks();
    return tareas;
  }

  Future<List<Task>> getTasksByEmail(String email) async {
    var tareas = await _tasksRepository.getTasksByEmail(email);
    return tareas;
  }


  Future<Task> getOneTask(String tarea) async {
    var tareas = await _tasksRepository.getOneTask(tarea);
    return tareas;
  }

  Future<String> fotoGato() async {
    var gato = await _tasksRepository.fotoGato();
    return gato;

  }

  Future<String> fotoPerro() async {
    var perro = await _tasksRepository.fotoPerro();
    return perro;

  }

  addTask(String nombreTarea,String horaInicio,
      String horaFinal, String repe, String modificable, String days) async {
    await _tasksRepository.addTask(nombreTarea,
        horaInicio, horaFinal, repe, modificable, days);

  }

   deleteTarea(String nombreTarea)   {
     _tasksRepository.deleteTask(nombreTarea);
  }

   modHechoTarea(String nombreT,String check)   {
    _tasksRepository.modHechoTarea(nombreT, check);
  }

   modRepeticionesTarea(String nombreT,String repe)  {
     _tasksRepository.modRepeticionesTarea(nombreT, repe);

  }
   modHoraIniTarea(String nombreT,String horaIni)  {
    _tasksRepository.modHoraIniTarea(nombreT, horaIni);

  }
   modHoraFinTarea(String nombreT,String horaFin)  {
    _tasksRepository.modHoraFinTarea(nombreT, horaFin);
  }

   modId(String nombreT,List<dynamic> id)  {
    _tasksRepository.modId(nombreT, id);
  }

  List<dynamic> getIDs(String nombreTarea){
    return _tasksRepository.getIDs(nombreTarea);
  }

  notificarTareas(BuildContext context, List<Task> listaTareas){
    _tasksRepository.notificarTareas(context, listaTareas);
  }

  notificarUNATarea(BuildContext context, String nameTarea){
    _tasksRepository.notificarUNAtarea(context, nameTarea);
  }

  modDias(String nombreT,String days){
    _tasksRepository.modDays(nombreT, days);
  }

 cancelarUNAtarea(BuildContext context, String nameTarea){
    _tasksRepository.cancelarUNAtarea(context, nameTarea);
 }

  Future<int> getPuntos() async {
    var puntos =  await _tasksRepository.getPuntos();
    return puntos;
  }

  addPuntos()  {
  _tasksRepository.addPuntos();
  }
  quitarPuntos(){
    _tasksRepository.quitarPuntos();
  }
  competir(String nombre, String email,int puntos){
    _tasksRepository.competir(nombre, email, puntos);
  }
  getAmigos(String correo){
    _tasksRepository.getAmigos(correo);
  }


  cambiarSupervisado(String email) {
     _tasksRepository.cambiarSupervisado(email);
  }

  Future<List<Competidor>> showDatosCompeticion(){
    var competidores = _tasksRepository.showDatosCompeticion();
    return competidores;
  }


}