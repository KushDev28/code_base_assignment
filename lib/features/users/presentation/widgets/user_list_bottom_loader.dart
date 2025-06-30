import 'package:codebase_assignment/features/users/presentation/widgets/user_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/user_notifier.dart';

class UserListBottomLoader extends ConsumerWidget {
  const UserListBottomLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadingMore = ref.read(userNotifierProvider.notifier).isLoadingMore;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: isLoadingMore
              ?  UserListShimmer()
              : const SizedBox(height: 30),
        ),
      ),
    );
  }
}
