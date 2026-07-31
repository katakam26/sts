/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
    LoginRequest({
        required this.mobileNumber,
        required this.deviceToken,
    });

    String mobileNumber;
    String deviceToken;

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        mobileNumber: json["MobileNumber"],
        deviceToken: json["DeviceToken"],
    );

    Map<String, dynamic> toJson() => {
        "MobileNumber": mobileNumber,
        "DeviceToken": deviceToken,
    };
}
