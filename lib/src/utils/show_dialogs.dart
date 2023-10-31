import 'package:flutter/material.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';

import '../constants/colors_const.dart';
import '../widgets/big_text_widget.dart';
import '../widgets/small_text.dart';

void errorMessage(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            insetPadding: const EdgeInsets.only(left: 20, right: 20),
            backgroundColor: Colors.white,
            child: StatefulBuilder(builder: (contex, dialogSetState) {
              return  SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pop(false);
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(right: 8.0, top: 8),
                            child: Icon(Icons.cancel,
                                color: ColorConst.appMainColorBak),
                          ),
                        ),
                      ],
                    ),
                     SmallText(text: "There is something wrong with you try again",
                       fontWidget: FontWeight.bold,
                       size: context.h*0.02,
                       textAlign: TextAlign.center,),
                    const SizedBox(height: 10),
                    const BigText(text: "❌",size: 60),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: ColorConst.appGreenColor,
                              disabledForegroundColor: Colors.grey.withOpacity(0.38),
                              disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop(false);
                            },
                            child: const BigText(
                              text: "Ok",
                              fontWidget: FontWeight.bold,
                              size: 16,
                            )
                        ),
                        SizedBox(height: context.h*0.02),
                      ],),
                    )
                  ],
                ),
                // child:
              );
            }),
          ),
        );
      });
}