import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: MediaQuery.platformBrightnessOf(context),
    );
    return MaterialApp(
      theme: ThemeData(
        colorScheme: colorScheme,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.tertiary,
          foregroundColor: colorScheme.onTertiary,
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int buttonPressCount = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final double pointCount = 8 + (buttonPressCount % 6);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Press the + Button'),
      ),
      // An AnimatedContainer makes the decoration changes entertaining.
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.all(32),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: colorScheme.tertiaryContainer,
          shape: StarBorder(
            points: pointCount,
            pointRounding: 0.4,
            valleyRounding: 0.4,
            side: BorderSide(width: 4, color: colorScheme.tertiary),
          ),
        ),
        child: Text(
          '${pointCount.toInt()} Points',
          style: theme.textTheme.headlineMedium!.copyWith(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            buttonPressCount += 1;
          });
        },
        tooltip: "Change the shape's point count",
        child: const Icon(Icons.add),
      ),
    );
  }
}
