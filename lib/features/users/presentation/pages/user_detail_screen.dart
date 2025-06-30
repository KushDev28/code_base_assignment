import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/user_entity.dart';
import '../widgets/custom_network_image.dart';

///User Detail Screen
class UserDetailScreen extends StatelessWidget {
  final UserEntity user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.fullName,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: user.avatar,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                user.fullName,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'email : ${user.email}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
