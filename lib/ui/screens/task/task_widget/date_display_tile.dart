import 'package:flutter/material.dart';
import 'package:tasky/ui/common/app_sizes.dart';

class DateDisplayTile extends StatelessWidget {
  const DateDisplayTile({super.key, required this.text, required this.date});

  final String text;
  final String date;
  @override
  Widget build(BuildContext context) {
    return  Row(
      spacing: AppSizes.space5,
      children: [
        Text(text,
          style: Theme.of(context).textTheme.headlineSmall,),
        Text(date,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall,),
      ],
    );
  }
}
