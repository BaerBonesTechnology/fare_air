import 'dart:convert';

import 'application_config.dart';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));
String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.env,
    this.applicationConfig,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    env = json['env'];
    applicationConfig = json['applicationConfig'] != null
        ? ApplicationConfig.fromJson(json['applicationConfig'])
        : null;
  }
  String? env;
  ApplicationConfig? applicationConfig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['env'] = env;
    if (applicationConfig != null) {
      map['applicationConfig'] = applicationConfig?.toJson();
    }
    return map;
  }
}
