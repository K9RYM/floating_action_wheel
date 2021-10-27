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

![Screenshot_20211027-213030](https://user-images.githubusercontent.com/75282663/139157328-f1f89f0a-8f43-4d5f-b0b2-07dfcab56d9e.jpg)
![Screenshot_20211027-213043](https://user-images.githubusercontent.com/75282663/139157339-6d4b7dcb-bb59-4e14-b3b3-4bb00cc4b305.jpg)
![Screenshot_20211027-213053](https://user-images.githubusercontent.com/75282663/139157353-9b1cd083-164a-42b6-af56-9775bba5a401.jpg)
![Screenshot_20211027-213106](https://user-images.githubusercontent.com/75282663/139157366-69ac3c2a-b32a-4c7d-868b-39d8659a4a65.jpg)
![Screenshot_20211027-213219](https://user-images.githubusercontent.com/75282663/139157380-950e6329-ea61-416a-b40a-6f505b99a0d2.jpg)
![Screenshot_20211027-213301](https://user-images.githubusercontent.com/75282663/139157390-1b97b00d-d613-4a12-a548-ebf21129df2f.jpg)


