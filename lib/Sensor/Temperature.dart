import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:fyp/dht.dart';

class SinglePageApp extends StatefulWidget {
  @override
  _SinglePageAppState createState() => _SinglePageAppState();
}

class _SinglePageAppState extends State<SinglePageApp> {
  DatabaseReference _dhtRef =
      FirebaseDatabase.instance.reference().child('DHT');

  String heatIndexText;

  @override
  Widget build(BuildContext context) {
    return mainScaffold();
  }

  Widget mainScaffold() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: _dhtRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    var _dht =
                        DHT.fromJson(snapshot.data.snapshot.value['Json']);
                    print(
                        "DHT: ${_dht.temp} / ${_dht.humidity} / ${_dht.heatIndex}/ ${_dht.temp_F}");

                    return _temperatureLayout(_dht);
                  } else {
                    return Center(
                      child: Text("NO DATA YET"),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _temperatureLayout(DHT _dht) {
    return Center(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            "TEMPERATURE",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: FAProgressBar(
                    progressColor: Colors.green,
                    direction: Axis.vertical,
                    verticalDirection: VerticalDirection.up,
                    size: 100,
                    currentValue: _dht.temp.round(),
                    changeColorValue: 100,
                    changeProgressColor: Colors.red,
                    maxValue: 150,
                    displayText: "°C",
                    borderRadius: 16,
                    animatedDuration: Duration(milliseconds: 500),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: FAProgressBar(
                    progressColor: Colors.green,
                    direction: Axis.vertical,
                    verticalDirection: VerticalDirection.up,
                    size: 100,
                    currentValue: _dht.temp_F.round(),
                    changeColorValue: 100,
                    changeProgressColor: Colors.red,
                    maxValue: 150,
                    displayText: "°F",
                    borderRadius: 16,
                    animatedDuration: Duration(milliseconds: 500),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: FAProgressBar(
                    progressColor: Colors.green,
                    direction: Axis.vertical,
                    verticalDirection: VerticalDirection.up,
                    size: 100,
                    currentValue: _dht.humidity.round(),
                    changeColorValue: 100,
                    changeProgressColor: Colors.red,
                    maxValue: 150,
                    displayText: "%",
                    borderRadius: 16,
                    animatedDuration: Duration(milliseconds: 500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "${_dht.temp.toStringAsFixed(2)} °C",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "${_dht.temp_F.toStringAsFixed(2)} °F",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            "${_dht.humidity.toStringAsFixed(2)} %",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
      ],
    ));
  }
}
