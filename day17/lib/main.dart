import 'package:flutter/material.dart';

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
          title: const Text('Swipe Delet'),
        ),
        body: const SwipeDismissible(),
      ),
    );
  }
}

class SwipeDismissible extends StatefulWidget {
  const SwipeDismissible({super.key});

  @override
  State<SwipeDismissible> createState() => _SwipeDismissibleState();
  
}

class _SwipeDismissibleState extends State<SwipeDismissible> {
  final items = List<String>.generate(20, (index) => 'Item ${index+1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (buildContext, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item), 
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });
            final snackBar = SnackBar(
              content: Text('$item dismissed'),
              action: SnackBarAction(label: 'Undo', 
                onPressed: () {
                  setState(() {
                    items.insert(index, item);
                  });
                }
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          background: Container(color: Colors.amber),
          child: ListTile(
            title: Text(item),
          ),
        );
      } 
    );
  }

}