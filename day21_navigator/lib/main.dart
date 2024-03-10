import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;
  const Todo(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    title: 'Navigation',
    // you have to create apart Widget to navigate within Materialapp
    home: FirstRoute(
      todos: List.generate(
        20,
        (index) => Todo(
          'Task $index',
          'Something about task $index',
        ),
      ),
    ),
  ));
}

// two different route  --First

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key, required this.todos});
  final List<Todo> todos;

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: widget.todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.todos[index].title),
              onTap: () {
                _navigateAndDisplaySecondRoute(context, widget.todos[index]);
              },
            );
          }),
    );
  }
}

Future<void> _navigateAndDisplaySecondRoute(
    BuildContext context, Todo todos) async {
  final res = await Navigator.push(
    context,
    // MaterialPageRoute(builder: (context) => SecondRoute(cTodo: todos[index])),

    // Pass the arguments as part of the RouteSettings. The
    // SecondRoute reads the arguments from these settings.
    MaterialPageRoute(
      builder: (context) => const SecondRoute(),
      settings: RouteSettings(
        arguments: todos,
      ),
    ),
  );
  if (!context.mounted) return;
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('$res'),
    ));
}

// --second
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});
  // const SecondRoute({super.key, required this.cTodo});
  // final Todo cTodo;

  @override
  Widget build(BuildContext context) {
    final cTodo = ModalRoute.of(context)!.settings.arguments as Todo;

    return Scaffold(
      appBar: AppBar(
        title: Text(cTodo.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(cTodo.description),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "happy");
              },
              child: const Text('Happy'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "sad");
              },
              child: const Text('Sad'),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () async {
                await Future<void>.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  Navigator.of(context).pop(["Delayed tapped", "Ram Ram"]);
                }
              },
              child: const Text('Delayed pop'),
            ),
          ],
        ),
      ),
    );
  }
}
