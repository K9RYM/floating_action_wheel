import 'dart:math';

import 'file:///C:/Users/K-99/Documents/AndroidStudioProjects/floating_action_wheel/lib/src/floating_action_wheel.dart';
import 'package:floatingactionwheel/src/wheel_slice.dart';
import 'file:///C:/Users/K-99/Documents/AndroidStudioProjects/floating_action_wheel/lib/src/wheel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  int x = 10;
  var y = 'kkk';

  List<WheelButton> wheelbtns = [
    WheelButton(
        onPressed: () => x += 10,
        text: 'text1',
        textSize: 12,
        backgroundColor: Colors.red),
    WheelButton(
        onPressed: () => x -= 10,
        text: 'text2',
        icon: Icons.home,
        iconSize: 13,
        backgroundColor: Colors.blue),
    WheelButton(
        onPressed: () => y += '10',
        text: 'text3',
        textSize: 11,
        icon: Icons.ac_unit,
        iconSize: 15,
        backgroundColor: Colors.green),
    WheelButton(
        onPressed: () => y += '20',
        text: 'text4',
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.yellowAccent),
  ];

  var mainWheel = FloatingActionWheel(key: Key('ok'),
    buttons: wheelbtns,
    wheelSize: WheelSize.wheel_large_150,
    animationType: WheelAnimationType.none,
    visiblePart: 1,
    angleOffset: 90,
    separated: false,
    fabBackgroundColor: Colors.brown,
    fabForegroundColor: Colors.black,
    fabHeroTag: 'tag',
  );


  group('main widget test', () {
    testWidgets('main base test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          floatingActionButton: mainWheel,
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
          body: Center(
            child: Text('wheel test'),
          ),
        ),
      )
      );

      expect(find.byKey(Key('ok')),findsOneWidget);
    });

    testWidgets('FAB test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          floatingActionButton: mainWheel,
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
          body: Center(
            child: Text('wheel test'),
          ),
        ),
      )
      );

      expect(find.byType(FloatingActionButton),findsOneWidget);
//      expect(find.byElementType(FloatingActionButton),findsOneWidget);
    });


    testWidgets('FAB test2', (WidgetTester tester) async {
      List<int> x=[4,2,6,7,4,3];
      List<int> b= new List<int>();
//      = x.map(( int i) => i+ (i-1) +(i+1)).toList();

      String n='450';
      String nb='44';
      String nm='377';

      int k= int.tryParse(n);
      int j= Random(1).nextInt(n.length);
      String kk=n.replaceRange(j, j+1, '');

      if(kk.length >1 && !kk.startsWith("0")) {
        if (int.tryParse(nm) == int.tryParse(nb) + int.tryParse(kk))
          print("YES");
        else
          print('NO');
      }
      else
        print('NO');

//      for(int i=0;i<x.length;i++) {
//        b[i] = x[i] + (i <= 0 ? 0 : x[i-1]) + (i >= x.length -1 ? 0 : x[i+1]);
//      }
//      x.forEach((element) {int x = element + (x-)})
      print(b);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          floatingActionButton: mainWheel,
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
          body: Center(
            child: Text('wheel test'),
          ),
        ),
      )
      );
      await tester.tap(find.byType(FloatingActionButton));

//      expect(find.byKey(Key('btn0')),findsOneWidget);
      expect(find.byType(WheelSlice),findsOneWidget);
//      await tester.tap(find.byKey(Key('btn2')));

//      print(x);


      expect(find.byType(FloatingActionButton),findsOneWidget);
//      expect(find.byElementType(FloatingActionButton),findsOneWidget);
    });



  });
}
