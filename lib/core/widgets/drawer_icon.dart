import 'package:flutter/material.dart';
import 'package:otlobgas_driver/features/auth_feature/presentation/main_layout/controllers/main_layout_controller.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            MainLayoutController.to.scaffoldKey.currentState!.openDrawer(),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.white)),
          child: GestureDetector(
            onTap: () =>
                MainLayoutController.to.scaffoldKey.currentState!.openDrawer(),
            child: const Icon(
              Icons.list,
            ),
          ),
        ));
  }
}
