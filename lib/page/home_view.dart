
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:userlist/model/user_model.dart';
import 'package:userlist/utils/constant.dart';

import '../controller/user_controller.dart';


class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final UserController homeController = Get.put(UserController());
  List<UserModel> users = UserModel.fromJsonToList(());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      backgroundColor: Colors.grey.shade900,
      appBar: _buildAppBar(),
      floatingActionButton: Obx(() =>
      homeController.isInternetConnect.value ? _buildFAB(context) : Container()),
      body: Obx(
            () => SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: homeController.isInternetConnect.value
              ? homeController.isLoading.value
              ? _buildLoading()
              : _buildMainBody(context)
              : _buildNoInternetConnection(context),
        ),
      ),

    );
  }


  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.indigo,
      centerTitle: true,
      title: const Text("ListUser"),
    );
  }

  /// Floating Action Button
  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {

        createAlertDialog(context).then((onValue) {
          users.add(UserModel(
              id: 1,
              avatar: "",
              first_name: " ",
              last_name: " ",
              email: "",
              ));

        });
        createAlertDialog(context).then((onValue) {
          users.add(onValue);

        });
      },
      backgroundColor: Colors.indigo,
      child: const Icon(  Icons.add,)
    );
  }

  /// When Internet is't Okay, show this widget
  Widget _buildNoInternetConnection(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Lottie.asset('assets/b.json'),
          ),
          MaterialButton(
            minWidth: 130,
            height: 45,
            onPressed: () => _materialOnTapButton(context),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.grey,
            child: const Text(
              "Try Again",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(BuildContext context) {
    return LiquidPullToRefresh(
      color: Colors.blue,
      showChildOpacityTransition: true,
      onRefresh: () {
        return homeController.getAllUserData(context);
      },
      child: ListView.builder(
        controller: homeController.getAllUserData(context),
        physics: const BouncingScrollPhysics(),
        itemCount: homeController.user.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {

            },
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                  NetworkImage("${homeController.user[index].avatar.toString()}"),
                  backgroundColor: Colors.transparent,
                  child: Center(
                    child: Text(
                      homeController.user[index].first_name.toString() ,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.grey),
                    ),
                  ),
                ),
                title: Text(
                  homeController.user[index].last_name.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.grey),
                ),
                subtitle: Text(
                  homeController.user[index].email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Loading Widget
  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
          width: 150,
          height: 150,
          child: Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          )),
    );
  }

  /// onTap Func of "Try Again Button"
  void _materialOnTapButton(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      homeController.getAllUserData(context);
    } else {
      showCustomSnackBar(context: context);
    }
  }
}

Future<UserModel> createAlertDialog(BuildContext context) async {
  TextEditingController customController = TextEditingController();

  UserModel user = UserModel(
      avatar: '', first_name: "", last_name: "", email: "", id:1 );
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Name of the User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  user.id = value as int;
                },
              ),
              TextField(
                onChanged: (value) {
                  user.first_name = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  user.last_name = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
                elevation: 5.0,
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(user);
                })
          ],
        );
      });
}
