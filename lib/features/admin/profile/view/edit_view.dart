import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/admin/profile/data/profile_repo.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import '../data/profile_model.dart';

class EditView extends StatefulWidget {
  final UserProfileModel? initialProfile;

  const EditView({super.key, this.initialProfile});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _jobTitleController;

  File? _selectedImage;
  bool _isLoading = false;
  final ProfileRepository _repository = ProfileRepository();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialProfile?.name ?? "");
    _emailController = TextEditingController(text: widget.initialProfile?.email ?? "");
    _phoneController = TextEditingController(text: widget.initialProfile?.phone ?? "");
    _jobTitleController = TextEditingController(text: widget.initialProfile?.jobTitle ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final request = UpdateProfileRequest(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        jobTitle: _jobTitleController.text.trim(),
        photo: _selectedImage,
      );

      final success = await _repository.updateProfile(request);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully"), backgroundColor: Colors.green),
        );
        Navigator.pop(context, true);
      }
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: _isLoading
          ? const Center(child:SwappedShrinkingLoading(size: 50,strokeWidth: 5,))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              const Gap(70),
              Row(
                children: [
                  const Gap(5),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 35,
                      )),
                  const Gap(25),
                  customText(
                    text: "Edit Personal data",
                    color: Colors.white,
                    fontweight: FontWeight.w400,
                    textsize: 28,
                  )
                ],
              ),
              const Gap(32),

              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: const Color(0xFF151B29),
                    backgroundImage: AssetImage("assets/Team_Leader/home/Ellipse 79 (1).png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFFB5B5B5),
                        radius: 25,
                        child: Icon(
                          FontAwesomeIcons.pencil,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(32),

              textfield(
                hint: "Name",
                controller: _nameController,
                icon: FontAwesomeIcons.pen,
              ),
              const Gap(16),

              textfield(
                hint: "Job Title",
                controller: _jobTitleController,
                icon: Icons.work_outline,
              ),
              const Gap(16),

              textfield(
                hint: "Email",
                controller: _emailController,
                icon: Icons.email_outlined,
              ),
              const Gap(16),

              textfield(
                hint: "Phone",
                controller: _phoneController,
                icon: CupertinoIcons.phone,
              ),
              const Gap(32),

              button(
                onPressed: _saveChanges,
                color: AppColor.primaryColor,
                borderColor: AppColor.primaryColor,
                buttonText: "Save Changes",
                textColor: Colors.black,
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}