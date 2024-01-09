import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/features/location_feature/domain/repositories/base_location_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/location.dart';

class AddLocationUseCase {
  final BaseLocationRepository baseLocationRepository;

  AddLocationUseCase({required this.baseLocationRepository});

  Future<Either<Failure, List<Location>>> call({
    required String title,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
  }) async {
    return await baseLocationRepository.addLocation(
      title: title,
      lat: lat,
      long: long,
      floorNum: floorNum,
      buildingNum: buildingNum,
    );
  }
}
