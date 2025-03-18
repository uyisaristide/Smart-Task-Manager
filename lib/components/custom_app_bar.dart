import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/color_palette.dart';
import '../utils/font_sizes.dart';
import 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onBackTap;
  final bool showBackArrow;
  final Color? backgroundColor;
  final List<Widget>? actionWidgets;

  const CustomAppBar({super.key,
    required this.title,
    this.onBackTap,
    this.showBackArrow = true,
    this.backgroundColor = kWhiteColor,
    this.actionWidgets
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: showBackArrow ? IconButton(
        // icon: SvgPicture.asset('assets/svgs/back_arrow.svg'),
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (onBackTap != null) {
            onBackTap!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ) : null,
      actions: actionWidgets,
      title: Row(
        children: [
          buildText(title, kBlackColor, textMedium, FontWeight.w500,
              TextAlign.start, TextOverflow.clip),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}