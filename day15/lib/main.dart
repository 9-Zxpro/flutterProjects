import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _stateIndex = 0;
  final ScrollController _homepage = ScrollController();

  Widget _listViewBody() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Text('Item $index'),
        );
      }, 
      controller: _homepage,
      separatorBuilder: (BuildContext context, int index) => 
      const Divider(thickness: 1,), 
      itemCount: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog open'),
      ),
      body: _listViewBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_new),
            label: 'Open In New'),
        ],
        currentIndex: _stateIndex,
        selectedItemColor: Colors.amber,
        onTap: (index) {
          const snackBar = SnackBar(content: Text('Tapped'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
          switch(index) {
            case 0: if(_stateIndex == index) {
              _homepage.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
            }
            case 1: showModel(context);
          }
          setState(() {
            _stateIndex = index;
          });
        },
      ),
    );
  }
  void showModel(BuildContext context) {
    showDialog<void>(context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('This is Alert!'),
        actions: [
          TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('close')),
        ],
      ),
    );
  }
}
