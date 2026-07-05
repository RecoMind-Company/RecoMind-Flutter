import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/data/dep_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/department_verification/data/dep_repo.dart';

// --- H STATES ---
abstract class MappingState {}

class MappingInitial extends MappingState {}
class MappingLoading extends MappingState {}
class MappingLoaded extends MappingState {
  final List<AvailableTableModel> filteredTables;
  final List<String> categories;
  final int selectedCategoryIndex;
  final Set<int> selectedTableIds;
  final bool isSaving;

  MappingLoaded({
    required this.filteredTables,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.selectedTableIds,
    this.isSaving = false,
  });
}
class MappingSuccess extends MappingState {
  final List<MappingReviewModel> updatedReviews;
  MappingSuccess(this.updatedReviews);
}
class MappingError extends MappingState {
  final String message;
  MappingError(this.message);
}

// --- 🧠 CUBIT ---
class MappingCubit extends Cubit<MappingState> {
  final MappingReviewRepo _tableRepo = MappingReviewRepo();

  List<AvailableTableModel> _allTables = [];
  List<String> _categories = ["All"];
  int _selectedCategoryIndex = 0;
  String _searchQuery = "";
  final Set<int> _selectedTableIds = <int>{};

  MappingCubit() : super(MappingInitial());

  // 📥 جلب البيانات لأول مرة
  Future<void> fetchTables(String departmentName) async {
    emit(MappingLoading());
    try {
      _allTables = await _tableRepo.getAvailableTables(departmentName);

      final Set<String> uniqueSchemas = {"All"};
      for (var table in _allTables) {
        if (table.schemaCategory != null) uniqueSchemas.add(table.schemaCategory!);
      }
      _categories = uniqueSchemas.toList();
      _selectedTableIds.clear();

      _emitLoadedState();
    } catch (e) {
      emit(MappingError(e.toString()));
    }
  }

  // 🔍 التبديل بين الـ Tabs أو تغيير نص البحث
  void updateFilters({int? categoryIndex, String? searchQuery}) {
    if (categoryIndex != null) _selectedCategoryIndex = categoryIndex;
    if (searchQuery != null) _searchQuery = searchQuery;
    _emitLoadedState();
  }

  // ☑️ اختيار وإلغاء اختيار الجداول
  void toggleTableSelection(int tableId) {
    if (_selectedTableIds.contains(tableId)) {
      _selectedTableIds.remove(tableId);
    } else {
      _selectedTableIds.add(tableId);
    }
    _emitLoadedState();
  }

  // مساعد لإطلاق الحالة الحالية المحدثة
  void _emitLoadedState({bool isSaving = false}) {
    final filtered = _allTables.where((table) {
      final bool matchesTab = (_categories[_selectedCategoryIndex] == "All" || table.schemaCategory == _categories[_selectedCategoryIndex]);
      final bool matchesSearch = table.name!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (table.description ?? "").toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();

    emit(MappingLoaded(
      filteredTables: filtered,
      categories: _categories,
      selectedCategoryIndex: _selectedCategoryIndex,
      selectedTableIds: Set.from(_selectedTableIds),
      isSaving: isSaving,
    ));
  }

  // 🚀 تنفيذ عملية الـ POST واستدعاء الـ GET للمراجعة الخارجية
  Future<void> addTables(String departmentName) async {
    if (_selectedTableIds.isEmpty) return;

    _emitLoadedState(isSaving: true);

    try {
      final bool isSuccess = await _tableRepo.addTablesToDepartment(
        companyId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        deptName: departmentName,
        tableIds: _selectedTableIds.toList(),
      );

      if (isSuccess) {
        // سحب البيانات المحدثة فوراً لإعادتها للشاشة الرئيسية
        final updatedReviews = await _tableRepo.getDepartmentReviews(departmentName);
        emit(MappingSuccess(updatedReviews));
      } else {
        _emitLoadedState(isSaving: false);
        emit(MappingError("Failed to add tables from server."));
      }
    } catch (e) {
      _emitLoadedState(isSaving: false);
      emit(MappingError(e.toString()));
    }
  }
}