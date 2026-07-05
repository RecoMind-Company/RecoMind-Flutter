import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Repo.dart';
import 'company_setup_3_state.dart';
class CompanySetup3Cubit extends Cubit<CompanySetup3State> {
  final TeamRepo teamRepo;

  CompanySetup3Cubit(this.teamRepo)
      : super(CompanySetup3Initial());

  final List<TeamNameModel> _teams = [];

  Future<void> getTeams() async {
    try {
      emit(CompanySetup3Loading()); // أضف حالة التحميل عشان الشاشة ما تضربش وهي فاضية
      final teams = await teamRepo.getTeamNames();

      _teams.clear();
      if (teams != null) {
        _teams.addAll(teams);
      }

      emit(CompanySetup3Success(List.from(_teams)));
    } catch (e) {
      // لو حصل خطأ في التحويل (زي اللي في الصور)، هيظهر SnackBar بدل ما الصفحة تقفل
      emit(CompanySetup3Error(e.toString()));
    }
  }
  Future<void> addTeam(String name) async {
    try {
      final newTeam = await teamRepo.addTeam(
        AddTeam(name: name),
      );

      _teams.add(newTeam);
      emit(CompanySetup3Success(List.from(_teams)));
    } catch (e) {
      emit(CompanySetup3Error(e.toString()));
    }
  }




  Future<void> deleteTeam(String id) async {
    try {
      await teamRepo.delete(id);

      _teams.removeWhere((team) => team.id == id);
      emit(CompanySetup3Success(List.from(_teams)));
    } catch (e) {
      emit(CompanySetup3Error("Failed to delete department"));
    }
  }

}
