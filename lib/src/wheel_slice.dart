
import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart' ;
import 'package:flutter/widgets.dart';



/// the Widget that holds an actual button and Arc Painter
class WheelSlice extends StatefulWidget {

  final String? text;
  final IconData? icon;
  final Color backgroundColor;
  final Function onPressed;
  final Color foregroundColor;


  final double stroke;
  final double startAngle;
  final double sweepAngle;
  final double? textSize;
  final double? iconSize;
  final double activePart;
  final ImageInfo? image;
  final int index;



  WheelSlice(this.startAngle, this.sweepAngle, this.index,
      {Key? key, this.text, this.icon, this.backgroundColor = Colors.blue,
        this.foregroundColor = Colors.white,
        this.textSize, this.iconSize,this.image,
        required this.onPressed,this.stroke=120,this.activePart=1}):
        assert(image == null || (icon == null && text == null));



  @override
  State<StatefulWidget> createState() => new WheelSliceState();

}

class WheelSliceState extends State<WheelSlice> {

  bool isPressed = false;

  late  double fontSize;
  late  double iconSize;
  late  Color _currentColor;
  late Color textIconColor;
  late Color _highlightColor;
  var gesture;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.backgroundColor;

    _highlightColor = Color.alphaBlend(Color(0x70FFFFFF), _currentColor);

    textIconColor = widget.foregroundColor;
//    textIconColor = Color.alphaBlend(Color(0xAAFFFFFF), widget.backgroundColor);

    /**init for default icon size if no text provided **/
    fontSize = widget.stroke / 5;

    if (widget.text != null) {
      if (widget.textSize != null)
        fontSize = widget.textSize!;
      else {
        if (widget.stroke <= 90)
          fontSize = 20.0 - widget.text!.length * 0.8;
        else if (widget.stroke <= 120)
          fontSize = 26.0
              - math.pow(widget.text!.length, 0.8);
        else
          fontSize = 32.0 - widget.text!.length * 0.6;

        fontSize = fontSize * (math.pow(2,widget.activePart)/2);
      }
    }

    iconSize = widget.iconSize ?? fontSize;



    /**special gesture detection to handle proper highlight effect
        note: implementing onLongPress callbacks causes the quick tap highlight effect not to work **/
    gesture = GestureDetector(
      onTap: () {
        widget.onPressed();
        setState(() {
          isPressed =true;
        });
        //needed to force highlight effects on quick taps
        Timer(Duration(microseconds: 500), () =>
            setState(() {
              isPressed = false;
            }));
      },
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
    );


  }


  @override
  Widget build(BuildContext context) {




    return
      ClipPath(
        clipper: ArcClip(widget.startAngle, widget.sweepAngle, widget.index),
        child: CustomPaint(
            painter: ArcPainter(widget.startAngle, widget.sweepAngle,
                isPressed ? _highlightColor : _currentColor,
                widget.index, widget.stroke,fontSize,iconSize,
                text: widget.text,
                icon: widget.icon,
                image:widget.icon ==null?widget.image:null,
                foregroundColor: textIconColor),
            child: gesture
        ),
      );
  }
}













/// the Custom painter to draw an Arc on the wheel
class ArcPainter extends CustomPainter {


  final double stroke;
  final double fontSize;
  final double iconSize;
  final double _startingAngle;
  final double _offsetAngle;
  Color paintColor;
  int index;
  final Color foregroundColor;
  final String? text;
  final IconData? icon;
  final ImageInfo? image;
  final double h=30,w=30;

//  final int wheelSize;

  int get getIndex => index;


  ArcPainter(this._startingAngle, this._offsetAngle, this.paintColor, this.index,
      this.stroke, this.fontSize,this.iconSize,
      {this.text, this.icon,this.image, this.foregroundColor = Colors.white});

  /// painting arc button on screen,
  /// creating new paint object based on given color and draw arc with zero based rects **/
  @override
  void paint(Canvas canvas, Size size) {
    final side = size.width < size.height ? size.width : size.height;
    final paint = Paint();

    paint.color = paintColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = stroke;


    Rect _rect = new Rect.fromLTWH(0.0, 0.0, side, size.height);

    canvas.drawArc(
        _rect,
        _startingAngle,
        _offsetAngle,
        false,
        paint
    );


    /** offset from origin **/
    double offset = stroke == 180.0 ? 2 : 4;

    /** determine arc center points for drawing text/icon**/
    double radius = side / 3 + offset;

    final x = (radius) * math.cos(_startingAngle + (_offsetAngle / 2));
    final y = (radius) * math.sin(_startingAngle + (_offsetAngle / 2));

    if (image != null) {
      paintImage(canvas: canvas, rect:
      Rect.fromLTWH(
          (x + side / 2) - (h / 2),
          (y + side / 2) - (w / 2),
          h,
          w),
          image: image!.image,
          // fit: BoxFit.fill,
          scale: (stroke / 100) + 1);
    }
    else {

      /* draw text and/or icon on (x,y) */
      if (text != null && icon != null) {
        _drawText(canvas, text!, x, y - fontSize / 14, side, foregroundColor);
        _drawIcon(canvas, icon!, x, y + iconSize / 14, side, foregroundColor);
      }
      else if (text != null)
        _drawText(canvas, text!, x, y, side, foregroundColor);
      else if (icon != null)
        _drawIcon(canvas, icon!, x, y, side, foregroundColor);
    }
  }





  void _drawIcon(Canvas canvas, IconData icon, double x, double y, double side,
      Color color) {
    TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        color: color,
        fontSize: iconSize ,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage, // This line is mandatory for external icon packs
      ),
    );
    tp.layout();
    tp.paint(canvas,
      new Offset(
        (side / 2 + x) - (tp.width / 2),
        text != null ? (side / 2 + y) - (tp.height / 2) + iconSize /2
            :
        (side / 2 + y) - (tp.height / 2),
      ),);
  }



  void _drawText(Canvas canvas, String name, double x, double y, double side,
      Color color) {

    TextStyle style = TextStyle(color: color, fontSize: fontSize);

    TextSpan span = TextSpan(style: style, text: name);

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
      maxLines: 2,
    );
    tp.layout(maxWidth: side);


    tp.paint(
      canvas,
      new Offset(
        (side / 2 + x) - (tp.width / 2),
        icon != null ? (side / 2 + y) - (tp.height / 2) - fontSize / 3
            :
        (side / 2 + y) - (tp.height / 2),
      ));

  }


  @override
  bool shouldRepaint(covariant ArcPainter oldDelegate) =>
      oldDelegate.paintColor != paintColor;
}




///
/// the CustomClipper which draws the clip to define the wheel button's edges
/// for touch pointers detection
class ArcClip extends CustomClipper<Path> {

  Path path = Path();


  final double _startAngle;
  final double _offsetAngle;
  int index;

  int get getIndex => index;

  Path get getpath => path;


  ArcClip(this._startAngle, this._offsetAngle, this.index,);


  @override
  Path getClip(Size size) {
    path = new Path()
      ..moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.height, size.width);
    path.addArc(
        new Rect.fromLTWH(0.0, 0.0, size.height, size.width),// change H,W for perspective
        _startAngle,
        _offsetAngle);
    path.lineTo(size.height / 2, size.width / 2);
    path.close();
    return path;
  }


  @override
  bool shouldReclip(covariant ArcClip oldClipper) {
    return oldClipper.getpath != this.getpath;
  }

}
