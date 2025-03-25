
import 'package:activity_app/global/global-variables.dart';
import 'package:activity_app/global/strings.dart';
import 'package:activity_app/models/activity_model.dart';
import 'package:activity_app/module/detail_screen/launch_mixin.dart';
import 'package:activity_app/stores/event_store.dart';
import 'package:activity_app/stores/favorites_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'methods.dart';

class DetailScreen extends StatefulWidget {
  final int eventId;

  const DetailScreen({super.key, required this.eventId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with LaunchMixin {
  late final EventItem? eventItem;

  @override
  void initState() {
    super.initState();
    eventItem = eventStore.allEvents.firstWhere(
      (event) => event.id == widget.eventId,
    );
  }

  Future<void> _toggleFavorite() async {
    final currentFavorites = favoritesStore.favoriteSubject.value;
    if (currentFavorites.contains(eventItem!.id)) {
      await favoritesStore.removeFavorite(eventItem!.id!.toInt());
    } else {
      await favoritesStore.addFavorite(eventItem!.id!.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppStrings.eventDetail,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: all10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: border15,
                      child: Image.network(
                        eventItem!.posterUrl.toString(),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: top30,
                      child: detailHeader(context, eventItem!),
                    ),
                    Padding(
                      padding: top30,
                      child: Text(
                        AppStrings.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: top20,
                      child: Html(
                        data: eventItem!.content,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            margin: bottom5 + top10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _toggleFavorite(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    fixedSize: Size(W(context) * 0.17, W(context) * 0.17),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.deepPurple,
                          width: 1,
                        ),
                        borderRadius: border50),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                  ),
                  child: StreamBuilder<List<int>>(
                    stream: favoritesStore.favoriteList,
                    builder: (context, snapshot) {
                      final favorites = snapshot.data ?? [];
                      final isFavorite = favorites.contains(eventItem!.id);
                      return Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 35,
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    launchURL(eventItem!.ticketUrl.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(W(context) * 0.7, W(context) * 0.17),
                    elevation: 0,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(
                    AppStrings.buyTicket,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
