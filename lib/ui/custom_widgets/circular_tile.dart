import 'package:flutter/material.dart';
import 'package:tasky/ui/common/app_colours.dart';
import 'package:tasky/ui/common/app_sizes.dart';

class CircularTile extends StatelessWidget {
  const CircularTile({super.key, required this.icon, this.onTap, this.color});
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color:AppColours.greyColor,width: 1),
        ),
        child: Center(child: Icon(icon, color: color ?? Theme.of(context).iconTheme.color, size: AppSizes.circularTileIconSize,),),
      ),
    );
  }
}
