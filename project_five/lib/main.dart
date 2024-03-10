import 'package:flutter/material.dart';

void main() {
  runApp(MainApp(
    items: List<ListItem>.generate(
      300,
      (i) => i%6==0?HeadingItem("Heading $i"):MessageItem('Sender $i', "Item no. $i"),
    ),
  )
  );
}

class MainApp extends StatelessWidget {
  final List<ListItem> items;
  const MainApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: items.length,
          prototypeItem: ListTile(
            title: Text(items.toString()),
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubTitle(context),
            );
          },
        ),
      ),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubTitle(BuildContext context);
}

class HeadingItem implements ListItem {
  HeadingItem(this.heading);
  final String heading;
  
  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(
        fontSize: 18.0,
      ),
    );
  }

  @override
  Widget buildSubTitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(
    this.sender,
    this.body,
  );
  
  @override
  Widget buildTitle(BuildContext context) => Text(sender);
  
  @override
  Widget buildSubTitle(BuildContext context) => Text(body);
}