
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });
  late final int id;
  late final String email;
  late final String first_name;
  late final String last_name;
  late final String avatar;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    email = json['email'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    avatar = json['avatar'];
  }

  static List<UserModel> fromJsonToList(userDataJson) {
    var list = <UserModel>[];
    for (var usr in userDataJson) {
      list.add(
        UserModel(
          id: usr['id'],
          email: usr['email'],
          first_name: usr['first_name'],
          last_name: usr['last_name'],
          avatar: usr['avatar'],
        ),
      );
    }
    return list;
  }


}