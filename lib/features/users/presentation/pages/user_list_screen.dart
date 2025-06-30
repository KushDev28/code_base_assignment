import 'package:codebase_assignment/features/users/presentation/widgets/user_list_shimmer.dart';
import 'package:codebase_assignment/features/users/presentation/widgets/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/user_notifier.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);

    return Scaffold(
      body: userAsync.when(
        data: (data) => UserListView(data: data),
        loading: () => const UserListShimmer(),
        error: (err, _) => const Center(child: Text('Something went wrong')),
      ),
    );
  }
}
