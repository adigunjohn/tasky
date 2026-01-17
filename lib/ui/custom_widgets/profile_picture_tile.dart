import 'package:flutter/material.dart';
import 'package:tasky/ui/common/app_colours.dart';

class ProfilePictureTile extends StatelessWidget {
  const ProfilePictureTile({super.key, required this.height, required this.profilePicture});
  final String? profilePicture;
  final double height;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardColor,
        image: profilePicture != '' && profilePicture != null ? DecorationImage(image: AssetImage(profilePicture!), fit: BoxFit.cover) : null,
      ),
      child: profilePicture == '' || profilePicture == null ? Icon(
        Icons.person,
        size: height * 0.6,
        color: AppColours.grey400Color,
      ) : null,
    );
  }
}
