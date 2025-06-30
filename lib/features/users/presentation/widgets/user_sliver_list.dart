import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../pages/user_detail_screen.dart';
import 'custom_network_image.dart';

class UserListSliver extends StatelessWidget {
  final List<UserEntity> users;

  const UserListSliver({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserDetailScreen(user: user),
                  ),
                );
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: user.avatar,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              title: Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                user.email,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
            ),
          );
        },
        childCount: users.length,
      ),
    );
  }
}
