
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'immersive_wheel.dart';


import 'package:flutter/widgets.dart';

import 'wheel_button.dart';

enum WheelAnimationType{
  around,center,none,@deprecated helicopter
}
enum WheelSize{
  wheel_small_90,wheel_medium_120,wheel_large_150
}



/// Material FAB that carries an immersive wheel with customizable button
///
/// made by :: Kapp-99
class FloatingActionWheel extends StatefulWidget {


  FloatingActionWheel(
      {Key key, @required this.buttons, this.animationType = WheelAnimationType.center,
        this.wheelSize = WheelSize.wheel_medium_120,
        this.angleOffset = 90.0, this.visiblePart = 1, this.separated = false,
        this.fabBackgroundColor,this.fabForegroundColor,this.fabHeroTag,this.fabElevation=0
      }):
        assert( buttons.isNotEmpty,'WheelButton list should not be empty'),
        assert(visiblePart >= 0.1 && visiblePart <= 1, 'visiblePart can only range from 0.1 to 1 (percentage)'),
        assert(angleOffset >= 0 && angleOffset <= 360, 'angleOffset should only be a degree (0-360)'),
        super(key: key);



  ///   List<WheelButton> [buttons] (required) (Non-empty) a list of [WheelButton] to display on the immersive wheel
  final List<WheelButton> buttons;


  ///   double [angleOffset] the starting angle the wheel should be drawn from, range: (0-360)
  ///
  ///   Defaults to 90 degree
  final double angleOffset;


  ///   double [visiblePart] the covered part around the FAB by the wheel, range: (0.1 - 1)
  ///
  ///   Defaults to 1
  final double visiblePart;



  ///   bool [separated] sets a separation bezel between each [WheelButton]
  ///
  ///   Defaults to false
  final bool separated;

  ///   AnimationType [animationType] an animation to draw the wheel from the [angleOffset]
  ///   to the end of [visiblePart] if specified, animations are either:
  ///   [WheelAnimationType.around] to draw the wheel circularly around the FAB,
  ///   [WheelAnimationType.center] to draw the wheel from center
  ///   and [WheelAnimationType.none] to disable animation
  ///
  ///   Defaults to [WheelAnimationType.center]
  final WheelAnimationType animationType;


  ///   Color [fabForegroundColor] the foreground color for [FloatingActionButton]
  ///
  ///   Defaults to [FloatingActionButton] default foreground color
  final Color fabForegroundColor;


  ///   Color [fabBackgroundColor] the background color for [FloatingActionButton]
  ///
  ///   Defaults to [FloatingActionButton] default background color
  final Color fabBackgroundColor;


  ///   Object [fabHeroTag]  set the hero tag for the FAB if you already have another FAB in the current route
  final Object fabHeroTag;



  ///   double [fabElevation] the FloatingActionButton elevation
  ///
  ///   Defaults to 0
  final double fabElevation;



  ///   WheelSize [wheelSize] the wheel's height/weight size, currently supported sizes are:
  ///   [WheelSize.wheel_small_90] , [WheelSize.wheel_medium_120] , [WheelSize.wheel_large_150]
  ///
  ///   Defaults to [WheelSize.wheel_medium_120]
  final WheelSize wheelSize;


  @override
  State<StatefulWidget> createState() {
    return new FloatingActionWheelState();
  }

}

class FloatingActionWheelState extends State<FloatingActionWheel> {

  bool _isPressed = false;
  double _size;
  double _stroke;
  double _constrains;
  OverlayEntry _overlayEntry;
  final LayerLink _link = LayerLink();



  @override
  void initState() {
    super.initState();
    this._overlayEntry = this._dummyOverlay();
    _overlayEntry.maintainState =false;

  }




  Widget _createWheel() {

    return Stack(

      alignment: Alignment.center,
//        clipBehavior: Clip.none,
      children: [
        ImmersiveWheel(
            _constrains, _stroke,
            widget.buttons,
            angleOffset: widget.angleOffset,
            visiblePart: widget.visiblePart,
            animationType: widget.animationType,
            separated: widget.separated),

        _createFAB()
      ],
    );
  }




  Widget _createFABTarget() {
    return CompositedTransformTarget(
        link: _link,
        child: _isPressed ? Container(height: 56,width: 56,) : _createFAB()
    );
  }


  Widget _createFAB() {
    return FloatingActionButton(
      heroTag: widget.fabHeroTag,
      onPressed: () {
        setState(() {
          if (!_isPressed) {
            this._overlayEntry = this._createOverlayEntry();
            _overlayEntry.maintainState = false;
            Navigator
                .of(context)
                .overlay
                .insert(_overlayEntry);
          } else {
            _overlayEntry.remove();
          }
          _isPressed = !_isPressed;
        });
      },
      tooltip: 'Tap to open the wheel',
      foregroundColor: widget.fabForegroundColor,
      backgroundColor: widget.fabBackgroundColor,
      elevation: widget.fabElevation,
      child:
      Image.asset(
        'assets/wheel_icon.png', height: 35,width: 35,package: 'floating_action_wheel',filterQuality:FilterQuality.high,),
    );
  }


  OverlayEntry _createOverlayEntry() {


    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
//    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) =>
          Positioned(
              left: 100,
              top: 100,

              width: _constrains,
              height: _constrains,
              child:
              CompositedTransformFollower(
                  link: _link,
                  offset: Offset(
                    -_constrains/2 +size.height/2,

                    -_constrains/2+size.width/2,
                  ),
                  showWhenUnlinked: false,
                  child: _createWheel())
//        ),
//      ),
          ),

    );
  }


  OverlayEntry _dummyOverlay() {
    return OverlayEntry(
        builder: (context) =>
            Positioned(
                width: _constrains,
                height: _constrains,
                child: Container()
            )
    );
  }


  @override
  Widget build(BuildContext context) {

    switch (widget.wheelSize) {
      case WheelSize.wheel_small_90:
        _size = 90;
        _stroke = 80;
        break;
      case WheelSize.wheel_medium_120:
        _size = 120;
        _stroke = 120;
        break;
      case WheelSize.wheel_large_150:
        _size = 150;
        _stroke = 180;
        break;
    }
    _constrains = _size * 1.8;

    return _createFABTarget();

  }


}