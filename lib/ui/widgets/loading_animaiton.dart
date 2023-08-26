import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../constants/colors.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 60,
      height: 60,
      child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase,
        colors: [CustomColor.blue],
      ),
    );
  }
}
