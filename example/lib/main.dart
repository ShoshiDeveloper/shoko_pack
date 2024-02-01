import 'package:flutter/material.dart';
import 'package:shoko_ui/shoko_ui.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  PageController controller = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    return ShokoUIThemeWidget(
      shokoUITheme: const ShokoUITheme(
        switchTheme: ShokoUIThemeSwitch(
          backgroundColor: Colors.green,
          inactiveBackgroundColor: Colors.red,
          thumbColor: Colors.black,
          inactiveThumbColor: Colors.white
        )
      ),
      child: PageView(
        controller: controller,
        children: const [
          ButtonsPage(),
          SwitchPage(),
          RadioPage(),
          TextFieldsPage()
        ],
      )
    );
  }
}

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
               ShokoUIButton(
                isFullWidth: true,
                prefix: Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
                suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                child: Text('Full params', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              SizedBox(height: 8),
              ShokoUIButton(
                prefix: Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
                suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                child: Text('Full params without full width', style: TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 8),
              ShokoUIButton(
                color: Colors.blueAccent,
                child: Text('Only color, only child', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              SizedBox(height: 8),
              ShokoUIButton(
                color: Colors.blueAccent,
                isFullWidth: true,
                suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                child: Text('Only child and suffix', style: TextStyle(fontSize: 16, color: Colors.white),),
              ),
              SizedBox(height: 8),
            ],
          )
        )
      )
    );
  }
}


class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {

  bool s = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShokoUISwitch(
                insidePadding: 6,
                backgroundColor: const Color.fromRGBO(108, 99, 255, 1),
                thumbColor: Colors.white,
                onChange: (newValue) {
                  setState(() {
                    s = newValue;
                  });
                },
                value: s
              ),
              ShokoUISwitch(
                insidePadding: 6,
                onChange: (newValue) {
                  setState(() {
                    s = newValue;
                  });
                },
                value: s
              )
            ]
          )
        )
      )
    );
  }
}

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  bool s = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: ShokoUIRadio(
            value: s,
            childPosition: ShokoUIRadioChildPosition.left,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            child: const Text('Enable music'),
            onChange: (newValue) {
              setState(() {
                s = newValue;
              });
            },
          )
        )
      )
    );
  }
}

class TextFieldsPage extends StatelessWidget {
  const TextFieldsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
              ShokoUIModernTextField(
                errorColor: Colors.red,
                focusColor: Colors.blue,
                errorText: 'Какая-та хуита',
                style: TextStyle(fontSize: 24, color: Colors.black),
                isError: false,
                controller: TextEditingController(text: 'asdas')
              )
            ]
          )
        )
      )
    );
  }
}