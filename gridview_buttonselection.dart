// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:commalarm_app/gmaps_traffic_build.dart';

void main() => runApp(const GridViewButtonsBuild());
 

class GridViewButtonsBuild extends StatefulWidget {
  const GridViewButtonsBuild({Key? key}) : super(key: key);

  
  @override
  _GridViewButtonsBuildState createState() => _GridViewButtonsBuildState();
}

class _GridViewButtonsBuildState extends State<GridViewButtonsBuild> {




  @override
  // Widget build(BuildContext context) {
  //   return 
Widget build(BuildContext context) {
return MaterialApp(
    home: Scaffold(
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    SizedBox(
      height: 400,
      width: 400,
      child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20.0),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: <Widget>[
          TextButton(
            onPressed: () =>
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GMapsTrafficBuild()),
              ),
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Locations\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Origin, Destination and Mode of Transport',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
           
          ),
          TextButton(
            onPressed: () {},
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Alarm Times\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Desired Alarm, Arrival, Ready Times',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),



          TextButton(
            // key: const Key('datePickerButton'),
            onPressed: () {},
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Dates\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set Start Date, End Date, and Frequency of Alarm',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          
          TextButton(
            autofocus: true,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: const Size(50, 50),
              foregroundColor: const Color.fromARGB(255, 187, 182, 182),
              backgroundColor: const Color.fromARGB(255, 44, 44, 44),
              padding: const EdgeInsets.all(8.0),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Date Range\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Set a Date Range for the Alarm to be Active',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {},
          ),

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////          
          const SizedBox(
            height: 75,
          )
        
        ],
      ),
    ),
    const SizedBox(
      height:0,
    ),
    ],
    ),

    ),
    );
  }
}