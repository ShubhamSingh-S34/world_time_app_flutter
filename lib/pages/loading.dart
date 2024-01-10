import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpWorldTime(BuildContext context) async {
    WorldTime instance = WorldTime(
        location: 'Kolkata', flag: 'germany.png', url: 'Asia/Kolkata');

    await instance.getTime();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpWorldTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 50.0,
            ),
          )),
    );
  }
}
