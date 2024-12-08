class Mission {
  final String id;
  final String title;
  final String patient;
  final DateTime start;
  final DateTime end;

  Mission({
    required this.id,
    required this.title,
    required this.patient,
    required this.start,
    required this.end,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'],
      title: json['title'],
      patient: json['patient'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }
}
