import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      scrollBehavior: const ConstantScrollBehavior(),
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: const Color.fromARGB(255, 1, 134, 119),
              // centerTitle: true,
              pinned: true,
              stretch: true,
              onStretchTrigger: () async {
                print('Load more data!');
              },
              // floating: true,
              // snap: true,
                // title: Text('Horizons'),
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Horizons'),
                stretchModes: const <StretchMode>[
                  // StretchMode.fadeTitle,
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[
                        Colors.teal[800]!,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Image.network(
                    headerImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const WeeklyForecastList()
          ],
        ),
      ),
    );
  }
}

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 7,
        (context, index) {
          final DailyForecast dailyForecast = Server.getDailyForecastByID(index);
          return Card(
            child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                      height: 180.0,
                      width: 210.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children:[
                          DecoratedBox(
                            position: DecorationPosition.foreground,
                            decoration: const BoxDecoration(
                              gradient: RadialGradient(
                                colors: <Color>[
                                  Color.fromARGB(255, 14, 14, 14),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Image.network(
                              dailyForecast.imageId,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: Text(
                              dailyForecast.getDate(currentDate.day).toString(),
                              style: textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dailyForecast.getWeekday(currentDate.weekday),
                              style: textTheme.headlineSmall,
                            ),
                            Text(
                              '${dailyForecast.description} || $index',
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                      style: textTheme.titleSmall,
                    ),
                ],
              ),
          );
        },
      )
    );
  }
}


const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetURL}assets/header.jpeg';

class Server {
  static List<DailyForecast> getDailyForecastList() =>
      _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= 6);
    return _kDummyData[id]!;
  }
}

class DailyForecast {
  const DailyForecast({
    required this.id,
    required this.imageId,
    required this.highTemp,
    required this.lowTemp,
    required this.description,
  });
  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  static const List<String> _weekdays = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  String getWeekday(int today) {
    final int offset = today + id;
    final int day = offset >= 7 ? offset - 7 : offset;
    return _weekdays[day];
  }

  int getDate(int today) => today + id;
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}

const Map<int, DailyForecast> _kDummyData = {
  0: DailyForecast(
    id: 0,
    imageId: '${baseAssetURL}assets/day_0.jpeg',
    highTemp: 73,
    lowTemp: 52,
    description:
        'Partly cloudy in the morning, with sun appearing in the afternoon.',
  ),
  1: DailyForecast(
    id: 1,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
    highTemp: 70,
    lowTemp: 50,
    description: 'Partly sunny.',
  ),
  2: DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
    highTemp: 71,
    lowTemp: 55,
    description: 'Party cloudy.',
  ),
  3: DailyForecast(
    id: 3,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
    highTemp: 74,
    lowTemp: 60,
    description: 'Thunderstorms in the evening.',
  ),
  4: DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
    highTemp: 67,
    lowTemp: 60,
    description: 'Severe thunderstorm warning.',
  ),
  5: DailyForecast(
    id: 5,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
    highTemp: 73,
    lowTemp: 57,
    description: 'Cloudy with showers in the morning.',
  ),
  6: DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
    highTemp: 75,
    lowTemp: 58,
    description: 'Sun throughout the day.',
  ),
};
