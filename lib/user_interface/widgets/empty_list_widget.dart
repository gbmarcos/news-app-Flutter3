import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListWidget extends StatelessWidget {
  final String svgPath;
  final Widget text;

  const EmptyListWidget({
    Key? key,
    required this.svgPath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 160,
          width: 160,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            svgPath,
            height: 60,
            width: 60,
            color: Color(0xFFD1D5DB),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F3F5),
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
        text,
      ],
    );
  }
}
