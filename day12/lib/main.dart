import "package:flutter/material.dart";

void main()   {
  runApp(const BottomNavigationBarExampleApp());
}

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle textStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetList = <Widget>[
    Text(
      "Index 0: Home",
      style: textStyle,
    ),
    Text(
      "Index 1: Business",
      style: textStyle,
    ),
    Text(
      "Index 2: School",
      style: textStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Bottom Navigation',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,),),
      ),
      body: Center(
        child: _widgetList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business',),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School',),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
   
}