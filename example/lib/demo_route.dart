
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:floating_action_wheel/floating_action_wheel.dart';


class DemoRoute extends StatefulWidget{

  DemoRoute({Key? key}):super(key: key);


  @override
  State<StatefulWidget> createState() {
    return new DemoRouteState();
  }


}

class DemoRouteState extends State<DemoRoute>{



  String demoText='Demo app';
  bool isSep=false;
  bool isDefaultPressed=false;
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

    super.initState();
  }




  Widget faw() {
    return new FloatingActionWheel(

      buttons: [
        WheelButton(
            onPressed: () => setState(() {
                  demoText = "button #1 pressed";
                  backgroundColor = Colors.orangeAccent;
                }),
            image:  Image.asset('assets/wheel_icon.png',
              height: 35,width: 35,filterQuality:FilterQuality.high),
            backgroundColor: Colors.orange
        ),

        WheelButton(onPressed: () {
          setState(() {
            demoText = "button #2 pressed";
            backgroundColor = Colors.greenAccent;
          });
        },
            icon: Icons.ac_unit,
            backgroundColor: Colors.green),

        if(buttons > 2)
          WheelButton(onPressed: () {
            setState(() {
              demoText = "button #3 pressed";
              backgroundColor = Colors.cyanAccent;
            });
          },
              text: 'button 3',
              backgroundColor: Colors.cyan),

        if(buttons > 3)
          WheelButton(
              onPressed: () {
                setState(() {
                  demoText = "button #4 pressed";
                  backgroundColor = Colors.pinkAccent;
                });
              },
              icon: Icons.home,
              backgroundColor: Colors.pink),

        if(buttons > 4)
          WheelButton(
              onPressed: () {
                setState(() {
                  demoText = "button #5 pressed";
                  backgroundColor = Colors.purpleAccent;
                });
              },
              text: 'button 5',
              textSize: 14,
              iconSize: 29,
              icon: Icons.info,
              backgroundColor: Colors.purple),

        if(buttons > 5)
          WheelButton(
              onPressed: () {
                setState(() {
                  demoText = "button #6 pressed";
                  backgroundColor = Colors.blueAccent;
                });
              },
              // text: 'button 6',
              // icon: Icons.image,
              image: Image.asset('assets/wheel_icon.png',
                  height: 35,width: 35,filterQuality:FilterQuality.high),
              backgroundColor: Colors.blue),

      ],
      angleOffset: angleOffset,
      visiblePart: visiblePart,
      animationType: animationType,
      wheelSize: wheelSize,
      fabForegroundColor: fabColor,
      fabBackgroundColor: fabBgColor,
      separated: isSep,
      defaultPressed: isDefaultPressed,
      fabElevation: 0,
    );
  }


  Widget animationSpinner(){
    return DropdownButton<WheelAnimationType>(
      onChanged: (val){setState(() {
        animationType=val??WheelAnimationType.none;
      });},
      value: animationType,
      disabledHint:  const Text("select wheel animation"),
      items: [
        DropdownMenuItem(
          child:  const Text("Around"),
          value: WheelAnimationType.around,
        ),
        DropdownMenuItem(
          child:  const Text("Center"),
          value: WheelAnimationType.center,
        ),
        DropdownMenuItem(
          child:  const Text("none"),
          value: WheelAnimationType.none,
        ),
        // DropdownMenuItem(
        //   child:  const Text("Rotor",style: const TextStyle(fontSize: 12,color: Colors.red,fontStyle: FontStyle.italic),),
        //   value: WheelAnimationType.apacheRotor,
        // ),
      ],

    );}

  Widget sizeSpinner(){
    return DropdownButton<WheelSize>(
      onChanged: (val){
        setState(() {
        wheelSize=val??WheelSize.wheel_medium_120;
      });
        },
      value: wheelSize,
      disabledHint: Text("select wheel size"),
      items: [
        DropdownMenuItem(
          child:  const Text("Small"),
          value: WheelSize.wheel_small_90,
        ),
        DropdownMenuItem(
          child:  const Text("Medium"),
          value: WheelSize.wheel_medium_120,
        ),
        DropdownMenuItem(
          child:  const Text("Large"),
          value: WheelSize.wheel_large_150,
        ),
      ],

    );}

  Widget buttonsSpinner(){
    return Container(
      width: 50,
      child: DropdownButton<int>(
        onChanged: (val){setState(() {
          buttons=val??4;
        });},
        value: buttons,
        disabledHint: Text("number of buttons"),
        items: [
          DropdownMenuItem(
            child:  const Text("2"),
            value: 2,
          ),
          DropdownMenuItem(
            child:  const Text("3"),
            value: 3,
          ),
          DropdownMenuItem(
            child:  const Text("4"),
            value: 4,
          ),
          DropdownMenuItem(
            child:  const Text("5"),
            value: 5,
          ),
          DropdownMenuItem(
            child: const  Text("6"),
            value: 6,
          ),
        ],

      ),
    );}



  Widget demoContainer() {
    return Container(

      color: Color.fromARGB(255, 230, 230, 230),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:  const BorderRadius.all(Radius.elliptical(50,90)),
              color: backgroundColor
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(demoText),
            ),
          ),

        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {


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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Wheel active part:'),
                    ),
                    Container(
                      width: 50,
                      child: TextField(
                          maxLines: 1,
                          maxLength: 3,
                          // focusNode: FocusNode(canRequestFocus: true),
                          // onEditingComplete: (){
                          // },
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: '0.1-1',
                              border: UnderlineInputBorder(),
                              counterText: ''
                          ),
                          onChanged: (text) {
                            if (double.tryParse(text) != null)
                              if (double.tryParse(text)! >= 0.1 &&
                                  double.tryParse(text)! <= 1)
                                setState(() {
                                  visiblePart = double.tryParse(text)!;
                                });

                          }),

                    ),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Angle offset:'),
                    ),
                    Container(
                      width: 50,
                      child: TextField(
                          autofocus: false,
                          // focusNode: FocusNode(canRequestFocus: true),
                          maxLines: 1,
                          maxLength: 3,
                          decoration: InputDecoration(
                              hintText: '0-360',
                              border: UnderlineInputBorder(),
                              counterText: ''
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            if (double.tryParse(text) != null)
                              if (double.tryParse(text)! >= 0 &&
                                  double.tryParse(text)! <= 360)
                                setState(() {
                                  angleOffset = double.tryParse(text)!;
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
                    const  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Wheel buttons:'),
                    ),
                    buttonsSpinner(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Separating bezels:',style: const TextStyle(fontSize: 14),),
                    ),
                    Container(
                      child:
                      /* could make isSeparated boolean in a DropDownMenu instead of Switch because
                      popup menu overlays trigger all overlays rebuild which rebuilds the ImmersiveWheel overlay immediately */
                      // DropdownButton<bool>(
                      //   onChanged: (val){setState(() {
                      //     isSep=val!;
                      //   });},
                      //   value: isSep,
                      //   disabledHint: Text("separated"),
                      //   items: [
                      //     DropdownMenuItem(
                      //       child:  const Text("false"),
                      //       value: false,
                      //     ),
                      //     DropdownMenuItem(
                      //       child:  const Text("true"),
                      //       value: true,
                      //     ),
                      //   ],
                      //
                      // ),
                        Switch(
                          value: isSep,
                          activeColor: Colors.blue,
                          onChanged: (_) =>
                            setState(() {
                              isSep = !isSep;
                            }),
                        )
                    )
                  ],),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Wheel animation type:'),
                    ),
                    animationSpinner(),
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
                      child:  const Text('Wheel size:'),
                    ),
                    sizeSpinner(),
                  ],
                ),
              ),
              const  Divider(color: Colors.grey,height: 0,thickness: 1,)
            ]),
      );
    }



    // print('demo rebuild');


    return Scaffold(
      appBar: AppBar(
        title: const  Text('Floating Action Wheel Demo App'),

      ),
     // floatingActionButton: faw(),
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              color: const Color.fromARGB(255, 230, 230, 230),
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

