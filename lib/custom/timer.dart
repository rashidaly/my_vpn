import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vpn_app/custom/utils.dart';

class CountTime extends StatefulWidget {
  const CountTime({Key? key}) : super(key: key);

  @override
  _CountTimeState createState() => _CountTimeState();
}

class _CountTimeState extends State<CountTime> {
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     startTimer();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void addTime(){
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }
  void startTimer() {
timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildTime()
    );
  }
  Widget buildTime(){
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));
    final hour = twoDigit(duration.inHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20,
          width: 20,
          child: Image.asset('assets/images/time.png'),
        ),
        SizedBox(width: 20),

        Text(
          '$hour: $minutes: $seconds',
          style: connectedSubtitle,
        ),
      ],
    );
  }
}
