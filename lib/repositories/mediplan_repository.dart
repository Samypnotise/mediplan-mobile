import 'package:http/http.dart' as http;
import 'package:mediplan/routes/basic_routes.dart';

class MediplanRepository {
  Future<http.Response> getUserMissions({
    required String userId,
    required String token,
  }) async {
    final response = await http.get(
      // TODO : À voir pour refactor cette partie et gérer la pagination
      Uri.parse("${BasicRoutes.get("users")}/$userId/missions?limit=100"),
      headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    return response;
  }

  //! Method to get other users
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
