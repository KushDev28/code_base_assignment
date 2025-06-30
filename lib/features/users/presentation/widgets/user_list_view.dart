import 'package:codebase_assignment/core/constants/app_colors.dart';
import 'package:codebase_assignment/features/users/presentation/widgets/user_list_appbar.dart';
import 'package:codebase_assignment/features/users/presentation/widgets/user_list_bottom_loader.dart';
import 'package:codebase_assignment/features/users/presentation/widgets/user_searchbar.dart';
import 'package:codebase_assignment/features/users/presentation/widgets/user_sliver_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import '../notifiers/user_notifier.dart';

class UserListView extends ConsumerWidget {
  final List<UserEntity>? data;
  const UserListView({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(userSearchQueryProvider);
    final List<UserEntity>? data = this.data;
    bool isUserFound =false;
    // If data is null (e.g. API failed), show nothing or error
    if (data == null) {
      return const Center(child: Text("Something went wrong"));
    }

    // Filter users
    final filteredUsers = data
        .where((user) => user.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();


    // If filtered users are empty (due to search), show "No users found"
    if (filteredUsers.isEmpty) {
     isUserFound=true;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(userNotifierProvider.notifier).getFirstUsers();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels >=
              scrollNotification.metrics.maxScrollExtent - 200) {
            ref.read(userNotifierProvider.notifier).fetchMoreUsers();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            const UserListAppBar(),
            const UserSearchBar(),

            if (filteredUsers.isEmpty) ...[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    "User Not Found",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else ...[
              UserListSliver(users: filteredUsers),
              const UserListBottomLoader(),
            ],
          ],
        ),
      ),
    );
  }
}
