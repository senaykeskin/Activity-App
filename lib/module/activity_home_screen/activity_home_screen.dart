import 'dart:io';

import 'package:activity_app/global/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../stores/event_store.dart';
import '../../global/global-variables.dart';
import '../../models/activity_model.dart';
import '../../widgets/searchAndFilter.dart';
import 'methods.dart';

class ActivityHomeScreen extends StatefulWidget {
  const ActivityHomeScreen({super.key});

  @override
  State<ActivityHomeScreen> createState() => _ActivityHomeScreenState();
}

class _ActivityHomeScreenState extends State<ActivityHomeScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final EventStore _eventStore;
  late Stream<bool> _isLoadingStream;
  late Stream<List<EventItem>> _eventListStream;
  late final AnimationController _controller;

  int firstItemCount = 20;

  @override
  void initState() {
    super.initState();
    _eventStore = eventStore;
    _isLoadingStream = _eventStore.isLoadingStream;
    _eventListStream = _eventStore.eventListStream;
    _eventStore.fetchAllEvents();
    _scrollController.addListener(_onScroll);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
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
    _controller.dispose();
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
          AppStrings.homePage,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: all10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchAndFilter(),
            const SizedBox(height: 30),
            const Text(
              AppStrings.events,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Expanded(
              child: StreamBuilder<int>(
                stream: _eventStore.eventLengthStream,
                builder: (context, lengthSnapshot) {
                  final eventLength = lengthSnapshot.data ?? 0;
                  if (eventLength == 0) {
                    return Center(
                      child: Padding(
                        padding: top30,
                        child: Column(
                          children: [
                            Lottie.asset('assets/animations/notFound.json',
                                height: 150,
                                fit: BoxFit.fill,
                                controller: _controller),
                            const Text(
                              AppStrings.eventNotFound,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return StreamBuilder<List<EventItem>>(
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: W(context) * 0.5),
                                    child: Platform.isIOS
                                        ? const CupertinoActivityIndicator(
                                            radius: 20)
                                        : const CircularProgressIndicator(
                                            color: Colors.deepPurple),
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
