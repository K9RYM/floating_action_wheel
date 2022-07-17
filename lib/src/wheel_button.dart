


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


  WheelButton({Key? key, this.text, this.icon,
    this.textSize, this.iconSize,this.image,
    this.backgroundColor=Colors.blue, this.foregroundColor=Colors.white, required this.onPressed}):
        assert(textSize != null ? text != null : textSize==null, 'Text size given without text'),
        assert(image == null || (icon == null && text == null),'Please either pass an image OR a text/icon'),
        assert(iconSize != null ? icon != null : iconSize==null, 'Text size given without text');


  ///   String? [text] (Nullable) the text to display on the button
  final String? text;


  ///   Image? [image] (Nullable) pass an [Image] object to draw the image on the button
  ///   Should only use image parameter without text or icon parameters
  final Image? image;


  ///   IconData? [icon] (Nullable) the icon to show on the button
  final IconData? icon;


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
  final double? textSize;

  ///   Double [iconSize] (Nullable) icon size for the [TextPainter]
  ///
  ///   Default size calculated based on wheel size
  final double? iconSize;


  /* Member to hold the ImageInfo object to pass to the underlying CustomPaint in WheelSlice */
  ImageInfo? _img;

  set imageInfo(ImageInfo? value) {
    _img = value;
  }

  ImageInfo? get img => _img;



}



