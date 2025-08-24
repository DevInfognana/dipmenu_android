import 'package:flutter/cupertino.dart';

// class TextScaleFactorClamper extends StatelessWidget {
//   const TextScaleFactorClamper({required this.child});
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     final MediaQueryData data = MediaQuery.of(context);
//     return MediaQuery(
//       data: data.copyWith(
//           textScaleFactor: data.textScaleFactor > 0.8 ? 1.1 : data.textScaleFactor),
//       child: child,
//     );
//   }
// }


class delayFunction extends StatefulWidget {
  const delayFunction({super.key, required this.child});
  final Widget child;

  @override
  State<delayFunction> createState() => _delayFunctionState();
}



class _delayFunctionState extends State<delayFunction> {
  bool isLoading=false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = true;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
          textScaleFactor: data.textScaleFactor > 0.8 ? 1.1 : data.textScaleFactor),
      child: widget.child,
    );
  }
}
