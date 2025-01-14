import 'package:http/http.dart' as http;
import 'package:mediplan/routes/basic_routes.dart';

class MissionSwapRepository {
  Future<http.Response> createMissionSwapDemand({
    required String missionSwapDemandJson,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse(BasicRoutes.post("swap-requests")),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
      body: missionSwapDemandJson,
    );

    return response;
  }

  Future<http.Response> updateMissionSwapDemand({
    required String missionSwapDemandJson,
    required String missionSwapDemandId,
    required String token,
  }) async {
    final response = await http.patch(
      Uri.parse(
          BasicRoutes.update("swap-requests", missionSwapDemandId)),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
      body: missionSwapDemandJson,
    );

    return response;
  }
}
