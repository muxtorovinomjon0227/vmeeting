import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import 'package:vmeeting/src/widgets/textfiled_widgets/text_filed_wrapper.dart';

class AuthTextFild extends StatelessWidget {
  final String lableName;
  final double borderRadius;
  final Icon? icon;
  final Widget? suffixIcon;
  final double elevation;
  final Color color;
  final TextInputType? type;
  final bool obscureText;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final dynamic Function(String?)? callback;
  const AuthTextFild(
      {Key? key,
        required this.lableName,
        this.borderRadius = 16,
        this.icon,
        this.suffixIcon,
        this.elevation = 0,
        this.color = Colors.white,
        this.type,
        this.obscureText = false,
        required this.focusNode,
        required this.textEditingController,
        this.callback,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSearchBar(context);
  }

  Widget _buildSearchBar(BuildContext context) {
    return Column(children: [
      Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.only(),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: FocusScope(
            child: Focus(
              onFocusChange: (focus) {},
              child: TextFieldWrapper(
                focusNode: focusNode,
                label: lableName,
                color: color,
                borderRadius: borderRadius,
                child: TextFormField(
                  keyboardType: type,
                  obscureText: obscureText,
                  controller: textEditingController,
                  focusNode: focusNode,
                  enabled: true,
                  onChanged: callback,
                  onFieldSubmitted: (value) {},
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(context.h*0.02),
                    prefixIcon: icon,
                    suffixIcon: suffixIcon,
                    hintText: lableName,
                    hintStyle: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey,
                    ),
                    counterStyle:  GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontStyle: FontStyle.normal,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
