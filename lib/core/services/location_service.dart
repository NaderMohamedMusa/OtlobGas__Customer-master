import 'dart:async';
import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otlobgas_driver/core/consts/toast_manager.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/routes/app_pages.dart';
import 'package:otlobgas_driver/features/auth_feature/domain/use_cases/update_user_location_use_case.dart';

import '../../features/auth_feature/domain/use_cases/change_user_activity_use_case.dart';
import '../../features/location_feature/presentation/locations/controllers/locations_controller.dart';
import '../../features/others_feature/domain/entities/nearest_driver.dart';
import '../../features/others_feature/domain/use_cases/get_nearest_drivers_use_case.dart';
import '../consts/assets.dart';
import '../utils/utils.dart';

class LocationService extends GetxService {
  ChangeUserActivityUseCase changeUserActivityUseCase;
  UpdateUserLocationUseCase updateUserLocationUseCase;
  GetNearestDriversUseCase getNearestDriversUseCase;

  LocationService({
    required this.changeUserActivityUseCase,
    required this.updateUserLocationUseCase,
    required this.getNearestDriversUseCase,
  });

  late GoogleMapController controllerGoogleMap;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  static LocationService get to => Get.find();

  Rx<Position?> customerLocation = Rx(null);
  Rx<bool> locationEnabled = Rx(false);

  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  Rx<Set<Marker>> markers = Rx({});

  late CameraPosition initialDriverPosition = CameraPosition(
    target: LatLng(
      customerLocation.value?.latitude ?? 0,
      customerLocation.value?.longitude ?? 0,
    ),
    zoom: 16,
  );

  late Set<Polyline> polyLines = {
    const Polyline(
      geodesic: true,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      polylineId: PolylineId("route"),
      points: [],
      color: Color(0xFF7B61FF),
    ),
  };

  Future<LocationService> init() async {
    await _listenToLocationStatus();

    return this;
  }

  int counter = 10;
  late Timer timer;
  startResendTimerCountDown() {
    counter = 10;

    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (counter == 0) {
          print("========================>");
          getNearestDrivers(true);
        } else {
          counter--;
        }
      },
    );
  }

  List<NearestDriver> nearestDrivers = [];
  Future<void> getNearestDrivers(bool timerActive) async {
    if (timerActive) {
      timer.cancel();
    }
    if (Get.currentRoute == Routes.currentOrder) {
      return;
    }
    final result = await getNearestDriversUseCase(
      lat: LocationsController
          .to.locations[LocationsController.to.indexAddress].lat,
      long: LocationsController
          .to.locations[LocationsController.to.indexAddress].long,
    );

    result.fold((failure) {}, (result) async {
      nearestDrivers = result;
      addCustomerMarkWithNearestDrivers(
        userLatLng: LatLng(
          double.parse(LocationsController
              .to.locations[LocationsController.to.indexAddress].lat),
          double.parse(LocationsController
              .to.locations[LocationsController.to.indexAddress].long),
        ),
      );

      startResendTimerCountDown();
    });
  }

  Future<void> _getStreamLocation() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    customerLocation.value = await geolocatorPlatform.getCurrentPosition(
        locationSettings: locationSettings);

    final positionStream = geolocatorPlatform.getPositionStream(
        locationSettings: locationSettings);

    _positionStreamSubscription = positionStream.handleError((error) async {
      _listenToLocationStatus();
    }).listen((position) async {
      customerLocation.value = position;
      centerCustomerLocation(
        location: LatLng(
          position.latitude,
          position.longitude,
        ),
      );
    });
  }

  Stream<ServiceStatus> listenToLocationStreamAvailability() =>
      geolocatorPlatform.getServiceStatusStream();

  centerCustomerLocation({required LatLng location}) {
    if (controller.isCompleted) {
      controller.future
          .then((value) => value.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                location.latitude,
                location.longitude,
              ),
              16)));
    }
  }

  resetLocation() {
    bound = null;
    addCustomerMarkWithNearestDrivers(
      userLatLng: LatLng(
          customerLocation.value!.latitude, customerLocation.value!.longitude),
    );
    centerCustomerLocation(
      location: LatLng(
          customerLocation.value!.latitude, customerLocation.value!.longitude),
    );
  }

  showLocationError() {
    ToastManager.showError(LocaleKeys.enableLocation.tr);
  }

  Future<void> determinePosition() async {
    try {
      LocationPermission permission;

      permission = await geolocatorPlatform.checkPermission();

      if (permission == LocationPermission.denied||permission == LocationPermission.deniedForever) {

        permission = await geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          showLocationError();
          return;
        } else {
          customerLocation.value =
              await geolocatorPlatform.getCurrentPosition();
        }
      } else {
        print("locations====>( ${permission})");

        customerLocation.value = await geolocatorPlatform.getCurrentPosition();
        print("locationsss====>( ${customerLocation.value} )");
        addCustomerMarkWithNearestDrivers(
          userLatLng: LatLng(customerLocation.value!.latitude,
              customerLocation.value!.longitude),
        );
        if (controller.isCompleted) {
          centerCustomerLocation(
            location: LatLng(customerLocation.value!.latitude,
                customerLocation.value!.longitude),
          );
        }
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      // await _getStreamLocation();
    } catch (error) {
      rethrow;
    }
  }

  _listenToLocationStatus() async {
    print("locationsss====>1");
    if (await geolocatorPlatform.isLocationServiceEnabled()) {
      locationEnabled.value = true;

      await determinePosition();
    }
    listenToLocationStreamAvailability().listen((event) async {
      if (ServiceStatus.enabled == event) {
        print("locationsss====>2");
        locationEnabled.value = true;

        customerLocation.value = await geolocatorPlatform.getCurrentPosition();

        await determinePosition();
      } else {
        locationEnabled.value = false;
        _positionStreamSubscription!.cancel();
        markers.value = {};
      }
    });
  }

  addCustomerMarkWithNearestDrivers({required LatLng userLatLng}) async {
    var test = [];
    for (var nearestDriver in nearestDrivers) {
      test.add(
        Marker(
          // given marker id
          markerId: MarkerId(nearestDriver.lat),
          rotation: 0,

          // given marker icon
          icon: BitmapDescriptor.fromBytes(
            await Utils.getBytesFromAsset(
              Assets.carIc,
              width: 100,
              height: 160,
            ),
          ),

          // given position
          position: LatLng(
            double.parse(nearestDriver.lat),
            double.parse(nearestDriver.long),
          ),

          flat: true,
        ),
      );
    }

    markers.value = {};
    markers.value = {
      ...test,
      Marker(
        // given marker id
        markerId: const MarkerId('0'),
        rotation: 0,

        // given marker icon
        icon: BitmapDescriptor.fromBytes(
          await Utils.getBytesFromAsset(
            Assets.locations,
            width: 250,
            height: 125,
          ),
        ),

        // given position
        position: LatLng(
          userLatLng.latitude,
          userLatLng.longitude,
        ),

        flat: true,
      ),
    };
  }

  addCustomerMark(
      {required LatLng userLatLng, required LatLng driverLatLng}) async {
    markers.value = {};
    markers.value = {
      Marker(
        // given marker id
        markerId: const MarkerId('customer'),
        rotation: 0,

        // given marker icon
        icon: BitmapDescriptor.fromBytes(
          await Utils.getBytesFromAsset(
            Assets.locations,
            width: 250,
            height: 125,
          ),
        ),

        // given position
        position: userLatLng,

        flat: true,
      ),
      Marker(
        // given marker id
        markerId: const MarkerId('driver'),
        rotation: 0,

        // given marker icon
        icon: BitmapDescriptor.fromBytes(
          await Utils.getBytesFromAsset(
            Assets.carIc,
            width: 100,
            height: 160,
          ),
        ),

        // given position
        position: driverLatLng,

        flat: true,
      ),
    };
  }

  LatLngBounds? bound;
  void positionCameraBetweenTwoCoords(LatLng userLatLng, LatLng driverLatLng) {
    addCustomerMark(userLatLng: userLatLng, driverLatLng: driverLatLng);

    if (userLatLng.latitude > driverLatLng.latitude &&
        userLatLng.longitude > driverLatLng.longitude) {
      bound = LatLngBounds(
        southwest: LatLng(driverLatLng.latitude, driverLatLng.longitude),
        northeast: userLatLng,
      );
    } else if (userLatLng.longitude > driverLatLng.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(userLatLng.latitude, driverLatLng.longitude),
          northeast: LatLng(driverLatLng.latitude, userLatLng.longitude));
    } else if (userLatLng.latitude > driverLatLng.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(driverLatLng.latitude, userLatLng.longitude),
          northeast: LatLng(userLatLng.latitude, driverLatLng.longitude));
    } else {
      bound = LatLngBounds(
        southwest: userLatLng,
        northeast: LatLng(driverLatLng.latitude, driverLatLng.longitude),
      );
    }

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound!, 170);

    controllerGoogleMap.animateCamera(u2);
  }
}
