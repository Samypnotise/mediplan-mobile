import 'package:animated_custom_dropdown/custom_dropdown.dart';

class Mission with CustomDropdownListFilter {
  final String id;
  final String title;
  final String patient;
  final DateTime start;
  final DateTime end;
  final double latitude;
  final double longitude;
  final String address;

  Mission({
    required this.id,
    required this.title,
    required this.patient,
    required this.start,
    required this.end,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'],
      title: json['title'],
      patient: json['patient'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      address: json['address'],
    );
  }

  //? Allows this object to be searchable in a dropdown
  @override
  bool filter(String query) {
    return patient.toLowerCase().contains(query.toLowerCase()) ||
        title.toLowerCase().contains(query.toLowerCase());
  }
}
