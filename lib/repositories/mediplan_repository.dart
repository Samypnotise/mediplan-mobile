import 'package:http/http.dart' as http;
import 'package:mediplan/routes/basic_routes.dart';

class MediplanRepository {
  Future<http.Response> getReceivedMissionSwapDemands({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${BasicRoutes.get("swap-requests")}?receiverId=$userId&status=PENDING"),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    return response;
  }

  Future<http.Response> getEmittedMissionSwapDemands({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${BasicRoutes.get("swap-requests")}?senderId=$userId&status=PENDING"),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    return response;
  }

  Future<http.Response> getUserMissions({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      // TODO : À voir pour refactor cette partie et gérer la pagination
      Uri.parse("${BasicRoutes.get("missions")}?limit=100"),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    return response;
  }

  Future<http.Response> getCaregivers({
    required String token,
  }) async {
    final response = await http.get(
      // TODO : Idée d'amélioration : mettre le type de user dans des constantes
      Uri.parse("${BasicRoutes.get("users")}/?type=CAREGIVER"),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    return response;
  }
}
