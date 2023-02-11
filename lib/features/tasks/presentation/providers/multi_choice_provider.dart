//Create a Provider
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectDaysMultiChoice = StateNotifierProvider.autoDispose<MultiChoice,List<String>>((ref) {
  return MultiChoice(ref);
});

class MultiChoice extends StateNotifier<List<String>> {
  final Ref ref;
  List<String> tags = [];

  MultiChoice(this.ref) : super([]);

  //changeTheme({required bool change}) {state = change;}

  setChoice(List<String> selectedChoices){
    tags = selectedChoices;
  }

  changeChoice({required List<String> val,required List<String> mix }){
    if (val.contains("Todos los días")) {
      if (val.last != "Todos los días") {
        val.remove("Todos los días");
      } else {
        val = ["Todos los días"];
      }
    }
    //daySelectController.text = getDiasString(sortDay(tags)).toString();
   // print('multi '+mix.toString());
    mix=val;
    tags = mix;
    state = mix;
  }

  clean(){
    tags.clear();
  }



}