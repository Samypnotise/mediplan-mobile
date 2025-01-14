import 'dart:convert';

import 'package:mediplan/models/mission.dart';
import 'package:mediplan/models/user.dart';

class MissionSwap {
  final String? id;
  final Mission mission;
  final User receiver;
  final String? receiverId;
  final User sender;
  final String? senderId;
  final String demandStatus;
  final DateTime? createdAt;

  MissionSwap({
    this.id,
    required this.mission,
    required this.receiver,
    this.receiverId,
    required this.sender,
    this.senderId,
    required this.demandStatus,
    this.createdAt,
  });

  factory MissionSwap.fromJson(Map<String, dynamic> json) {
    return MissionSwap(
      id: json['id'],
      mission: Mission.fromJson(json['mission']),
      receiver: User.fromJson(json['receiver']),
      sender: User.fromJson(json['sender']),
      demandStatus: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  String toJson() {
    return jsonEncode({
      'status': demandStatus,
      'receiverId': receiverId,
      'senderId': senderId,
    });
  }
}
