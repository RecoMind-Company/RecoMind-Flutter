import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/data/dep_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/data/dep_repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/widget/List.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/widget/add_Table.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/widget/bar.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/widget/check.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/gradient_circular_loading.dart';

class Dapartment2Verification extends StatefulWidget {
  final String departmentName;
  final int currentDepartmentIndex;
  final int totalDepartmentsCount;
  final VoidCallback onVerificationComplete;

  const Dapartment2Verification({
    super.key,
    required this.departmentName,
    required this.currentDepartmentIndex,
    required this.totalDepartmentsCount,
    required this.onVerificationComplete,
  });

  @override
  State<Dapartment2Verification> createState() => _Dapartment2VerificationState();
}

class _Dapartment2VerificationState extends State<Dapartment2Verification> {
  final MappingReviewRepo _reviewRepo = MappingReviewRepo();

  List<MappingReviewModel> _reviews = [];
  bool _isLoading = true;
  bool ischecked = false;

  final Set<int> _selectedTableIds = <int>{};

  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _loadReviews();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        if (!_showScrollToTopButton) {
          setState(() => _showScrollToTopButton = true);
        }
      } else {
        if (_showScrollToTopButton) {
          setState(() => _showScrollToTopButton = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadReviews() async {
    try {
      final result = await _reviewRepo.getDepartmentReviews(widget.departmentName);
      if (mounted) {
        setState(() {
          _reviews = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // يظهر زر الحذف لو الـ Select All متفعل أو فيه عناصر مختارة يدوياً
    final bool showDeleteButton = ischecked || _selectedTableIds.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: Stack(
        children: [
          Column(
            children: [
              const Gap(60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(CupertinoIcons.back, color: Colors.white, size: 35),
                    ),
                    const Gap(20.5),
                    Expanded(
                      child: customText(
                        text: "${widget.departmentName} Tables",
                        color: Colors.white,
                        fontweight: FontWeight.w400,
                        textsize: 26,
                      ),
                    ),
                  ],
                ),
              ),

              Bar(
                reviewedCount: widget.currentDepartmentIndex,
                totalCount: widget.totalDepartmentsCount,
              ),

              const Gap(41),
              Check(
                ontap: () {
                  setState(() {
                    ischecked = !ischecked;
                    if (ischecked) {
                      // عند اختيار الكل، بنضيف كل الـ IDs الحقيقية المتاحة في القائمة للـ Set
                      for (var item in _reviews) {
                        if (item.id != null) _selectedTableIds.add(item.id!);
                      }
                    } else {
                      _selectedTableIds.clear();
                    }
                  });
                },
                color: ischecked ? Colors.redAccent : const Color(0xFFE1F4FF),
              ),

              const Gap(10),

              _isLoading
                  ? const Expanded(
                child: Center(
                  child: SwappedShrinkingLoading(size: 40, strokeWidth: 2),
                ),
              )
                  : Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 200),
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    final item = _reviews[index];
                    final int tableId = item.id ?? -1;

                    return Listwid(
                      selectall: ischecked,
                      tableName: item.name ?? "Unknown Table",
                      tableDesc: item.description ?? "No Description",
                      isSelected: _selectedTableIds.contains(tableId),
                      onSelectedChanged: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedTableIds.add(tableId);
                          } else {
                            _selectedTableIds.remove(tableId);
                            if (ischecked) ischecked = false; // لو شال علامة من عنصر، يلغي الـ Select All برة
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // أزرار التحكم الطائرة (Floating Actions)
          Positioned(
            bottom: 150,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AddTableBottomSheet(
                        departmentName: widget.departmentName,
                        onDataRefreshed: (List<MappingReviewModel> updatedReviews) {
                          setState(() {
                            _reviews = updatedReviews;
                            _selectedTableIds.clear();
                            ischecked = false;
                          });
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF63D8E4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.black, size: 30),
                        Gap(5),
                        Text("Add Table", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
                      ],
                    ),
                  ),
                ),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _showScrollToTopButton ? 1.0 : 0.0,
                  child: GestureDetector(
                    onTap: _showScrollToTopButton
                        ? () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color(0xFF63D8E4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_upward, color: Colors.black, size: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
            color: const Color(0xFF060B1B),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showDeleteButton
                  ? GestureDetector(
                onTap: () => _showDeleteDialog(context),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F404D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Color(0xFFFF5E5E), size: 20),
                      Gap(8),
                      Text("Delete", style: TextStyle(color: Color(0xFFFF5E5E), fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
                  : GestureDetector(
                onTap: () {
                  widget.onVerificationComplete();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F404D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Continue to Departments",
                    style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        bool isDeletingInside = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: const Color(0xFF0C1224),
              // لون الخلفية الداكن المطابق للشاشة
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    16), // حواف دائرية ناعمة حسب التصميم
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 28.0),
                child: isDeletingInside
                    ? const SizedBox(
                  height: 150,
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF5E5E)),
                  ),
                )
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // العنوان الرئيسي
                    Text(
                      "You are about to remove ${_selectedTableIds
                          .length} tables\nfrom ${widget
                          .departmentName} department",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const Gap(12),


                    const Text(
                      "Are you sure you want to delete selected tables?\nThis action only unassigns them and does NOT\ndelete data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7E8494),

                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const Gap(24),


                    GestureDetector(
                      onTap: () async {
                        setDialogState(() => isDeletingInside = true);

                        // استدعاء الـ API بالترتيب الجديد والمجرب للـ Service بالملي
                        final bool success = await _reviewRepo
                            .deleteTablesFromDepartment(
                          companyId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                          // غيرها للـ ID الحقيقي لو محتاج
                          deptName: widget.departmentName,
                          tableIds: _selectedTableIds.toList(),
                        );

                        if (success) {
                          await _loadReviews(); // إعادة سحب البيانات لتحديث الشاشة فوراً
                          if (mounted) {
                            setState(() {
                              _selectedTableIds.clear();
                              ischecked = false;
                            });
                          }
                          Navigator.pop(dialogContext); // قفل الـ Dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Tables removed successfully! 🗑️"),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else {
                          setDialogState(() => isDeletingInside = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Failed to remove tables. Please try again."),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF232A3E),
                          // لون الزرار الداكن حسب الصورة
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete, color: Color(0xFFFF5E5E),
                                size: 20),
                            Gap(8),
                            Text(
                              "Delete Anyway",
                              style: TextStyle(
                                color: Color(0xFFFF5E5E), // نص أحمر
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(16),

                    // زر الـ Cancel
                    GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}