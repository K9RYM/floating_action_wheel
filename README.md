# floating_action_wheel

<h1>
Floating Action Wheel
</h1>

<h2>
A new Floating Action button widget for Flutter with a multi-functional, immersive buttons wheel 
</h2>

## Getting Started


## 💻 Installation
Add the following dependency to your  `pubspec.yaml`

```yaml
dependencies:
  floating_action_wheel: <latest version>
```


## Usage:
You have two options to use the FloatingActionWheel, you can use it as a normal FAB in Scaffold(floatingActionButton) or you can 
put it in other compatible widgets like a Container or a Stack
Simply import the main classes and use the main FloatingActionWheel() constructor with its parameters, the mandatory parameter is the
buttons list where you pass a list of WheelButton each has its own parameters, internal documentation for the parameters available

```dart
import 'package:floatingactionwheel/floating_action_wheel.dart';
import 'package:floatingactionwheel/wheel_button.dart';
```

### - Implementation
```dart
FloatingActionWheel(
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
        WheelButton(onPressed: () {
          setState(() {
            demoText = "button #3 pressed";
            backgroundColor= Colors.cyanAccent;
          });
        },
            text: 'button 3',
            backgroundColor: Colors.cyan),
        WheelButton(
            onPressed: () {
          setState(() {
            demoText = "button #4 pressed";
            backgroundColor= Colors.pinkAccent;
          });
        },
            icon: Icons.home,
            backgroundColor: Colors.pink),

      ],
      angleOffset: 90,
      visiblePart: 0.5,
      animationType: WheelAnimationType.around,
      wheelSize: WheelSize.wheel_medium_120,
      fabForegroundColor: Colors.white,
      fabBackgroundColor: Colors.blue,
      separated: false,
    );
) 
```

### - Demonstration example

