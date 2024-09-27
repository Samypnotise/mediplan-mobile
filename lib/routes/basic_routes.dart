import 'package:mediplan/constants/api_constants.dart';

class BasicRoutes {
  static String get(String table) {
    return '${ApiConstants.baseUrl}/$table';
  }

  static String post(String table) {
    return '${ApiConstants.baseUrl}/$table';
  }

  static String getById(String table, String id) {
    return '${ApiConstants.baseUrl}/$table/$id';
  }

  static String update(String table, String id) {
    return '${ApiConstants.baseUrl}/$table/$id';
  }

  static String delete(String table, String id) {
    return '${ApiConstants.baseUrl}/$table/$id';
  }
}
