import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:productivity_app/trapezoid_button.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late Timer _timer;
  int _timeLeftInSeconds = 0;
  int _sessionTimeInSeconds = 25 * 60;
  int _breakTimeInSeconds = 5 * 60;
  bool _isSessionActive = true;
  bool _isRunning = false;
  int _pausedTime = 0;

  final TextEditingController _sessionTimeController = TextEditingController();
  final TextEditingController _breakTimeController = TextEditingController();

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeftInSeconds > 0) {
          _timeLeftInSeconds--;
        } else {
          _isSessionActive = !_isSessionActive;
          _timeLeftInSeconds =
          _isSessionActive ? _sessionTimeInSeconds : _breakTimeInSeconds;
        }
      });
    });
  }

  void _pauseTimer() {
    if (!_isRunning) return;
    _isRunning = false;
    _pausedTime = _timeLeftInSeconds;
    _timer.cancel();
  }

  void _resumeTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _timeLeftInSeconds = _pausedTime;
    _startTimer();
  }

  void _stopTimer() {
    _isRunning = false;
    _timer.cancel();
  }

  void _resetTimer() {
    _isRunning = false;
    _timer.cancel();
    setState(() {
      _isSessionActive = true;
      _timeLeftInSeconds = _sessionTimeInSeconds;
    });
  }

  void _setSessionTime() {
    setState(() {
      _sessionTimeInSeconds = int.parse(_sessionTimeController.text) * 60;
      _timeLeftInSeconds = _sessionTimeInSeconds;
    });
    Navigator.pop(context);
    _resetTimer();
  }

  void _setBreakTime() {
    setState(() {
      _breakTimeInSeconds = int.parse(_breakTimeController.text) * 60;
    });
    Navigator.pop(context);
    _resetTimer();
  }

  void _showSessionTimeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Session Time'),
        content: TextField(
          controller: _sessionTimeController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Enter session time in minutes',
          ),
        ),
        actions: [
          TextButton(
            onPressed: _setSessionTime,
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showBreakTimeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Break Time'),
        content: TextField(
          controller: _breakTimeController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Enter break time in minutes',
          ),
        ),
        actions: [
          TextButton(
            onPressed: _setBreakTime,
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timeLeftInSeconds = _sessionTimeInSeconds;
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  String _getTimeString(int timeInSeconds) {
    int minutes = (timeInSeconds / 60).floor();
    int seconds = timeInSeconds % 60;
    String minutesStr = (minutes < 10 ? '0' : '') + minutes.toString();
    String secondsStr = (seconds < 10 ? '0' : '') + seconds.toString();
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: const TrapezoidalAppBar(
          title:'Focus Study', color: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isSessionActive ? 'Session' : 'Break',
                style: const TextStyle(fontSize: 32,
                        color: Colors.white
                ),
              ),
              SizedBox(height: 16),
              Text(
                _getTimeString(_timeLeftInSeconds),
                style: TextStyle(fontSize: 64,
                    color: Colors.white),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _showSessionTimeDialog,
                    child: Text('Set Session Time',),
                  ),
                  ElevatedButton(
                    onPressed: _showBreakTimeDialog,
                    child: Text('Set Break Time'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: !_isRunning ? _startTimer : null,
                    child: const Text('Start',
                    style: TextStyle(color: Colors.white),),
                  ),
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : null,
                    child: Text('Pause'),
                  ),
                  ElevatedButton(
                    onPressed: _isRunning ? _stopTimer : null,
                    child: Text('Stop'),
                  ),
                  ElevatedButton(
                    onPressed: _isRunning ? _resumeTimer : null,
                    child: Text('Resume'),
                  ),
                  ElevatedButton(
                    onPressed: !_isRunning ? null : _resetTimer,
                    child: Text('Reset'),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  }
}
