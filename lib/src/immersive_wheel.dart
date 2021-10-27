
import 'dart:ui';

import 'package:flutter/material.dart';
import 'wheel_slice.dart';
import 'dart:math' as math;

import 'wheel_button.dart';
import 'floating_action_wheel.dart';

/// the wheel widget class that holds the arc(slice) buttons and their functionality
/// and animation.
class ImmersiveWheel extends StatefulWidget {

  final List<WheelButton> buttons;
  final double angleOffset;
  final double visiblePart;

  final bool separated;
  final WheelAnimationType animationType;
  final double constrains;
  final double stroke;

  final List<Color> _colorList = [];


  ImmersiveWheel(this.constrains,this.stroke,this.buttons,
      { this.animationType = WheelAnimationType.none,
        this.angleOffset = 90.0, this.visiblePart = 1, this.separated = false,
      })
  {
    for (int i = 0; i < buttons.length; i++) {
      _colorList.add(buttons[i].backgroundColor);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return new ImmersiveWheelState();
  }
}

class ImmersiveWheelState extends State<ImmersiveWheel> with SingleTickerProviderStateMixin{


  Animation<double> _animation;
  AnimationController _animationController;

  double _animFraction = 0.0;
  double _totalAngle=0;
  double _startingAngle = 0;
  double _animConstrains=0;

  static const double radian90 = math.pi * 2;
  static const double radianBase = math.pi / 180;


  @override
  void initState() {

    super.initState();

    switch (widget.animationType) {
      case WheelAnimationType.none:
        _animFraction = widget.visiblePart;
        _animConstrains = widget.constrains;
        break;

      case WheelAnimationType.center:
        _animFraction = widget.visiblePart;
        _animationController = AnimationController(
          duration: Duration(milliseconds: 550),
          vsync: this,
        );
        final Animation<double> curvedAnimation = CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeIn,
        );
        _animation =
        Tween<double>(begin: 0, end: widget.constrains).animate(curvedAnimation)
          ..addListener(() {
            setState(() {
              _animConstrains = _animation.value;
            });
          });
        _animationController.forward();
        break;

      case WheelAnimationType.around:
      case WheelAnimationType.helicopter:
        int duration = 750 ;
        var curve = Curves.easeIn;
        if(widget.animationType == WheelAnimationType.helicopter){
          duration = 12000;
          curve = Curves.easeInOut;
        }

        _animConstrains = widget.constrains;
        _animationController = AnimationController(
          duration: Duration(milliseconds: duration),
          vsync: this,
        );
        final Animation<double> curvedAnimation = CurvedAnimation(
          parent: _animationController,
          curve: curve,
        );
        _animation =
        Tween<double>(begin: 0, end: widget.visiblePart).animate(curvedAnimation)
          ..addListener(() {
            setState(() {
              _animFraction = _animation.value;
            });
          });
        _animationController.forward();
        break;
    }

  }



  List<Widget> _generateWheelBluePrints(int number) {
    if(widget.animationType != WheelAnimationType.helicopter)
      _startingAngle = widget.angleOffset * radianBase;


    _totalAngle = _animFraction * radian90;

    double offsetAngle;
    List<Widget> btns = [];


    for (int i = 0; i <= number - 1; i++) {

      offsetAngle = widget.separated ? _totalAngle / number - 0.03 : _totalAngle / number+0.01;

      if (i == 0)
        _startingAngle =
        widget.separated ? _startingAngle + 0.015 : _startingAngle;

      if (i == number - 1) {
        offsetAngle =
        widget.separated ? _totalAngle / number - 0.03 : _totalAngle / number +0.005;

      }

      /**list of rendered wheel buttons**/
      btns.add(
          WheelSlice(_startingAngle, offsetAngle, i,key: Key('btn$i'),
              text: widget.buttons[i].text,
              backgroundColor: widget._colorList[i],
              foregroundColor: widget.buttons[i].foregroundColor,
              onPressed: widget.buttons[i].onPressed,
              textSize: widget.buttons[i].textSize,
              iconSize: widget.buttons[i].iconSize,
              stroke: widget.stroke,
              icon: widget.buttons[i].icon,
              activePart: widget.visiblePart)
      );

      _startingAngle += ((_totalAngle) / number);


    }

    return btns;
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: _animConstrains,
      width: _animConstrains,

      child: Stack(
          children: _generateWheelBluePrints(widget.buttons.length)
      ),
    );
  }

  @override
  void didUpdateWidget(ImmersiveWheel oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}

