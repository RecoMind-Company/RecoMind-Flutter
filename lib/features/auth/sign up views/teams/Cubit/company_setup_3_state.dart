import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';

abstract class CompanySetup3State {}

class CompanySetup3Initial extends CompanySetup3State {}

class CompanySetup3Loading extends CompanySetup3State {}

class CompanySetup3Success extends CompanySetup3State {
  final List<TeamNameModel> teams;
  CompanySetup3Success(this.teams);
}

class CompanySetup3Error extends CompanySetup3State {
  final String message;
  CompanySetup3Error(this.message);
}
