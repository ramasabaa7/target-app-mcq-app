class LoginFlagModel {
 final int id;
 final int normalLogin;
 final String createdAt;
 final String updatedAt;

 LoginFlagModel({
    required this.id,
    required this.normalLogin,
    required this.createdAt,
    required this.updatedAt,
 });

 // Factory constructor to create a UserModel from JSON
 factory LoginFlagModel.fromJson(Map<String, dynamic> json) {
    return LoginFlagModel(
      id: json['id'],
      normalLogin: json['normalLogin'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
 }

 // Method to convert UserModel to JSON
 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'normalLogin': normalLogin,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
 }
}