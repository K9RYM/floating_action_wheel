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
import 'package:floating_action_wheel/floating_action_wheel.dart';
import 'package:floating_action_wheel/wheel_button.dart';
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
<img src=
"https://user-images.githubusercontent.com/75282663/139159039-4d6e705c-6fcf-48cc-ae4f-6d269a8f5c2c.jpg"
height = "320" width = "180" />
<img src=
"https://user-images.githubusercontent.com/75282663/139159070-256fa6ee-6110-4351-b596-63fd08a31eca.jpg"
height = "320" width = "180" />
<img src=
"https://user-images.githubusercontent.com/75282663/139159080-89dce8fe-4873-4549-bbc6-34dcd926a9f9.jpg"
height = "320" width = "180" />
<img src=
"https://user-images.githubusercontent.com/75282663/139159089-20e5ac97-4fa5-40f1-bd98-adf9a6601370.jpg"
height = "320" width = "180" />
<img src=
"https://user-images.githubusercontent.com/75282663/139159099-6bd7d09c-3b33-4744-a1ed-4f7e42458bc7.jpg"
height = "320" width = "180" />
<img src=
"https://user-images.githubusercontent.com/75282663/139159106-7be4851f-d03f-41d9-a1cc-5949dfd18ce4.jpg"
height = "320">


