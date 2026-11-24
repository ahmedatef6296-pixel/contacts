import 'dart:io';
import 'package:contact/core/app_colors.dart';
import 'package:contact/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_text_field.dart';

class AddUserBottomSheet extends StatefulWidget {
  final void Function(UserModel user) onSubmit;

  const AddUserBottomSheet({super.key, required this.onSubmit});

  @override
  State<AddUserBottomSheet> createState() => _AddUserBottomSheetState();
}

class _AddUserBottomSheetState extends State<AddUserBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  File? _image;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  String? _required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      UserModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        image: _image,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: AppColors.gold,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: _image == null
                            ? Image.asset(
                                'assets/images/image_email.png',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'User Name',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(
                          color: AppColors.gold,
                          thickness: 1,
                        ),
                        const Text(
                          'example@email.com',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 13,
                          ),
                        ),
                        const Divider(
                          color: AppColors.gold,
                          thickness: 1,
                        ),
                        const Text(
                          '+200000000000',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _nameController,
                hint: 'Enter User Name',
                validator: (context) =>
                    _required(context, 'Please enter user name'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                hint: 'Enter User Email',
                keyboardType: TextInputType.emailAddress,
                validator: (context) =>
                    _required(context, 'Please enter user email'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                hint: 'Enter User Phone',
                keyboardType: TextInputType.phone,
                validator: (context) =>
                    _required(context, 'Please enter user phone'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Enter user'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
