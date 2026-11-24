import 'package:contact/core/app_colors.dart';
import 'package:contact/models/user_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onDelete;

  const UserCard({super.key, required this.user, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nameStyle =
        textTheme.titleMedium!.copyWith(color: AppColors.darkBlue);
    final infoStyle = textTheme.bodySmall!.copyWith(color: AppColors.darkBlue);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                child: user.image == null
                    ? const ColoredBox(
                        color: AppColors.lightBlue,
                        child: Icon(Icons.person,
                            size: 48, color: AppColors.darkBlue),
                      )
                    : Image.file(user.image!, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(user.name,
                style: nameStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.email, size: 14, color: AppColors.darkBlue),
              const SizedBox(width: 4),
              Expanded(
                child: Text(user.email,
                    style: infoStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.phone, size: 14, color: AppColors.darkBlue),
              const SizedBox(width: 4),
              Expanded(
                child: Text(user.phone,
                    style: infoStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                textStyle: const TextStyle(fontSize: 12),
              ),
              icon: const Icon(Icons.delete, size: 14),
              label: const Text('Delete'),
            ),
          ),
        ],
      ),
    );
  }
}
