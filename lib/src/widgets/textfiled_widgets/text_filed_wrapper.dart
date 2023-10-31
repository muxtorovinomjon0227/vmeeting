import 'package:flutter/material.dart';

class TextFieldWrapper extends StatefulWidget {
  final String label;
  final TextFormField child;
  final FocusNode focusNode;
  final Color color;
  final double borderRadius;

  const TextFieldWrapper({
    Key? key,
    required this.label,
    required this.child,
    required this.focusNode,
    required this.color,
    required this.borderRadius,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldWrapperState createState() => _TextFieldWrapperState();
}

class _TextFieldWrapperState extends State<TextFieldWrapper> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var decorationTheme = Theme.of(context).inputDecorationTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: widget.focusNode.hasFocus
                  ? decorationTheme.copyWith(
                      errorStyle: const TextStyle(
                        fontSize: 0,
                        height: 0,
                      ),
                    )
                  : decorationTheme,
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
