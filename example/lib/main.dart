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

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ShokoUIThemeWidget(
      shokoUITheme: const ShokoUITheme(
        textFieldTheme: ShokoUIThemeTextField(
          isOutline: false
        ),
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
          TextFieldsPage()
        ],
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
                suffix: Text('ti huy'),
                focusColor: Colors.amber,
                isOutline: true,
                maxSymbols: 3,
                obscureText: true,
                validator: (value) {
                  return value == 'Some';
                },
                isError: false,
                label: 'Header',
                controller: TextEditingController()
              )
            ]
          )
        )
      )
    );
  }
}