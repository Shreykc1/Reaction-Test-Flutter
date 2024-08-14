import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random random = Random();
  Stopwatch stopwatch = Stopwatch();
  bool isWaiting = false;
  bool isReady = false;
  String buttonText = 'Start';
  int reactionTime = 0;

  void startTest() {
    buttonText = 'Wait for green';
    isWaiting = true;
    Future.delayed(Duration(seconds: random.nextInt(3) + 3)).then((_) {
      if (isWaiting) {
        stopwatch.start();
        isReady = true;
        buttonText = 'TAP!';
        setState(() {});
      }
    });
    setState(() {});
  }

  void endTest() {
    if (isReady) {
      stopwatch.stop();
      reactionTime = stopwatch.elapsedMilliseconds;
      buttonText = 'Your time: $reactionTime ms';
      isReady = false;
    } else if (isWaiting) {
      buttonText = 'Too early! Try again';
      isWaiting = false;
    }
    stopwatch.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Set to 0 for fully filled corners
                  )
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return isReady ? Colors.green : Colors.blue;
                    return isReady ? Colors.green : Colors.blue;
                  }
              ),
            ),
            onPressed: isReady ? endTest : (!isReady && !isWaiting ? startTest : null),
            child: Text(buttonText,
            style: TextStyle(
              fontSize: 50,
              color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }
}
