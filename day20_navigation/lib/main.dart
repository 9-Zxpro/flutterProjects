import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TabControllerExample(),
      ),
    );
  }
}

class TabControllerExample extends StatefulWidget{
  const TabControllerExample({super.key});
  
  @override
  State<TabControllerExample> createState() => _TabControllerExampleState();
}

class _TabControllerExampleState extends State<TabControllerExample> with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = <Tab> [
    Tab(text: 'LEFT'),
    Tab(text: 'MIDDLE'),
    Tab(text: 'RIGHT'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          dividerColor: Colors.blueAccent,
          dividerHeight: .1,
          labelColor: Colors.blueAccent,
          indicatorWeight: 1.0,
        ),
        title: const Text('Tab Testing'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return Center(
            child: Text(
              'This is $label tab',
              style: const TextStyle(fontSize: 32, color: Colors.amber),
            ),
          );
        }).toList(),
      ),
    );
  }
}
