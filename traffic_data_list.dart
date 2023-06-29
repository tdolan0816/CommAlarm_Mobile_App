// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:commalarm_app/traffic_data_model.dart';
import 'package:commalarm_app/database_helper.dart';


void main() {
  runApp(const MaterialApp(
    home: TrafficDataList(),
  ));
}

class TrafficDataList extends StatefulWidget {
  const TrafficDataList({Key? key}) : super(key: key);

  @override
  _TrafficDataListState createState() => _TrafficDataListState();
}

class _TrafficDataListState extends State<TrafficDataList> {
  List<TrafficDataModel> trafficDataList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic Data List'),
      ),
      body:
      FutureBuilder<List<TrafficDataModel>>(
        future: DataBaseHelper.getAllTrafficData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].origin),
                  subtitle: Text(snapshot.data![index].destination),
                  trailing: Text(snapshot.data![index].durationInTraffic),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data found')
            );
          }
        },
      ),
    );
  }
}
