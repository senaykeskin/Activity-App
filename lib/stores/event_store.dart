import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import '../models/activity_model.dart';
import '../global/global-service.dart';

class EventStore {
  static final EventStore _instance = EventStore._internal();
  factory EventStore() => _instance;

  EventStore._internal();

  final BehaviorSubject<List<EventItem>> _visibleEventsController =
      BehaviorSubject<List<EventItem>>.seeded([]);

  Stream<List<EventItem>> get eventListStream =>
      _visibleEventsController.stream;

  final BehaviorSubject<bool> _isLoadingController =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  bool get isLoading => _isLoadingController.value;

  List<EventItem> allEvents = [];
  List<EventItem> _filteredEvents = [];
  List<EventItem> _visibleEvents = [];

  Future<void> fetchAllEvents() async {
    try {
      _isLoadingController.add(true);

      final response = await ActivityService.getEvents(skip: 0, take: 0);

      allEvents = response;
      _filteredEvents = allEvents;

      _visibleEvents = allEvents.take(20).toList();
      _visibleEventsController.add(List.from(_visibleEvents));

    } catch (e) {
      inspect(e);
    } finally {
      _isLoadingController.add(false);
    }
  }

  void loadMoreEvents() {
    if (_visibleEvents.length < _filteredEvents.length) {
      int nextLength = _visibleEvents.length + 20;
      if (nextLength > _filteredEvents.length) {
        nextLength = _filteredEvents.length;
      }

      _visibleEvents = _filteredEvents.sublist(0, nextLength);
      _visibleEventsController.add(List.from(_visibleEvents));
    }
  }

  void filterEventsByCity(String city) {
    _filteredEvents = allEvents.where((event) => event.venue?.city?.name == city).toList();
    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
  }

  void filterEventsByCategory(String category) {
    _filteredEvents = allEvents.where((event) => event.category?.name == category).toList();
    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
  }

  void filterEventsByDate(DateTime selectedDate) {
    _filteredEvents = allEvents
        .where((event) => event.start?.isSameDay(selectedDate) ?? false)
        .toList();

    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
  }

  void filterEventsByFreeStatus(bool isFree) {
    if (isFree) {
      _filteredEvents = allEvents.where((event) => event.isFree ?? false).toList();
    } else {
      _filteredEvents = List.from(allEvents);
    }

    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));

  }
  
  void updateFilteredEvents(List<EventItem> filteredEvents) {
    _filteredEvents = filteredEvents;
    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
  }

  void resetEvents() {
    _filteredEvents = allEvents;
    _visibleEvents = allEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
  }

  void dispose() {
    _visibleEventsController.close();
    _isLoadingController.close();
  }
}

final eventStore = EventStore();

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }
}
