class UserModel {
  UserModel({required this.employeeId});
  dynamic employeeId;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(employeeId: json['Employee Id']
        // srNo: json['srNo'],
        // date: json['Date'],
        // owner: json['Owner'],
        // migrateAction: json['MigratingRisk'],
        // progressAction: json['ProgressionAction'],
        // riskDescription: json['RiskDescription'],
        // reason: json['Reason'],
        // status: json['Status'],
        // TargetDate: json['TargetDate'],
        // typeRisk: json['TypeRisk'],
        // impactRisk: json['impactRisk'],
        // contigentAction: json['ContigentAction']);
        );
  }
}
