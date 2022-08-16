import '/behaviors/hiddenScrollBehavior.dart';
import '/domain/notification/SendNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../../../domain/notification/SendNotification.dart';
import '../../mensajes/showInfo.dart';
import '../../providers/task_provider.dart';
import '/data/global_var/globals.dart' as globals;


class AddTaskBossPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTaskBossPageState();
}

class _AddTaskBossPageState extends State<AddTaskBossPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nombreTarea = TextEditingController();


  SendNotificacion sendNotificacion = SendNotificacion();

  var INICIAL = TextEditingController();
  var FINAL = TextEditingController();
  var repes = 1;
  var horaInicio = '';
  var horaFinal = '';
  var repe = '';

  var diasElegidos = '';

  List<String> _day = [];

  List<S2Choice<String>> days = [
    S2Choice<String>(value: 'Lunes', title: 'Lunes'),
    S2Choice<String>(value: 'Martes', title: 'Martes'),
    S2Choice<String>(value: 'Miércoles', title: 'Miércoles'),
    S2Choice<String>(value: 'Jueves', title: 'Jueves'),
    S2Choice<String>(value: 'Viernes', title: 'Viernes'),
    S2Choice<String>(value: 'Sábado', title: 'Sábado'),
    S2Choice<String>(value: 'Domingo', title: 'Domingo'),
    S2Choice<String>(value: 'Todos los días', title: 'Todos los días'),
  ];




  @override
  void initState() {
    //_selectDay = daysList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir tarea',
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,),
      ),
      backgroundColor: const Color(0xfffdf7f3),
      body: Container(
        child: buildPage(),
      ),
    );
  }

  Widget buildPage() {
    print(diasElegidos);
    return Scaffold(
      //para poder presentar menus contextuales con info al usuario
      // lo que serian Toast
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(25.0),
        //en caso de pantallas pequeñas no se derbode teclado
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[

                TextFormField(
                  cursorColor: Theme.of(context).bottomAppBarColor,
                  autocorrect: false,
                  controller: nombreTarea,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      focusColor: Theme.of(context).bottomAppBarColor,
                      labelText: 'Nombre',
                      labelStyle:  TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).bottomAppBarColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
                        //  when the TextFormField in unfocused
                      ) ,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
                        //  when the TextFormField in focused
                      ) ,
                      border: const UnderlineInputBorder()
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Inserte nombre';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      //nombre_tarea = nombreTarea.text;
                    });
                  },
                ),


                const SizedBox(
                  height: 30,
                ),
                const Center(
                    child: Text('Ingrese rango horario',
                        style: TextStyle(fontSize: 15))),
                const SizedBox(
                  height: 8,
                ),
                //linea inicio cuadros que se enseñan las horas
                ListTile(
                    title: Row(children: <Widget>[
                      Expanded(
                          child:
                          Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Inicio'),
                                SizedBox(
                                  width: 130,
                                  height: 90,
                                  child: Card(
                                      color: Theme.of(context).primaryColorLight,
                                      shape: RoundedRectangleBorder(
                                          side:  BorderSide(
                                            color: Theme.of(context).cardColor,
                                          ),
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child:
                                      Container(
                                          alignment: Alignment.center,
                                          child: Text(horaInicio, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center,)
                                      )
                                  ),
                                )
                              ]
                          )
                      ),
                      const SizedBox(
                        height:30,
                        child: Text(' '),
                      ),
                      Expanded(
                          child: Column(children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Fin'),
                            SizedBox(
                              width: 130,
                              height: 90,
                              child: Card(
                                  color: Theme.of(context).primaryColorLight,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Theme.of(context).cardColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  child:  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        horaFinal,
                                        style: const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ))),
                            )
                            //Text(hora_fin),
                          ])),
                    ])
                ),

                const SizedBox(
                  height: 15,
                ),

                Row(
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 70,),
                      Container(
                        //height: MediaQuery.of(context).size.height*0.25,
                          margin: const EdgeInsets.all(2),
                          //alignment: Alignment.topCenter,
                          child: Center(
                              child:
                              CupertinoButton.filled(
                                child: const Text('Seleccionar'),
                                onPressed: () {
                                  pickRangeButton();
                                  setState(() {});},
                              )
                          )
                      ),
                    ]),



                const SizedBox(
                  height: 15,
                ),

                const Center(child: Text('¿Cuantas veces quieres que se repita?')),
                const SizedBox(
                  height: 15,
                ),


                Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                        Card(
                            color: Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            child:Container(
                              alignment: Alignment.center,
                              child: Text(
                                repe,
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ),
                      Container(
                          child: CupertinoButton(
                            child: const Text('Elegir'),
                            onPressed: () {
                              //elegirRepeticion();
                              showPickerNumber(context);
                            },
                          )
                      )
                    ]
                ),
                const SizedBox(
                  width: 5,
                ),
                const SizedBox(
                  height: 30,
                ),

                Row(children: [
                  Container(
                      child: SmartSelect<String>.multiple(
                        title: 'Elige días',
                        value: _day,
                        onChange: (selected) => setState(() {
                          if(selected.value.contains('Todos los días')){
                            selected.value = ['Todos los días'];
                            _day = selected.value;
                            _day = ordenarDia(_day);
                          }else{
                            _day = selected.value;
                            _day = ordenarDia(_day);
                          }
                        }),

                        choiceItems: days,
                        choiceType: S2ChoiceType.chips,
                        choiceStyle: const S2ChoiceStyle(
                          //outlined: true,
                        ),
                        modalType: S2ModalType.popupDialog,
                        modalConfirm: true,
                        tileBuilder: (context, state) {
                          return Expanded(
                              child: S2Tile.fromState(
                                state,
                                isTwoLine: true,
                                leading: Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.calendar_today_rounded),
                                ),
                              ));
                        },
                      )

                  ),

                ],),
                Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  const SizedBox(height: 10,),
                  botonAdd(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }



  showPickerNumber(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(
            data: [
              const NumberPickerColumn(
                initValue: 1,
                begin: 0,
                end: 999,
              ),
            ]
        ),
        delimiter: [
          PickerDelimiter(
              child: Container(
                width: 70.0,
                alignment: Alignment.center,
                child: const Text('Minutos'),//Icon(Icons.more_vert),
              ))
        ],
        hideHeader: true,
        title: const Text("Selecciona cada cuanto quieres que se repita"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onCancel: (){
          setState(() {
            repe = '';
          });
        },
        onConfirm: (Picker picker, List value) {
          setState(() {
            var split = value.toString().replaceAll('[', '');
            split = split.replaceAll(']', '');
            repe = split;
          });
          print(value.toString());
          print(picker.getSelectedValues());
        }).showDialog(context);
  }

  pickRangeButton(){
    String valorINICIAL;
    String valorFinal;
    Picker ps = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kHM_AP),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
          var ini= (picker.adapter as DateTimePickerAdapter).value;
          valorINICIAL= parsearHora(ini!);
          //valorINICIAL = ini!.hour.toString() +':'+ ini.minute.toString();
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kHM_AP) ,
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);

          var ini= (picker.adapter as DateTimePickerAdapter).value;
          valorFinal = parsearHora(ini!);
          //ini!.hour.toString() +':'+ ini.minute.toString();
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel')),
      TextButton(
          onPressed: () {

            ps.onConfirm!(ps, ps.selecteds);
            pe.onConfirm!(pe, pe.selecteds);

            print('valor');
            print(valorINICIAL);
            print('valor final');
            print(valorFinal);

            horaInicio = valorINICIAL;
            horaFinal = valorFinal;

            var inputFormat = DateFormat.Hm();
            var inputDateInicio = inputFormat.parse(valorINICIAL);
            var inputDateFin = inputFormat.parse(valorFinal);
            if(inputDateInicio.isAfter(inputDateFin)){
              ShowInfo().showMyDialog(context, 'La hora de inicio va antes que la final',
                  'Casi es mejor cambiarla');
            }
            setState(() {});
            Navigator.pop(context);
          },
          child: const Text('Ok')
      ),


    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Elija rango horario"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text("Inicio:"),
                  ps.makePicker(),
                  const Text("Fin:"),
                  pe.makePicker(),
                ],
              ),
            ),
          );
        });

  }



  /////////////////////ELEGIR LOS DIAS//////////////////////////

  List<String> bufferDias = [];

  List<String> ordenarDia(List<String> selectedDia){
    List<String> orden = ['','','','','','','',''];
    for (var element in selectedDia) {
      if (element.contains('Todos los días')) {
        orden[7] = 'Todos los días';
      } else {
        var i = selectedDia.length;
        for (int l = 0; l < i; l++) {
          switch (selectedDia[l]) {
            case 'Lunes':
              orden[0] = 'Lunes';
              break;
            case 'Martes':
              orden[1] = 'Martes';
              break;
            case 'Miércoles':
              orden[2] = 'Miércoles';
              break;
            case 'Jueves':
              orden[3] = 'Jueves';
              break;
            case 'Viernes':
              orden[4] = 'Viernes';
              break;
            case 'Sábado':
              orden[5] = 'Sábado';
              break;
            case 'Domingo':
              orden[6] = 'Domingo';
              break;
          }
        }
      }
    }
    return orden;
  }

  String trimear(String show){
    var split = show.replaceAll('[', '');
    split = split.replaceAll(']', '');
    split = split.replaceAll(',', '');
    show = split.trim();
    return show;
  }


  @override
  void dispose() {
    super.dispose();
    // nameController.dispose();
    nombreTarea.dispose();
    // passwordController.dispose();
  }

  String parsearHora(DateTime date){
    var control = '';
    String hora = '';
    if (date.minute.toString().length == 1) {
      control = '0${date.minute}';
    } else {
      control = date.minute.toString();
    }
    hora = ('${date.hour}:$control');
    return hora;
  }

  Widget botonAdd(){
    var taskProvider= context.watch<TaskProvider>();
    return FloatingActionButton.extended(
      heroTag: "boton_add_tarea_supervisado2022",
      //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
      backgroundColor: const Color(0xff2b56bd),
      foregroundColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          taskProvider.addTarea(nombreTarea.text, horaInicio, horaFinal, repe, 'no', _day.toString());
          //añadimos la notificacion
          taskProvider.notificarUNATarea(context, nombreTarea.text);

          taskProvider.getTasks().then(
                  (value) =>
                  ShowInfo().showDismissableFlushbar(context, '  Tarea añadida! ')
          );

          nombreTarea.clear();
          horaFinal = '';
          horaInicio = '';

          List<String> borrar = [];
          _day= borrar;

          globals.repeticiones = repe;
          setState(() {});
          Navigator.pop(context);
        }
        //ShowInfo().showMessage(context, 'Tarea añadida');
      },
      label: const Text('Añadir tarea'),
    );
  }
















}

