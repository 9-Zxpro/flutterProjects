import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Flutter Layout Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/sun.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const TitleSection(
                  name: 'Chic Mane Salon',
                  location: 'Pari Chawk, 201310',
                ),
                const ButtonsRow(),
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'This is my 4th learning flutter application.'
                    'If you want to really learn with me then come'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with dedication and also faster.'
                    'and learn together with correctness and also faster.',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          const FavoritePlace(),
        ],
      ),
    );
  }
}

class FavoritePlace extends StatefulWidget {
  const FavoritePlace({super.key});

  @override
  State<FavoritePlace> createState() => _FavoritePlaceState();
}

class _FavoritePlaceState extends State<FavoritePlace> {
  bool _favorite = false;
  int _fCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: _isPressed,
            icon: _favorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
            color: Colors.red,
          ),
        ),
        SizedBox(
          width: 18,
          child: Text('$_fCount'),
        ),
      ],
    );
  }


  void _isPressed() {
    setState(() {
      if(_favorite) {
        _fCount -= 1;
        _favorite = false;
      } else {
        _fCount += 1;
        _favorite = true;
      }
    });
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.icon,  
    required this.color,  
    required this.label,  
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          label,
        ),
      ],
    );
  }
}

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Buttons(icon: Icons.call, color: color, label: 'Call',),
          Buttons(icon: Icons.near_me, color: color, label: 'Route',),
          Buttons(icon: Icons.share, color: color, label: 'Share',),
        ],
      ),
    );
  }
  
}
