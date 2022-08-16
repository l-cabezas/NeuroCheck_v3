import 'package:neurocheck/data/models/competidor_entity.dart';

import '/data/models/task_entity.dart';
import '/domain/resources/Strings.dart';
import '/domain/tasks/get_tasks_uc.dart';
import 'package:flutter/cupertino.dart';

//comunicarse con los casos de uso.
class TaskProvider with ChangeNotifier {
  final GetTasksUC _getTasksUC;

  TaskProvider(this._getTasksUC);

// fields
  List<Task> _listaTareas = [];
  List<Task> _listaTareasByEmail = [];
  late Task _unaTarea;
  List<dynamic> _Ids = [];
  final String _rol = '';
  String _gatoFoto = '';
  String _perroFoto = '';
  int _puntos = 0;

  List<Competidor> _competidores = [];

  //String _errorMessage;

// getters
  List<Task> get listaTareasByEmail => _listaTareasByEmail;

  List<Task> get listaTareas => _listaTareas;

  List<Competidor> get competidores => _competidores;

  Task get unaTarea => _unaTarea;

  List<dynamic> get Ids => _Ids;

  String get rol => _rol;

  String get gatoFoto => _gatoFoto;

  String get perroFoto => _perroFoto;

  int get puntos => _puntos;


  //String get errorMessage => _errorMessage;
  Future<List<Task>> getTasks() async {
    _listaTareas = await _getTasksUC.getTasks();
    notifyListeners();
    return _listaTareas;
  }

  Future<List<Competidor>> showDatosCompeticion() async {
    _competidores = await _getTasksUC.showDatosCompeticion();
    notifyListeners();
    return _competidores;
  }

  getNotifications(BuildContext context) async {
    _listaTareas = await _getTasksUC.getTasks();
    notificarTareas(context, listaTareas);
    notifyListeners();
  }

  void getTaskByEmail(String email) async {
    _listaTareasByEmail = await _getTasksUC.getTasksByEmail(email);
    notifyListeners();
  }

  Future<Task> getOneTask(String tarea) async {
    _unaTarea = await _getTasksUC.getOneTask(tarea);
    notifyListeners();
    return _unaTarea;
  }

  void addTarea(String nombreTarea, String horaInicio, String horaFinal,
      String repe, String modificable, String days) async {
    await _getTasksUC.addTask(nombreTarea, horaInicio, horaFinal, repe,
        modificable, days);
    notifyListeners();
  }

  deleteTarea(String nombreTarea) {
    _getTasksUC.deleteTarea(nombreTarea);
    notifyListeners();
  }

  modHechoTarea(String nombreT, String check) {
    _getTasksUC.modHechoTarea(nombreT, check);
    notifyListeners();
  }

  modRepeticionesTarea(String nombreT, String repe) {
    _getTasksUC.modRepeticionesTarea(nombreT, repe);
    notifyListeners();
  }

  modHoraIniTarea(String nombreT, String horaIni) {
    _getTasksUC.modHoraIniTarea(nombreT, horaIni);
    notifyListeners();
  }

  modHoraFinTarea(String nombreT, String horaFin) {
    _getTasksUC.modHoraFinTarea(nombreT, horaFin);
    notifyListeners();
  }

  //------------notificaciones------------------------------------------------

  modId(String nombreT, List<dynamic> id) {
    _getTasksUC.modId(nombreT, id);
    notifyListeners();
  }

  Future<List<dynamic>> getIdsOfTask(String tarea) async {
    _Ids = await _getTasksUC.getIDs(tarea);
    notifyListeners();
    return _Ids;
  }

  notificarTareas(BuildContext context, List<Task> listaTareas){
    _getTasksUC.notificarTareas(context, listaTareas);
    notifyListeners();
  }

  notificarUNATarea(BuildContext context, String nameTarea){
    _getTasksUC.notificarUNATarea(context, nameTarea);
    notifyListeners();
  }

  cancelarUNAtarea(BuildContext context, String nameTarea){
    _getTasksUC.cancelarUNAtarea(context, nameTarea);
    notifyListeners();
  }

  modDias(String nombreT,String days){
    _getTasksUC.modDias(nombreT, days);
    notifyListeners();
  }

  //------------------SOLO SUPERVISADO---------------------------------------

  //-------------premios-------------------------------------------------------
  Future<String> fotoGato() async{
    _gatoFoto = await _getTasksUC.fotoGato();
    notifyListeners();
    print('task $_gatoFoto');
    return _gatoFoto;
  }

  Future<String> fotoPerro() async {
    _perroFoto = await _getTasksUC.fotoPerro();
    notifyListeners();
    return _perroFoto;

  }

  //--------------puntos competicion---------------------------------------------

  Future<int> getPuntos() async {
    _puntos =  await _getTasksUC.getPuntos();
    notifyListeners();
    return _puntos;
  }

  addPuntos()  {
    _getTasksUC.addPuntos();
    notifyListeners();
  }
  quitarPuntos(){
    _getTasksUC.quitarPuntos();
    notifyListeners();
  }
  competir(String nombre, String email,int puntos){
    _getTasksUC.competir(nombre, email, puntos);
    notifyListeners();
  }
  getAmigos(String correo){
    _getTasksUC.getAmigos(correo);
    notifyListeners();
  }

  cambiarSupervisado(String email) {
    _getTasksUC.cambiarSupervisado(email);
    notifyListeners();
  }
}
