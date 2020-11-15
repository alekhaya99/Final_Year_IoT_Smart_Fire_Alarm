import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fyp/MQ2.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Smoke extends StatefulWidget {
  @override
  _SmokeState createState() => _SmokeState();
}

class _SmokeState extends State<Smoke> {
  DatabaseReference smoke_sensor_ref = FirebaseDatabase.instance.reference().child('SmokeSensor');
  @override
  Widget build(BuildContext context) {
    return SmokeValue();
  }

  Widget SmokeValue(){
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: smoke_sensor_ref.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    var _smoke =
                    SmokeSensor.fromJson(snapshot.data.snapshot.value['Json']);
                    print(
                        "SmokeSensor: ${_smoke.co} / ${_smoke.lpg} / ${_smoke.smoke}");

                    return _smokeLayout(_smoke);
                  } else {
                    return Center(
                      child: Text("NO DATA YET"),
                    );
                  }
                }

            ),
          )
        ],
      ),
    );
  }
  Widget _smokeLayout(SmokeSensor _smoke){
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Center(child: Text("Carbon Monoxide Value",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
        SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 200,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                GaugeRange(startValue: 50,endValue: 100,color: Colors.yellow),
                GaugeRange(startValue: 100,endValue: 150,color: Colors.orange),
              GaugeRange(startValue:150,endValue: 200,color:Colors.red )],
              pointers: <GaugePointer>[
                NeedlePointer(value: _smoke.co)],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(widget: Container(child:
                Text('${_smoke.co.toStringAsFixed(1)}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                    angle: 90, positionFactor: 0.5
                )]
          )]
        ),
        Center(child: Text("LPG Value",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
        SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 200,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                GaugeRange(startValue: 50,endValue: 100,color: Colors.yellow),
                GaugeRange(startValue: 100,endValue: 150,color: Colors.orange),
                GaugeRange(startValue:150,endValue: 200,color:Colors.red )],
              pointers: <GaugePointer>[
                NeedlePointer(value: _smoke.lpg.toDouble())],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(widget: Container(child:
                Text('${_smoke.lpg.toStringAsFixed(2)}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                    angle: 90, positionFactor: 0.5
                )]
          )]
        ),
        Center(child: Text("Smoke Value",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
        SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 200,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
                GaugeRange(startValue: 50,endValue: 100,color: Colors.yellow),
                GaugeRange(startValue: 100,endValue: 150,color: Colors.orange),
                GaugeRange(startValue:150,endValue: 200,color:Colors.red )],
              pointers: <GaugePointer>[
                NeedlePointer(value: _smoke.smoke)],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(widget: Container(child:
                Text('${_smoke.smoke.toStringAsFixed(1)}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                    angle: 90, positionFactor: 0.5
                )]
          )]
        ),

      ],
    );
  }
}

