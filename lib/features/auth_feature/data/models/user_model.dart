import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    super.email,
    required super.mobile,
    required super.image,
    required super.isActive,
    required super.wallet,
    required super.isVerified,
    required super.rate,
    required super.countUnread,
    this.token,
  });

  final String? token;

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      image: json['image'] ?? '',
      isActive: json['is_active'] ?? false,
      isVerified: json['user_verify'] ?? false,
      wallet: double.tryParse(json['wallet'].toString()) ?? 0,
      token: json['token'],
      rate: json['rate'] ?? '',
      countUnread: json['count_unread'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'image': image,
        'is_active': isActive,
        'user_verify': isVerified,
        'wallet': wallet,
        'rate': rate,
      };
}
