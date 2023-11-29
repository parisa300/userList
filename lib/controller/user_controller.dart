
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:userlist/model/users.dart';
import 'package:uuid/uuid.dart';


import '../utils/app_config.dart';
import '../widgets/k_txt.dart';

class UserController extends GetxController {
  final _dio = Dio();

  final page = RxInt(1);
  //per page data show number
  final perPage = RxInt(5);
  final user = RxList<User>();
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

        final List<User> userData = response.data['data']
            .map((json) => User.fromJson(json))
            .toList()
            .cast<User>();
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

  void addNewUserData() async {
    try {
      final res = await _dio.post('$baseUrl', data: {
        'id': Uuid().v4(),
        'email': email.value,
        'first_name': firstName.value,
        'last_name': lastName.value,
      });

      if (res.statusCode == 201) {

        Get.defaultDialog(
          title: 'success',
          content: KText(
            text: 'user added',
            color: Colors.black,
          ),
        );
        await Future.delayed(Duration(seconds: 1));

      //  Get.offAll(BottomBarHome());
        return res.data;


      } else {
        throw Exception('Please correct the Status Code');
      }
    } catch (e) {
      print(e);
    }
  }
}