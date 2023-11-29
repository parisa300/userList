
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:userlist/model/users.dart';
import 'package:userlist/page/addUser.dart';
import 'package:userlist/utils/constant.dart';
import 'package:userlist/widgets/k_txt.dart';

import '../controller/user_controller.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final userList_new = Get.put(UserController());
  void initState() {
    super.initState();
    userList_new.scrollController.addListener(() {
      if (userList_new.scrollController.position.atEdge) {
        if (userList_new.scrollController.position.pixels == 0) {
        } else {

          print(userList_new.page.value);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    userList_new.getAllUserData(context);


    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: KText(
          text: 'Home Page',
          fontSize: 18,
          color: Colors.white,
        ),

      ),
      body: Obx(
            () => userList_new.user.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: ListView.builder(
            controller: userList_new.scrollController,
            physics: BouncingScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: userList_new.user.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final userList = userList_new.user[index];

              return GestureDetector(

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: userList_new.user.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : Container(
                    // height: 200,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      // color: HexColor('${item['color']}'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius:
                              BorderRadius.circular(64),
                              child: Image.network(
                                userList.avatar,
                                scale: 1,
                              )),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  KText(
                                    text: userList.first_name,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  KText(
                                    text: userList.last_name,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              KText(
                                text: userList.email,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          SizedBox(width: 10),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  setState(() {
       Get.to(AddUserDataPage());


      });  },
         backgroundColor: Colors.pinkAccent,  child: const Icon(  Icons.add,))
    //   ),),
      // floatingActionButton: Obx(() => userList_new.isLoading.value
      //     ? FloatingActionButton(
      //   onPressed: () {},
      //   child: CircularProgressIndicator(
      //     backgroundColor: Colors.black,
      //   ),
      // )
      //     : SizedBox()),
    );
  }
}


