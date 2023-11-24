
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/user_model.dart';
import '../utils/app_config.dart';
import '../widgets/k_txt.dart';

class UserController extends GetxController {
  final _dio = Dio();

  final page = RxInt(1);
  //per page data show number
  final perPage = RxInt(5);
  final user = RxList<UserModel>();
  final isEmpty = RxBool(true);
  final isLoading = RxBool(false);
  final isUpdate = RxBool(false);
  RxBool isInternetConnect = true.obs;
  final scrollController = ScrollController();

  //

  // user model
  final email = RxString('');
  final firstName = RxString('');
  final lastName = RxString('');
  final avatar = RxString('');
  //
  /// For Checking Internet Connection
  isInternatConnect() async {
    isInternetConnect.value = await InternetConnectionChecker().hasConnection;
  }
  //
  getAllUserData(BuildContext context) async {
    try {
      if (user.isEmpty) {
        final response = await _dio
            .get('$baseUrl');

        final List<UserModel> userData = response.data['data']
            .map((json) => UserModel.fromJson(json))
            .toList()
            .cast<UserModel>();
        if (response.statusCode == 200) {
          user.addAll(userData);
        }
      }
    } catch (e) {
      print(e);
      final snackbar = SnackBar(
        backgroundColor: Colors.grey,
        content: KText(
          text: e.toString(),
          color: Colors.white,
          maxLines: 5,
        ),
      );
      return ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }


}