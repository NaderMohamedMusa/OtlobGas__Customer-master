import 'package:dartz/dartz.dart';
import 'package:otlobgas_driver/core/errors/failures.dart';
import 'package:otlobgas_driver/features/chat_feature/data/models/chat_model.dart';
import 'package:otlobgas_driver/features/order_feature/data/models/order_model.dart';

import '../../../../core/network/network_info.dart';
import '../../../auth_feature/data/models/user_model.dart';
import '../../domain/repositories/base_pusher_repository.dart';
import '../data_source/pusher_remote_data_source.dart';

class PusherRespoitory implements BasePusherRepository {
  final BasePusherRemoteDataSource basePusherRemoteDataSource;
  final NetworkInfo networkInfo;

  PusherRespoitory({
    required this.basePusherRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Stream<UserModel> listenToUser() {
    return basePusherRemoteDataSource.listenToUser();
  }

  @override
  Future<Either<Failure, Unit>> initPusher({required int driverId}) async {
    try {
      await basePusherRemoteDataSource.initPusher(driverId: driverId);

      return const Right(unit);
    } catch (error) {
      return Left(UnExpectedFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnectPusher() async {
    try {
      await basePusherRemoteDataSource.disconnectPusher();

      return const Right(unit);
    } catch (error) {
      return Left(UnExpectedFailure(message: error.toString()));
    }
  }

  @override
  Stream<OrderModel> listenToOrder() {
    return basePusherRemoteDataSource.listenToOrder();
  }

  @override
  Future<Either<Failure, Unit>> subscribeToOrder(
      {required int driverId}) async {
    try {
      await basePusherRemoteDataSource.subscribeToOrder(driverId: driverId);

      return const Right(unit);
    } catch (error) {
      return Left(UnExpectedFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> subscribeToChat({required int orderId}) async {
    try {
      await basePusherRemoteDataSource.subscribeToChat(orderId: orderId);

      return const Right(unit);
    } catch (error) {
      return Left(UnExpectedFailure(message: error.toString()));
    }
  }

  @override
  Stream<ChatModel> listenToChat() {
    return basePusherRemoteDataSource.listenToChat();
  }
}
