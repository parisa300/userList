import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userlist/controller/user_controller.dart';
import 'package:userlist/widgets/k_txt.dart';


class AddUserDataPage extends StatefulWidget {
  @override
  State<AddUserDataPage> createState() => _AddUserDataPageState();
}

class _AddUserDataPageState extends State<AddUserDataPage> {
  final _formKey = GlobalKey<FormState>();
  final userList_new = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: KText(
          text: 'Add User',
          fontSize: 18,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 10,),
                kTextFormField(
                  onChanged: userList_new.email,
                  validator: (value) {
                    if (value == null || userList_new.email.value.isEmpty) {
                      return 'Please enter email';
                    }
                    return '';
                  },
                  color: Colors.grey,
                  hintText: 'email',
                ),
                const SizedBox(height: 10,),
                kTextFormField(
                  onChanged: userList_new.firstName,
                  validator: (value) {
                    if (value == null || userList_new.firstName.value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return '';
                  },
                  color: Colors.grey,
                  hintText: 'first name',
                ),
                const SizedBox(height: 10,),
                kTextFormField(
                  onChanged: userList_new.lastName,
                  validator: (value) {
                    if (value == null || userList_new.lastName.value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return '';
                  },
                  color: Colors.grey,
                  hintText: 'last name',
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate() ||
                        userList_new.user.isNotEmpty ||
                        userList_new.email.value.isNotEmpty ||
                        userList_new.firstName.value.isNotEmpty ||
                        userList_new.lastName.value.isNotEmpty) {
                      userList_new.addNewUserData();
                    } else {
                      Get.snackbar('title', 'message');
                    }
                  },
                  child: Container(
                    height: 40,
                    width: Get.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                    ),
                    child: KText(
                      text: 'Add',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget kTextFormField({
    required final String hintText,
    // required final String errorText,
    required final Color color,
    required final void Function(String)? onChanged,
    required final String? Function(String?) validator,
  }) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green,),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide( color: Colors.green,),
        ),
        // errorText: errorText,
        hintText: hintText,
      ),
    );
  }
}
