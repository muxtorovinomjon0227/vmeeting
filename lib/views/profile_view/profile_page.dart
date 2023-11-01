import 'package:flutter/material.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import 'package:vmeeting/src/widgets/small_text.dart';
import '../../src/constants/colors_const.dart';
import '../../src/controllers/enter_number_cont.dart';
import '../../src/utils/app_utils.dart';
import '../../src/widgets/big_text_widget.dart';
import '../../src/widgets/image_avatar.dart';

class ProfilePage extends StatelessWidget {
  final NumberController controller;
  const ProfilePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildUI(context),
    );
  }

  Widget buildUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.w * 0.06),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.h * 0.1),
            buildImage(context),
            SizedBox(height: context.h * 0.1),
            buildDetails(context),
          ],
        ),
      )
    );
  }

  Widget buildDetails(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.h * 0.06,
          decoration: BoxDecoration(
              color: ColorConst.appBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: SmallText(
              text: AppUtils.userModel.id.toString() ?? "",
            ),
          ),
        ),
        SizedBox(height: context.h * 0.03),
        Container(
          height: context.h * 0.06,
          decoration: BoxDecoration(
              color: ColorConst.appBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: SmallText(
              text: AppUtils.userModel.fullName ?? "",
            ),
          ),
        ),
        SizedBox(height: context.h * 0.03),
        Container(
          height: context.h * 0.06,
          decoration: BoxDecoration(
              color: ColorConst.appBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: SmallText(
              text: AppUtils.userModel.email ?? "",
            ),
          ),
        ),
        SizedBox(height: context.h * 0.12),
        buildButtons(context),
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorConst.appGreenColor,
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      onPressed: () async {},
      child: SizedBox(
        width: context.w * 0.8,
        height: context.h * 0.06,
        child:  Center(
          child: BigText(
            text: "Edit Profile".toUpperCase(),
            fontWidget: FontWeight.bold,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return Center(
      child: AvatarImage(
          radius: context.h * 0.1, imagePath: 'assets/contact_avatar.png'),
    );
  }
}
