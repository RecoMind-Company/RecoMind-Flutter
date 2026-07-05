import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/bloc/cubit.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/data/dep_model.dart';

class AddTableBottomSheet extends StatelessWidget {
  final String departmentName;
  final Function(List<MappingReviewModel>) onDataRefreshed;

  const AddTableBottomSheet({
    super.key,
    required this.departmentName,
    required this.onDataRefreshed,
  });

  @override
  Widget build(BuildContext context) {
    // توفير الـ Cubit مباشرة لنطاق الـ Bottom Sheet واستدعاء الداتا فوراً
    return BlocProvider(
      create: (context) => MappingCubit()..fetchTables(departmentName),
      child: BlocConsumer<MappingCubit, MappingState>(
        listener: (context, state) {
          if (state is MappingSuccess) {
            // 🔄 نمرر البيانات الجديدة للشاشة الخارجية وتُقفل علطول
            onDataRefreshed(state.updatedReviews);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Tables added and verified successfully! 🎉"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is MappingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<MappingCubit>();

          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0C1121),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const Gap(12),
                Container(width: 60, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(2))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // 🔍 حقل البحث
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(color: const Color(0xFF192033), borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => cubit.updateFilters(searchQuery: value),
                      decoration: const InputDecoration(
                        hintText: "Search With a table to add",
                        hintStyle: TextStyle(color: Color(0xFF6C7281), fontSize: 15),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF6C7281)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const Gap(20),

                // 🗂️ الـ Filter Tabs والـ List View
                if (state is MappingLoading || state is MappingInitial)
                  const Expanded(child: Center(child: CircularProgressIndicator(color: Color(0xFF63D8E4))))
                else if (state is MappingLoaded) ...[
                  // الـ Tabs
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == state.selectedCategoryIndex;
                        return GestureDetector(
                          onTap: () => cubit.updateFilters(categoryIndex: index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.transparent : const Color(0xFF192033),
                              border: isSelected ? Border.all(color: const Color(0xFF51D9FF), width: 1.5) : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              state.categories[index],
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF51D9FF) : Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(15),

                  // قائمة الجداول
                  Expanded(
                    child: state.filteredTables.isEmpty
                        ? const Center(child: Text("No tables found", style: TextStyle(color: Colors.white54)))
                        : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.filteredTables.length,
                      itemBuilder: (context, index) {
                        final table = state.filteredTables[index];
                        final isChecked = state.selectedTableIds.contains(table.id);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: const Color(0xFF131A2E), borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(table.name ?? "Unknown Table", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                    const Gap(4),
                                    Text("Table Description", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
                                    const Gap(6),
                                    Text(table.description ?? "No Description provided.", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, height: 1.4)),
                                  ],
                                ),
                              ),
                              const Gap(12),
                              // الـ Checkbox التفاعلي المرسل للـ Cubit
                              GestureDetector(
                                onTap: () => cubit.toggleTableSelection(table.id ?? -1),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: isChecked ? const Color(0xFF63D8E4) : Colors.transparent,
                                    border: Border.all(color: isChecked ? const Color(0xFF63D8E4) : Colors.white.withOpacity(0.4), width: 2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: isChecked ? const Icon(Icons.check, color: Colors.black, size: 16) : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // 🔘 زرار الـ Add التفاعلي الذكي
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: state.selectedTableIds.isEmpty || state.isSaving
                          ? null
                          : () => cubit.addTables(departmentName),
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: state.selectedTableIds.isEmpty ? const Color(0xFF2C303D) : const Color(0xFF63D8E4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: state.isSaving
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                            : Text(
                          "Add",
                          style: TextStyle(color: state.selectedTableIds.isEmpty ? Colors.white38 : Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ] else
                  const Expanded(child: Center(child: Text("Something went wrong", style: TextStyle(color: Colors.white54)))),
              ],
            ),
          );
        },
      ),
    );
  }
}