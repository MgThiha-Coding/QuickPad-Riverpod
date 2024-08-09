import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeNotifier extends StateNotifier<DateTime> {
  late Timer _timer;

  DateTimeNotifier() : super(DateTime.now()) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getFormattedDateTime() {
    return DateFormat('hh:mm a').format(state);
  }
}

final dateTimeProvider = StateNotifierProvider<DateTimeNotifier, DateTime>(
  (ref) => DateTimeNotifier(),
);
