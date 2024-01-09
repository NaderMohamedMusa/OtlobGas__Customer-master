import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/location.dart';

abstract class BaseLocationRepository {
  Future<Either<Failure, List<Location>>> getAllLocations();

  Future<Either<Failure, List<Location>>> addLocation({
    required String title,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
  });

  Future<Either<Failure, List<Location>>> editLocation({
    required String title,
    required String id,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
  });

  Future<Either<Failure, List<Location>>> deleteLocation({
    required String id,
  });
}
