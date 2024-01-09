import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String? email;
  final String mobile;
  final String image;
  final bool isActive;
  final bool isVerified;
  final double wallet;
  final String rate;
  final int countUnread;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.image,
    required this.isActive,
    required this.isVerified,
    required this.wallet,
    required this.rate,
    required this.countUnread,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        mobile,
        image,
        isActive,
        isVerified,
        wallet,
        rate,
        countUnread,
      ];
}
