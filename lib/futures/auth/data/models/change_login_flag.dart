class ChangeLoginFlagModel {
  final String massege;

  ChangeLoginFlagModel({required this.massege});
factory ChangeLoginFlagModel.fromJson(Map<String, dynamic> json) {
    return ChangeLoginFlagModel(
     massege: json["message"]
    );
 }
 Map<String, dynamic> toJson() {
    return {
     'message': massege, 
    };
 }
}
