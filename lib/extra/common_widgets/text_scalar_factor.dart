import 'package:flutter/cupertino.dart';

class TextScaleFactorClamper extends StatelessWidget {
  const TextScaleFactorClamper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
          textScaleFactor: data.textScaleFactor > 1.0 ? 1.1 : data.textScaleFactor),
      child: child,
    );
  }
}

class DeviceTypeValues {
  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}
