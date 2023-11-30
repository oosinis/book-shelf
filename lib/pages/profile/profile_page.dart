import 'package:book_shelf/theme.dart';
import 'package:flutter/material.dart';

import 'tabs/rated_view.dart';
import 'tabs/read_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Widget> tabs = const [
    Tab(
      icon: Icon(
        Icons.book,
        color: CustomTheme.color2,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.star,
        color: CustomTheme.color2,
      ),
    ),
  ];
  final List<Widget> tabBarViews = const [
    ReadView(),
    RatedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CustomTheme.color1,
        body: ListView(
          children: [
            // Profile
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '42',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      'Reading',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '69',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text('Reading'),
                  ],
                )
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              'Small Monkey',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Tabs
            TabBar(tabs: tabs),
            // Tab Views
            SizedBox(
              height: 1000,
              child: TabBarView(children: tabBarViews),
            ),
          ],
        ),
      ),
    );
  }
}
