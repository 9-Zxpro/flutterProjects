import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  late FocusNode onFocusNode;

  @override
  void initState() {
    super.initState();

    onFocusNode = FocusNode();
    myController.addListener(() {
      final value = myController.text;
      print('Second Text field - $value ${value.characters.length}');
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    onFocusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    onChanged: (value) {
                      print('First Text field - $value ${value.characters.length}');
                    },
                    focusNode: onFocusNode,
                    decoration: const InputDecoration(
                      label: Text('Enter something...'),
                      icon: Icon(Icons.input),
                      hintText: 'hi!',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if(value==null || value.isEmpty) {
                        return 'Field is empty';
                      } 
                      return null;
                    },
                    controller: myController,
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing data')),);
                  }
                },
                tooltip: 'submit',
                child: const Text('submit'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  onFocusNode.requestFocus();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text('You are going to edit first text field.'),
                      );
                    },
                  );
                },
                tooltip: 'retrieve text from textfild',
                child: const Icon(Icons.edit),
              ),
            ),
          ],
        ),
      );
  }
}
