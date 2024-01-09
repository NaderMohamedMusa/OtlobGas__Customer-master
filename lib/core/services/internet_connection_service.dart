import 'package:get/get.dart';
import 'package:otlobgas_driver/core/network/network_info.dart';

class InternetConnectionService extends GetxService {
  final NetworkInfo networkInfo;

  InternetConnectionService({required this.networkInfo});
  Future<InternetConnectionService> init() async {
    await listenToNetwork();
    return this;
  }

  listenToNetwork() async {
    networkInfo.listenToNetworkStream.onData((bool isConnected) {
      if (isConnected) {
        // Utils.removeEnhancedDialog(
        //     dialogName: Utils.localization?.networkFailure ?? '');
      } else {
        // Utils.handleFailures(const ConnectionFailure());
      }
    });
  }
}
