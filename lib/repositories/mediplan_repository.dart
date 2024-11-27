import 'package:http/http.dart' as http;
import 'package:mediplan/routes/basic_routes.dart';

class MediplanRepository {
  // TODO : Method to return user's missions

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
