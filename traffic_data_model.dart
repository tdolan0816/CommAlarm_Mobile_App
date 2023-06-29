class TrafficDataModel {
  final int? id;
  final String origin;
  final String destination;
  final String durationInTraffic;

  const TrafficDataModel ({
    required this.id,
    required this.origin,
    required this.destination,
    required this.durationInTraffic,
  });

  factory TrafficDataModel.fromJSON(Map<String, dynamic> json) =>  TrafficDataModel(
    id: json['id'],
    origin: json['origin'],
    destination: json['destination'],
    durationInTraffic: json['durationInTraffic'],
  );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'origin': origin,
    'destination': destination,
    'durationInTraffic': durationInTraffic,
  };
}