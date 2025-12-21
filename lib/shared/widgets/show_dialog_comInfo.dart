import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign up views/company setup/data/company_model.dart';
import 'package:recomind/features/auth/sign up views/company setup/data/company_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/constants/app_colors.dart';
import 'button.dart';
import 'textfiekd.dart';
import 'title_Text_Field.dart';
import '../../features/auth/sign up views/company setup/widgets/dropDown.dart';

class ShowDialogCominfo extends StatefulWidget {
  const ShowDialogCominfo({super.key, required this.ontap});
  final VoidCallback ontap;

  @override
  State<ShowDialogCominfo> createState() => _ShowDialogCominfoState();
}

class _ShowDialogCominfoState extends State<ShowDialogCominfo> {
  /// repo
  final SetupRepository authRepo = SetupRepository();
  setupModel? getSetup;
  bool isLoading = false;

  /// controllers
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// dropdown values
  late ValueNotifier<String?> industryNotifier;
  late ValueNotifier<String?> countryNotifier;
  late ValueNotifier<String?> sizeNotifier;

  @override
  void initState() {
    super.initState();

    industryNotifier = ValueNotifier("Marketing");
    countryNotifier = ValueNotifier("Egypt");
    sizeNotifier = ValueNotifier("200-500");

    getSetupData();
  }

  /// get setup data
  Future<void> getSetupData() async {
    try {
      final user = await authRepo.getSetup();
      if (!mounted) return;

      setState(() {
        getSetup = user;

        industryNotifier.value = user.industry;
        countryNotifier.value = user.country;
        sizeNotifier.value = user.size;

        // ✅ TextFields فقط
        _websiteController.text = user.code ?? "";
        _descriptionController.text = user.description ?? "";
      });
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  /// update data
  Future<void> updateData() async {
    try {
      setState(() => isLoading = true);

      await authRepo.updateCompanyAndRefresh(
        getSetup?.name ?? "",
        _industryController.text.isNotEmpty
            ? _industryController.text.trim()
            : getSetup!.industry!,
        _countryController.text.isNotEmpty
            ? _countryController.text.trim()
            : getSetup!.country!,
        _sizeController.text.isNotEmpty
            ? _sizeController.text.trim()
            : getSetup!.size!,
        _websiteController.text.trim(),
        _descriptionController.text.trim(),
        getSetup?.id ?? "",
      );

      if (!mounted) return;
      widget.ontap();
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: getSetup == null,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(.2),
          child: Column(
            children: [
              const Gap(200),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  decoration: const BoxDecoration(
                    color: Color(0xFF060B1B),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(20),
                        Container(
                          width: 150,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: widget.ontap,
                            icon: const Icon(CupertinoIcons.xmark,
                                color: Colors.white),
                          ),
                        ),

                        /// Business Industry
                        const TitleTextField(text: "Business Industry"),
                        Dropdown(
                          controller: _industryController,
                          items: const ["Marketing", "Sales", "IT", "HR"],
                          selectedItem: industryNotifier,
                          hints: "EX : Marketing",
                        ),
                        const Gap(16),

                        /// Country
                        const TitleTextField(text: "Country"),
                        Dropdown(
                          controller: _countryController,
                          items: const ["Egypt", "USA", "Qatar", "Japan"],
                          selectedItem: countryNotifier,
                          hints: "Search Country",
                        ),
                        const Gap(16),

                        /// Company Size
                        const TitleTextField(text: "Company Size"),
                        Dropdown(
                          controller: _sizeController,
                          items: const ["50-100", "100-200", "200-500"],
                          selectedItem: sizeNotifier,
                          hints: "200-500",
                        ),
                        const Gap(16),

                        /// Website
                        const TitleTextField(text: "Company Website"),
                        textfield(
                          hint: "https://company.org",
                          controller: _websiteController,
                        ),
                        const Gap(16),

                        /// Description
                        const TitleTextField(text: "Business Description"),
                        const Gap(4),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 5,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText:
                            "Describe your company’s purpose, services, and goals…",
                            hintStyle:
                            const TextStyle(color: Color(0xFFB8ADAD)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            )
                          ),
                        ),

                        const Gap(30),
                        button(
                          onPressed: (){
                            updateData();
                          },
                          color: AppColor.primaryColor,
                          borderColor: AppColor.primaryColor,
                          buttonText:
                          isLoading ? "Saving..." : "Save",
                          textColor: Colors.black,
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
