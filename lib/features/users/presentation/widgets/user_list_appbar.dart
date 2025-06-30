import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class UserListAppBar extends StatelessWidget {
  const UserListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      floating: true,
      pinned: true,
      snap: true,
      expandedHeight: 100,
      flexibleSpace: const FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
        title: Text('Users',style: TextStyle(color: AppColors.background),),
      ),
    );
  }
}
