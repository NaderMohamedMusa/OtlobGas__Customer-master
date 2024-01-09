import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/location.dart';
import '../repositories/base_location_repository.dart';

class GetAllLocationUseCase {
  final BaseLocationRepository baseLocationRepository;

  GetAllLocationUseCase({required this.baseLocationRepository});

  Future<Either<Failure, List<Location>>> call() async {
    return await baseLocationRepository.getAllLocations();
  }
}
