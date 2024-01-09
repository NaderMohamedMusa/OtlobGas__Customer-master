import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class RegisterUseCase {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String mobile,
    XFile? image,
    required String password,
    required String confirmPassword,
  }) async {
    return await baseAuthRepository.register(
      name: name,
      email: email,
      mobile: mobile,
      image: image,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
