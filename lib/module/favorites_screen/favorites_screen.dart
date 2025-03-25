import 'package:activity_app/global/global-variables.dart';
import 'package:activity_app/stores/favorites_store.dart';
import 'package:activity_app/stores/event_store.dart';
import 'package:flutter/material.dart';
import '../../global/strings.dart';
import '../activity_home_screen/methods.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            AppStrings.favorites,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          centerTitle: true),
      body: Padding(
        padding: horizontal10 + top10,
        child: StreamBuilder<List<int>>(
          stream: favoritesStore.favoriteSubject.stream,
          builder: (context, snapshot) {
            final favoriteIds = snapshot.data ?? [];
            if (favoriteIds.isEmpty) {
              return Center(child: Text(AppStrings.favoriteEventNotFound));
            }
            return ListView.builder(
              itemCount: favoriteIds.length,
              itemBuilder: (context, index) {
                final favId = favoriteIds[index];
                final event = eventStore.allEvents.firstWhere(
                  (e) => e.id == favId,
                );
                return eventButtonContainer(context, event);
              },
            );
          },
        ),
      ),
    );
  }
}
