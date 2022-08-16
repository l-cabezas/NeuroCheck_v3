import 'package:flutter/cupertino.dart';

class HiddenScrollBehavior extends ScrollBehavior{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
   //sirve para quitar la sombra que tendríamos arriba y abajo
    return child;
  
  
  }
}
