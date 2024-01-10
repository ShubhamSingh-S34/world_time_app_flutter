import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location = '';
  late String time = '';
  late String flag = '';
  late String url = '';
  late bool isDayTime = false;

  WorldTime({this.location = '', this.flag = '', this.url = ''});

  Future<void> getTime() async {
    try {
      Uri urlLink = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
      Response response = await get(urlLink);
      Map data = jsonDecode(response.body);
      // print("This is the data : ");
      // print(data['datetime']);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      print(now);
      // Set the time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('OOPS ERROR IN world_time.dart line :32');
      print(e);
      time = 'Could not get the time data from api';
    }
  }
}
