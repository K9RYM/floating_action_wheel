
import 'dart:async';
import 'package:floating_action_wheel/src/immersive_wheel.dart';
import 'package:floating_action_wheel/src/wheel_button.dart';
import 'package:flutter/material.dart';

enum WheelAnimationType{
  around,center,none,@deprecated apacheRotor
}
enum WheelSize{
  wheel_small_90,wheel_medium_120,wheel_large_150
}



/// Material FAB that carries an immersive wheel with customizable button
///
/// made by :: Kapp-99
class FloatingActionWheel extends StatefulWidget {


  FloatingActionWheel(
      {Key? key, required this.buttons, this.animationType = WheelAnimationType.around,
        this.wheelSize = WheelSize.wheel_medium_120,this.defaultPressed=false,
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


  ///   bool [defaultPressed] Init the widget with the ImmersiveWheel on by default
  ///
  ///   Defaults to false
  final bool defaultPressed;


  ///   WheelSize [wheelSize] the wheel's height/weight size, currently supported sizes are:
  ///   [WheelSize.wheel_small_90] , [WheelSize.wheel_medium_120] , [WheelSize.wheel_large_150]
  ///
  ///   Defaults to [WheelSize.wheel_medium_120]
  final WheelSize wheelSize;



  ///   bool [separated] sets a separation bezel between each [WheelButton]
  ///
  ///   Defaults to false
  final bool separated;

  ///   AnimationType [animationType] an animation to draw the wheel from the [angleOffset]
  ///   to the end of [visiblePart] if specified, animations are either:
  ///   [WheelAnimationType.around] to draw the wheel circularly around the FAB,
  ///   [WheelAnimationType.center] to draw the wheel from center to the edge
  ///   [WheelAnimationType.none] to disable animation
  ///   [WheelAnimationType.apacheRotor] secret animation, use caution!
  ///
  ///   Defaults to [WheelAnimationType.around]
  final WheelAnimationType animationType;


  ///   Color? [fabForegroundColor] the foreground color for [FloatingActionButton]
  ///
  ///   Defaults to [FloatingActionButton] default foreground color
  final Color? fabForegroundColor;


  ///   Color? [fabBackgroundColor] the background color for [FloatingActionButton]
  ///
  ///   Defaults to [FloatingActionButton] default background color
  final Color? fabBackgroundColor;


  ///   Object [fabHeroTag]  set the hero tag for the FAB if you already have another FAB in the current route
  final Object? fabHeroTag;



  ///   double [fabElevation] the FloatingActionButton elevation
  ///
  ///   Defaults to 0
  final double fabElevation;



  @override
  State<StatefulWidget> createState() {
    return new _FloatingActionWheelState();
  }

}

class _FloatingActionWheelState extends State<FloatingActionWheel> {

  late bool _isPressed;
  double _size=0;
  double _stroke=0;
  double _constrains=0;
  late OverlayEntry _overlayEntry;
  final LayerLink _link = LayerLink();







  /* Extracting ImageInfo object from Image is done in the main widget to pass context */
  Future<ImageInfo> getImageInfo(BuildContext context,Image assetImage) async {
    // AssetImage assetImage = AssetImage('assets/wheel_icon.png',bundle: rootBundle);
    ImageStream stream = assetImage.image.resolve(createLocalImageConfiguration(context));
    Completer<ImageInfo> completer = Completer();
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, _) {
      return completer.complete(imageInfo);
    }));
    return completer.future;
  }

  Future<void> getImage() async{

    for(WheelButton wheel in widget.buttons) {
      if (wheel.image != null) {
        wheel.imageInfo = await getImageInfo(context, wheel.image!);
      }
    }
  }



  void _attachOverlay() {
    this._overlayEntry = this._createOverlayEntry();
    _overlayEntry.maintainState = false;
    Navigator
        .of(context)
        .overlay
        ?.insert(_overlayEntry);
  }





  Widget _createWheel() {

    return Stack(

      alignment: Alignment.center,

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

    return
     CompositedTransformTarget(
        link: _link,
        child: _isPressed ? Container(height: 56,width: 56,) : _createFAB()
    );
  }


  Widget _createFAB() {
    return FloatingActionButton(
      heroTag: widget.fabHeroTag,
      onPressed: () {
        if(!widget.defaultPressed) {
          setState(() {
            if (!_isPressed) {
              _attachOverlay();
            }
            else {
              _overlayEntry.remove();
            }
            _isPressed = !_isPressed;
          });
        }
      },
      tooltip: 'Tap to open the wheel',
      foregroundColor: widget.fabForegroundColor,
      backgroundColor: widget.fabBackgroundColor,
      elevation: widget.fabElevation,
      child:Image.asset('assets/wheel_icon.png',
        height: 35,width: 35,package: 'floating_action_wheel',filterQuality:FilterQuality.high),
    );
  }


  OverlayEntry _createOverlayEntry() {


    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) =>
          Positioned(
              left:offset.dx-_constrains/3,
              top:offset.dy -_constrains/3,
              width: _constrains,
              height: _constrains,
              child: CompositedTransformFollower(
                  link: _link,
                  offset: Offset(
                    -_constrains/2 +size.height/2,

                    -_constrains/2+size.width/2,
                  ),
                  showWhenUnlinked: false,
                  child: _createWheel()
              )


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
  void initState() {
    super.initState();

    _isPressed = widget.defaultPressed;

    /* wheel always on by default should create the overlay post build method*/
    if(widget.defaultPressed) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => _attachOverlay());
    }

    this._overlayEntry = this._dummyOverlay();
    _overlayEntry.maintainState =false;

  }


  @override
  Widget build(BuildContext context) {


    getImage();

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




    return
      _createFABTarget();
  }





}