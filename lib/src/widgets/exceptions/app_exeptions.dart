import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import '../../constants/colors_const.dart';
import '../big_text_widget.dart';
import '../small_text.dart';

class AppExceptionsWidget extends StatelessWidget {
  final String message;
  final String authName;
  const AppExceptionsWidget({
    super.key,
    required this.message,
    required this.authName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          alignment: AlignmentDirectional.center,
          child: Lottie.asset('assets/internet_error.json'),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 8),
          child: SmallText(
              text: message,
              size: 18,
              fontWidget: FontWeight.w600,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: ColorConst.appBackgroundColor, disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(authName);
          },
          child: SizedBox(
            width: context.w * 0.8,
            height: context.h * 0.06,
            child: Center(
              child: BigText(
                text: "Exception",
                fontWidget: FontWeight.bold,
                color: ColorConst.appWhiteColor,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
