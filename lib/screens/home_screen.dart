import 'package:contact/core/app_colors.dart';
import 'package:contact/core/app_images.dart';
import 'package:contact/models/user_model.dart';
import 'package:contact/widgets/add_user_bottom_sheet.dart';
import 'package:contact/widgets/user_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<UserModel> users = [];

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => AddUserBottomSheet(
        onSubmit: (user) => setState(() => users.add(user)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            AppImages.logo,
            height: 40,
          ),
        ),
      ),
      body: users.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImages.emptyContacts,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'There is No Contacts Added Here',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 160),
                itemCount: users.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) => UserCard(
                  user: users[index],
                  onDelete: () => setState(
                    () => users.removeAt(index),
                  ),
                ),
              ),
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (users.isNotEmpty)
            FloatingActionButton(
              heroTag: 'delete_last',
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.white,
              shape: const CircleBorder(),
              onPressed: () => setState(() => users.removeLast()),
              child: const Icon(Icons.delete),
            ),
          if (users.isNotEmpty && users.length < 6) const SizedBox(height: 16),
          if (users.length < 6)
            FloatingActionButton(
              heroTag: 'add_user',
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.darkBlue,
              onPressed: _showAddSheet,
              child: const Icon(Icons.add),
            ),
        ],
      ),
    );
  }
}
