import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/location.dart';
import '../repositories/base_location_repository.dart';

class EditLocationUseCase {
  final BaseLocationRepository baseLocationRepository;

  EditLocationUseCase({
    required this.baseLocationRepository,
  });

  Future<Either<Failure, List<Location>>> call({
    required String title,
    required String id,
    required double lat,
    required double long,
    String? floorNum,
    String? buildingNum,
  }) async {
    return await baseLocationRepository.editLocation(
      id: id,
      title: title,
      lat: lat,
      long: long,
      floorNum: floorNum,
      buildingNum: buildingNum,
    );
  }
}
