
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:floatingactionwheel/floating_action_wheel.dart';


class DemoRoute extends StatefulWidget{

  DemoRoute({Key key}):super(key: key){}


  @override
  State<StatefulWidget> createState() {
    return new DemoRouteState();
  }


}

class DemoRouteState extends State<DemoRoute>{



  String demoText='Demo app';
  bool isSep=false;
  Color backgroundColor= Colors.teal;
  Color fabColor=Colors.white;
  Color fabBgColor=Colors.blue;
  double angleOffset=90;
  double visiblePart=1;
  int buttons=4;
  WheelAnimationType animationType = WheelAnimationType.around;
  WheelSize wheelSize = WheelSize.wheel_medium_120;


  @override
  void initState() {

  }




  Widget faw() {
    return FloatingActionWheel(
//      X: 250,
//      Y: 250,
      buttons: [
        WheelButton(onPressed: () {
          setState(() {
            demoText = "button #1 pressed";
            backgroundColor= Colors.orangeAccent;
          });
        },
            text: 'button 1',
            backgroundColor: Colors.orange),
        WheelButton(onPressed: () {
          setState(() {
            demoText = "button #2 pressed";
            backgroundColor= Colors.greenAccent;
          });
        },
            icon: Icons.ac_unit,
            backgroundColor: Colors.green),

        if(buttons > 2)
          WheelButton(onPressed: () {
            setState(() {
              demoText = "button #3 pressed";
              backgroundColor= Colors.cyanAccent;
            });
          },
              text: 'button 3',
              backgroundColor: Colors.cyan),

        if(buttons > 3)
          WheelButton(
              onPressed: () {
                setState(() {
                  demoText = "button #4 pressed";
                  backgroundColor= Colors.pinkAccent;
                });
              },
              icon: Icons.home,
              backgroundColor: Colors.pink),

        if(buttons > 4)
          WheelButton(
              onPressed: () {
                setState(() {
                  demoText = "button #5 pressed";
                  backgroundColor= Colors.purpleAccent;
                });
              },
              text: 'button 5',
              icon: Icons.info,
              backgroundColor: Colors.purple),

        if(buttons > 5)
          WheelButton(
              onPressed: () {
                setState(() {
                  demoText = "button #6 pressed";
                  backgroundColor= Colors.blueAccent;
                });
              },
              text: 'button 6',
              icon: Icons.image,
              backgroundColor: Colors.blue),

      ],
      angleOffset: angleOffset,
      visiblePart: visiblePart,
      animationType: animationType,
      wheelSize: wheelSize,
      fabForegroundColor: fabColor,
      fabBackgroundColor: fabBgColor,
      separated: isSep,
      fabElevation: 0,
    );
  }


  Widget animationSpinner(){
    return DropdownButton<WheelAnimationType>(
      onChanged: (val){setState(() {
        animationType=val;
      });},
      value: animationType,
      disabledHint: Text("select wheel animation"),
      items: [
        DropdownMenuItem(
          child: Text("Around"),
          value: WheelAnimationType.around,
        ),
        DropdownMenuItem(
          child: Text("Center"),
          value: WheelAnimationType.center,
        ),
        DropdownMenuItem(
          child: Text("none"),
          value: WheelAnimationType.none,
        ),
      ],

    );}

  Widget sizeSpinner(){
    return DropdownButton<WheelSize>(
      onChanged: (val){setState(() {
        wheelSize=val;
      });},
      value: wheelSize,
      disabledHint: Text("select wheel size"),
      items: [
        DropdownMenuItem(
          child: Text("Small"),
          value: WheelSize.wheel_small_90,
        ),
        DropdownMenuItem(
          child: Text("Medium"),
          value: WheelSize.wheel_medium_120,
        ),
        DropdownMenuItem(
          child: Text("Large"),
          value: WheelSize.wheel_large_150,
        ),
      ],

    );}

  Widget buttonsSpinner(){
    return Container(
      width: 50,
      child: DropdownButton<int>(
        onChanged: (val){setState(() {
          buttons=val;
        });},
        value: buttons,
        disabledHint: Text("number of buttons"),
        items: [
          DropdownMenuItem(
            child: Text("2"),
            value: 2,
          ),
          DropdownMenuItem(
            child: Text("3"),
            value: 3,
          ),
          DropdownMenuItem(
            child: Text("4"),
            value: 4,
          ),
          DropdownMenuItem(
            child: Text("5"),
            value: 5,
          ),
          DropdownMenuItem(
            child: Text("6"),
            value: 6,
          ),
        ],

      ),
    );}



  Widget menusContainer() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Wheel active part:'),
                  ),
                  Container(
                    width: 50,
                    child: TextField(
                        maxLines: 1,
                        maxLength: 3,
                        focusNode: FocusNode(canRequestFocus: false),
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: '0.1-1',
                            border: UnderlineInputBorder(),
                            counterText: ''
                        ),
                        onChanged: (text) {
                          setState(() {
                            if (double.tryParse(text) >= 0.1 &&
                                double.tryParse(text) <= 1)
                              visiblePart = double.tryParse(text);
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Angle offset:'),
                  ),
                  Container(
                    width: 50,
                    child: TextField(
                        autofocus: false,
                        focusNode: FocusNode(canRequestFocus: false),
                        maxLines: 1,
                        maxLength: 3,
                        decoration: InputDecoration(
                            hintText: '0-360',
                            border: UnderlineInputBorder(),
                            counterText: ''
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            if (double.tryParse(text) >= 0 &&
                                double.tryParse(text) <= 360)
                              angleOffset = double.tryParse(text);
                          });
                        }),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Wheel buttons:'),
                  ),
                  buttonsSpinner(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Separating bezels:'),
                  ),
                  Container(
                      child: Switch(
                        value: isSep,
                        activeColor: Colors.blue,

                        onChanged: (_) {
                          setState(() {
                            isSep = !isSep;
                          });
                        },
                      )
                  )
                ],),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Wheel animation type:'),
                ),
                animationSpinner(),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Wheel size:'),
                ),
                sizeSpinner(),
              ],
            ),
            Divider(color: Colors.grey,height: 0,thickness: 1,)
          ]),
    );
  }

  Widget demoContainer() {
    return Container(

      color: Color.fromARGB(255, 230, 230, 230),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(50,90)),
              color: backgroundColor
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(demoText),
            ),
          ),
//      Stack(
//          children: [
//            faw()
//          ]
//      ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Floating Action Wheel Demo App'),

      ),
//      floatingActionButton: faw(),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      bottomNavigationBar: BottomAppBar(
//        shape: CircularNotchedRectangle(),
////          notchMargin: 100,
//        elevation: 20,
//        child: Row(
//          children: [
//            Icon(Icons.home,size: 50,)
//          ],
//        ),
//      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            menusContainer(),
            demoContainer(),
            Container(
              height: 320,
              color: Color.fromARGB(255, 230, 230, 230),
              child: Center(
                child: faw(),
              ),
            )
          ],
        ),
      ),
    );


  }
}