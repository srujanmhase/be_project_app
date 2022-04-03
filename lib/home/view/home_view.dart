// ignore_for_file: prefer_final_locals, lines_longer_than_80_chars, library_private_types_in_public_api, avoid_dynamic_calls

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

  late DatabaseReference xRef;
  late DatabaseReference yRef;
  late DatabaseReference zRef;
  late DatabaseReference prediction;

  TextEditingController formController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setReferences('Sensor');
  }

  void setReferences(String sensorID) {
    prediction = FirebaseDatabase.instance.ref('$sensorID/Prediction');
    xRef = FirebaseDatabase.instance.ref('$sensorID/X_axis');
    yRef = FirebaseDatabase.instance.ref('$sensorID/Y_axis');
    zRef = FirebaseDatabase.instance.ref('$sensorID/Z_axis');
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
            const Text(
              'Anomaly Detection',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter Device ID',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 150,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: formController,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        splashColor: Colors.grey,
                        onPressed: () {
                          setState(() {
                            setReferences(formController.text);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: prediction.onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 170,
                    width: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: snapshot.data.snapshot.value.toString() == '0'
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
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StreamBuilder<dynamic>(
                                  stream: xRef.onValue,
                                  builder: (
                                    BuildContext context,
                                    AsyncSnapshot snapshot,
                                  ) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.snapshot.value.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      return const Text('No data');
                                    }
                                  },
                                ),
                                StreamBuilder<dynamic>(
                                  stream: yRef.onValue,
                                  builder: (
                                    BuildContext context,
                                    AsyncSnapshot snapshot,
                                  ) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.snapshot.value.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      return const Text('No data');
                                    }
                                  },
                                ),
                                StreamBuilder<dynamic>(
                                  stream: zRef.onValue,
                                  builder: (
                                    BuildContext context,
                                    AsyncSnapshot snapshot,
                                  ) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.snapshot.value.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      return const Text('No data');
                                    }
                                  },
                                ),
                              ],
                            ),
                            Icon(
                              snapshot.data.snapshot.value.toString() == '0'
                                  ? Icons.check_box
                                  : Icons.cancel,
                            )
                          ],
                        ),
                        Text(
                          'Status: ${snapshot.data.snapshot.value.toString() == '0' ? 'Normal Condition' : 'Anomaly'}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Text('404 Sensor not found');
              },
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
        ),
      ),
    );
  }
}
