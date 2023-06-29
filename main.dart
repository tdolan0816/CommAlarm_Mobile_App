import 'package:flutter/material.dart';

import './review_sidebutton_card.dart';
import './gridview_buttonselection.dart';
import './review_card.dart';

void main() {
  runApp(
    const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key,}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Directionality(
  textDirection: TextDirection.ltr,
    child:
     Stack(
      children: [
        Positioned(
          top: 40, 
          left: 0, 
          child: ReviewCardBuild()
          ),
        Positioned(
          top: 75,
          left: 300,
          child: SideButtonsCardBuild(),
        ),
        Positioned(
          top: 400,
          left: 0,
          child: GridViewButtonsBuild(),
        ),
      ],
    ),
    );
  }
}










































// import 'package:commalarm_app/review_card.dart';
// import 'package:flutter/material.dart';

// import './review_sidebutton_card.dart';
// import './gridview_buttonselection.dart';

// void main() {
//   runApp(
//     const MyHomePage(),
//   );
// }

// // class MyApp extends StatelessWidget {                                     
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       theme: ThemeData(
// //         // primarySwatch: Colors.blue, brightness: Brightness.dark),
// //         primaryColorDark: const Color.fromARGB(255, 25, 76, 178),
// //         primaryColor: const Color.fromARGB(255, 112, 136, 183),
// //         hintColor: const Color.fromARGB(255, 104, 102, 102),
// //         scaffoldBackgroundColor: const Color.fromARGB(255, 5, 5, 5),
// //       ),
// //       title: 'CommAlarm',
// //     );
// //   }
// // }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key,}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//    const MaterialApp(
//     home: Scaffold(
//   body: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//      Stack(
//       clipBehavior: Clip.hardEdge,
//       children: [
//         Positioned(
//           top: 40, 
//           left: 0, 
//           child: ReviewCardBuild()
//           ),
//         Positioned(
//           top: 75,
//           left: 300,
//           child: SideButtonsCardBuild(),
//         ),
//         Positioned(
//           top: 400,
//           left: 0,
//           child: GridViewButtonsBuild(),
//         ),
//       ],
//     ),
//     ],
//   ),
// ),
//     );
//   }
// }
