import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:woodemo/config.dart';
import 'package:woodemo/models/category.dart';
import 'package:woodemo/models/customer.dart';
import 'package:woodemo/models/login_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken =
        base64.encode(utf8.encode(Config.key + ':' + Config.secret));

    bool ret = false;

    try {
      var response = await Dio().post(Config.url + Config.customer,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/json'
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        ret = true;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  Future<LoginResponseModel> loginCustomer(
      String username, String password) async {
    LoginResponseModel model = LoginResponseModel();

    try {
      var response = await Dio().post(Config.tokenurl,
          data: {
            "username": username,
            "password": password,
          },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }));
      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = <Category>[];

    try {
      String url = Config.url +
          Config.categoriesURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        data =
            (response.data as List).map((e) => Category.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }
}
