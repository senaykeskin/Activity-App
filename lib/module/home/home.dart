import 'package:activity_app/module/activity_home_screen/activity_home_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ActivityHomeScreen(),
            Center(child: Text("Etkinlikler İçeriği")),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.blueGrey[100],
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Ana Sayfa"),
              Tab(icon: Icon(Icons.favorite_outlined), text: "Favoriler"),
            ],
          ),
        ),
      ),
    );
  }
}
