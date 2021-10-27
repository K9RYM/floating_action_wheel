
//import 'dart:math' as math;
import 'package:flutter/material.dart';



/// Model class for a wheel button, serves only as an encapsulation for each of the wheel
/// buttons' properties
/// Parameters:
///   String [text] (Nullable) the text to display on the button
///   IconData [icon] (Nullable) the icon to show on the button
///   Color [backgroundColor] (Nullable) Button's color
///   Function [onPressed] (Non-Null) the functionality for the button's onPressed callback
///   Color [foregroundColor] (Nullable) the color for [text]/[icon]
class WheelButton {




  WheelButton({Key key, this.text, this.icon,
    this.textSize, this.iconSize,
    this.backgroundColor=Colors.blue, this.foregroundColor=Colors.white, @required this.onPressed}):
        assert(textSize != null ? text != null : textSize==null),
        assert(iconSize != null ? icon != null : iconSize==null);


  ///   String [text] (Nullable) the text to display on the button
  final String text;


  ///   IconData [icon] (Nullable) the icon to show on the button
  final IconData icon;


  ///   Color [backgroundColor] (Nullable) Button's color
  ///
  ///   Defaults to [Colors.blue]
  final Color backgroundColor;


  ///   Color [foregroundColor] (Nullable) the color for [text]/[icon]
  ///
  ///   Defaults to [Colors.white]
  final Color foregroundColor;


  ///   Function [onPressed] (required) the functionality for the button's onPressed callback
  final Function onPressed;


  ///   Double [textSize] (Nullable) text font size for the [TextPainter]
  ///
  ///   Default size calculated based on wheel size
  final double textSize;

  ///   Double [iconSize] (Nullable) icon size for the [TextPainter]
  ///
  ///   Default size calculated based on wheel size
  final double iconSize;


//  @override
//  State<StatefulWidget> createState() => new ArcButtonState();

}

//class ArcButtonState extends State<ArcButton> {
//
//  Color currentColor;
//  Color textIconColor;
////  final Color highlightColor = Color(0xabffffff);
//
//  @override
//  void initState() {
//    super.initState();
//    currentColor = widget.backgroundColor;
//    textIconColor = widget.foregroundColor ?? Color.alphaBlend(Color(0xAAFFFFFF),widget.backgroundColor);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: GestureDetector(
//          onTapDown: (_) {
//            setState(() {
//              print('down');
//            });
//          },
//          onLongPressUp: () {
//            print('up');
//            setState(() {});
//          },
//        ));
////        widget.icon != null ? Icon(widget.icon)
////            : widget.text);
//  }
//
//
//}


