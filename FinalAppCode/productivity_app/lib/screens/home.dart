import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:productivity_app/trapezoid_button.dart';
import 'package:productivity_app/screens/edit_alarm.dart';
import 'package:productivity_app/screens/ring.dart';
import 'package:productivity_app/screens/tile.dart';
import 'package:flutter/material.dart';

class ExampleAlarmHomeScreen extends StatefulWidget {
  const ExampleAlarmHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleAlarmHomeScreen> createState() => _ExampleAlarmHomeScreenState();
}

class _ExampleAlarmHomeScreenState extends State<ExampleAlarmHomeScreen> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
          (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: const TrapezoidalAppBar(
      title: "Reminder", color: Colors.blue,
    ),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
              child: ListView.separated(
          itemCount: alarms.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
              return ExampleAlarmTile(
                key: Key(alarms[index].id.toString()),
                title: TimeOfDay(
                  hour: alarms[index].dateTime.hour,
                  minute: alarms[index].dateTime.minute,
                ).format(context),
                onPressed: () => navigateToAlarmScreen(alarms[index]),
                onDismissed: () {
                  Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                },
              );
          },
        ),
            )
            : Center(
          child: Text(
            "No alarms set",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                final alarmSettings = AlarmSettings(
                  id: 42,
                  dateTime: DateTime.now(),
                  assetAudioPath: 'assets/mozart.mp3',
                );
                Alarm.set(alarmSettings: alarmSettings);
              },
              backgroundColor: Colors.red,
              heroTag: null,
              child: const Text("RING NOW", textAlign: TextAlign.center),
            ),
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
