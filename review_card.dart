
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';


void main() => runApp(const ReviewCardBuild());

// ignore: must_be_immutable
class ReviewCardBuild extends StatelessWidget {
   const ReviewCardBuild({Key? key}) : super(key: key);


  @override
// Widget build(BuildContext context) {



Widget build(BuildContext context) {

    var username = 'John Smith';

return MaterialApp(
    home: Scaffold(
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Card(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 350,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade400,
              Colors.blue.shade600,
              Colors.blue.shade800,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('Welcome to CommAlarm',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.white)),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100),
            const Text(' Current Alarm Settings',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.white)),
            const SizedBox(height: 10),



          ],
        ),
      ),
    ),
  ],
  ),
  ),
    );
  }
}
  
