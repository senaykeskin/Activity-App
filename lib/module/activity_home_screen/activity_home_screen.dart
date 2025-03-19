import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../global/event_store.dart';
import '../../global/global-variables.dart';
import '../../models/activity_model.dart';
import '../../widgets/searchAndFilter.dart';
import 'methods.dart';

class ActivityHomeScreen extends StatefulWidget {
  const ActivityHomeScreen({super.key});

  @override
  State<ActivityHomeScreen> createState() => _ActivityHomeScreenState();
}

class _ActivityHomeScreenState extends State<ActivityHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late final EventStore _eventStore;
  late Stream<bool> _isLoadingStream;
  late Stream<List<EventItem>> _eventListStream;

  int firstItemCount = 20;

  @override
  void initState() {
    super.initState();
    _eventStore = eventStore;
    _isLoadingStream = _eventStore.isLoadingStream;
    _eventListStream = _eventStore.eventListStream;
    _eventStore.fetchAllEvents();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        !_eventStore.isLoading) {
      _eventStore.loadMoreEvents();
    }
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Ana Sayfa",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchAndFilter(),
            const SizedBox(height: 30),
            const Text(
              "Yaklaşan Etkinlikler",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Expanded(
              child: StreamBuilder<List<EventItem>>(
                stream: _eventListStream,
                builder: (context, snapshot) {
                  final events = snapshot.data ?? [];
                  return StreamBuilder<bool>(
                    stream: _isLoadingStream,
                    builder: (context, isLoadingSnapshot) {
                      final isLoading = isLoadingSnapshot.data ?? false;
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: events.length + (isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == events.length && isLoading) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: W(context) * 0.5),
                                child: Platform.isIOS
                                    ? const CupertinoActivityIndicator(radius: 20)
                                    : const CircularProgressIndicator(color: Colors.deepPurple),
                              ),
                            );
                          }
                          final event = events[index];
                          return eventButtonContainer(context, event);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}