import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/location.dart';
import '../repositories/base_location_repository.dart';

class DeleteLocationUseCase {
  final BaseLocationRepository baseLocationRepository;

  DeleteLocationUseCase({required this.baseLocationRepository});

  Future<Either<Failure, List<Location>>> call({required String id}) async {
    return await baseLocationRepository.deleteLocation(id: id);
  }
}
