import 'package:dio/dio.dart';
import 'package:test_user_pagination/model/ApiModel.dart';

class UserApi {
  Future<ApiModel> getUsers(int page) async {
    Response response = await Dio().get("https://reqres.in/api/users?page=$page");
    return ApiModel.fromJson(response.data);
  }
}