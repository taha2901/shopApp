class ShopLoginModel {
  final bool status;
  final String? message;
  final UserData? data;

  ShopLoginModel(
      {required this.status, required this.message, required this.data});
  factory ShopLoginModel.fromjson(json) {
    return ShopLoginModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromjson(json['data']) : null,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credits;
  final String token;

  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.points,
      required this.credits,
      required this.token});
  factory UserData.fromjson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        points: json['points'],
        credits: json['credit'],
        token: json['token']);
  }
}
