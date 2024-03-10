import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(             
          title: const Text('Orientation Example'),
        ),
        body: const BasicActionDetector(),
      ),
    );
  }
}

class BasicActionDetector extends StatefulWidget {
  const BasicActionDetector({super.key});

  @override
  State<StatefulWidget> createState() => _BasicActionDetectorState();

}

class _BasicActionDetectorState extends State<BasicActionDetector> {
  bool _hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onFocusChange: (value) => setState(() => _hasFocus = value),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<Intent>(onInvoke: (intent) {
          print('Enter or Space was pressed!');
          return null;
        }),
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Focus(
            onKey: (node, event) {
              if (event is RawKeyDownEvent) {
                print(event.logicalKey);
              }
              return KeyEventResult.ignored;
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          // Position focus in the negative margin for a cool effect
          if (_hasFocus)
            Positioned(
              left: -4,
              top: -4,        
              bottom: -4,
              right: -4,
              child: _RoundedBorder(),
            ),
          const Tooltip(
          message: 'I am a Tooltip',
          child: Text('Hover over the text to show a tooltip.'),
          ),
        ],
      ),
    );
  }
}


class _RoundedBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        border:Border(
          top: BorderSide(width: 2.0),
          left: BorderSide(width: 2.0),
          right: BorderSide(width: 2.0),
          bottom: BorderSide(width: 2.0),
        ) 
      ),
    );
  }
}

