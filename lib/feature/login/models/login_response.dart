// lib/features/auth/models/login_response.dart
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    String? emailId;
    String? instituteId;
    String message;
    String? firstName;
    String? otp;
    String? branchId;
    String code;
    String? roleId;
    String? instituteName;
    String? roleName;
    String mobileNumber;
    String? tokenType;
    String? refreshToken;
    String? username;
    String? userId;
    String? accessToken;
    DateTime? refreshTokenExpiry;
    String? branchName;
    String? lastName;
    String? employeeId;
    DateTime? expiresAt;

    LoginResponse({
        this.emailId,
        this.instituteId,
        required this.message,
        this.firstName,
        this.otp,
        this.branchId,
        required this.code,
        this.roleId,
        this.instituteName,
        this.roleName,
        required this.mobileNumber,
        this.tokenType,
        this.refreshToken,
        this.username,
        this.userId,
        this.accessToken,
        this.refreshTokenExpiry,
        this.branchName,
        this.lastName,
        this.employeeId,
        this.expiresAt,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        emailId: json["EmailId"]?.toString(),
        instituteId: json["InstituteId"]?.toString(),
        message: json["Message"] ?? '',
        firstName: json["FirstName"]?.toString(),
        otp: json["OTP"]?.toString(),
        branchId: json["BranchId"]?.toString(),
        code: json["Code"]?.toString() ?? '',
        roleId: json["RoleId"]?.toString(),
        instituteName: json["InstituteName"]?.toString(),
        roleName: json["RoleName"]?.toString(),
        mobileNumber: json["MobileNumber"]?.toString() ?? '',
        tokenType: json["TokenType"]?.toString(),
        refreshToken: json["RefreshToken"]?.toString(),
        username: json["Username"]?.toString(),
        userId: json["UserId"]?.toString(),
        accessToken: json["AccessToken"]?.toString(),
        refreshTokenExpiry: json["RefreshTokenExpiry"] != null
            ? DateTime.parse(json["RefreshTokenExpiry"])
            : null,
        branchName: json["BranchName"]?.toString(),
        lastName: json["LastName"]?.toString(),
        employeeId: json["EmployeeId"]?.toString(),
        expiresAt: json["ExpiresAt"] != null
            ? DateTime.parse(json["ExpiresAt"])
            : null,
    );

    Map<String, dynamic> toJson() => {
        "EmailId": emailId,
        "InstituteId": instituteId,
        "Message": message,
        "FirstName": firstName,
        "OTP": otp,
        "BranchId": branchId,
        "Code": code,
        "RoleId": roleId,
        "InstituteName": instituteName,
        "RoleName": roleName,
        "MobileNumber": mobileNumber,
        "TokenType": tokenType,
        "RefreshToken": refreshToken,
        "Username": username,
        "UserId": userId,
        "AccessToken": accessToken,
        "RefreshTokenExpiry": refreshTokenExpiry?.toIso8601String(),
        "BranchName": branchName,
        "LastName": lastName,
        "EmployeeId": employeeId,
        "ExpiresAt": expiresAt?.toIso8601String(),
    };
}