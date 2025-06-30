import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/constants/app_colors.dart';

class UserListShimmer extends StatelessWidget {
  const UserListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.shimmerBase;
    final highlightColor = AppColors.shimmerHighlight;

    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primary),
        body: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemBuilder: (context, index) {
            return Shimmer(
              duration: const Duration(milliseconds: 1200),
              interval: const Duration(milliseconds: 500),
              color: highlightColor,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: baseColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title line
                            Container(
                              height: 14,
                              width: double.infinity,
                              color: baseColor,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.4,
                              color: baseColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
