import 'platform_config.dart';

class FirebaseConfig {
  FirebaseConfig({
    this.androidConfig,
    this.iosConfig,
  });

  FirebaseConfig.fromJson(Map<String, dynamic> json) {
    androidConfig = json['androidConfig'] != null
        ? AndroidConfig.fromJson(json['androidConfig'])
        : null;
    iosConfig = json['iosConfig'] != null
        ? IosConfig.fromJson(json['iosConfig'])
        : null;
  }
  AndroidConfig? androidConfig;
  IosConfig? iosConfig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (androidConfig != null) {
      map['androidConfig'] = androidConfig?.toJson();
    }
    if (iosConfig != null) {
      map['iosConfig'] = iosConfig?.toJson();
    }
    return map;
  }
}
