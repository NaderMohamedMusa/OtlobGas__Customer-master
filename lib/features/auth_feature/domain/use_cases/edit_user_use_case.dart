import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class EditUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  EditUserUseCase({required this.baseAuthRepository});

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    XFile? image,
    required String password,
    required String confirmPassword,
  }) async {
    return await baseAuthRepository.editUser(
      name: name,
      email: email,
      image: image,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
