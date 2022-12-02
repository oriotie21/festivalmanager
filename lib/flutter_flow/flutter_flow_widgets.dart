import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FFButtonWidget extends StatelessWidget {
  String? text;
  FFButtonOptions? options;
  Icon? icon;
  void Function()? onPressed;

  @override
  FFButtonWidget({
    this.text,
    this.icon,
    this.options,
    required this.onPressed,
  });

  Widget build(BuildContext context) {
    // TODO: implement build

    return SizedBox(
        width: options?.width,
        height: options?.height,
        child:
          icon == null ?
    TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(options?.color),
            elevation: MaterialStatePropertyAll(options?.elevation),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: options!.borderRadius,

                )
            )
        ),
        onPressed: onPressed,

        child: Text(
          text.toString(),
          style: options?.textStyle,
        )) :
        IconButton(
            style: ButtonStyle(
                elevation: MaterialStatePropertyAll(options?.elevation),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: options!.borderRadius,

                    )
                )
            ),
            onPressed: onPressed,

            icon: this.icon!,
         ),

        );
  }
}

class FFButtonOptions extends StatelessWidget {
  double? width;
  double? height;
  Color? color;
  TextStyle? textStyle;
  BorderSide? borderSide;
  double? elevation;
  BorderRadiusGeometry borderRadius;

  FFButtonOptions({
    this.width,
    this.height,
    this.color,
    this.textStyle,
    this.borderSide,
    this.elevation,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
