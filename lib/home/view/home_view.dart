import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String xData = '';
  String yData = '';
  String zData = '';
  String predictionData = '';
  @override
  void initState() {
    super.initState();
    var prediction = FirebaseDatabase.instance.ref('Sensor/Prediction');
    var xRef = FirebaseDatabase.instance.ref('Sensor/X_axis');
    var yRef = FirebaseDatabase.instance.ref('Sensor/Y_axis');
    var zRef = FirebaseDatabase.instance.ref('Sensor/Z_axis');
    prediction.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        predictionData = data.toString();
      });
    });

    xRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        xData = data.toString();
      });
    });

    yRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        yData = data.toString();
      });
    });

    zRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        zData = data.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: 170,
            width: 300,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: predictionData == '0'
                      ? [
                          const Color(0xff00FFE0),
                          const Color(0xff1400FF),
                        ]
                      : [
                          const Color(0xffFF9900),
                          const Color(0xffFF0000),
                        ],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 30,
                      offset: Offset(4, 4),
                      spreadRadius: 2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'x: $xData',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'y: $yData',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'z: $zData',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(predictionData == '0' ? Icons.check_box : Icons.cancel)
                  ],
                ),
                Text(
                  'Status: ${predictionData == '0' ? 'Normal Condition' : 'Anomaly'}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          Column(
            children: const [
              Text(
                'Made by EXTC Group 6 2021-22',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Srujan Mhase  Pramod Mohanty  Shantanu Patil  Sahil Yelgonda',
                style: TextStyle(fontSize: 11),
              ),
            ],
          )
        ],
      )),
    );
  }
}
