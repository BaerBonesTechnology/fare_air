sealed class PlatformConfig {
  PlatformConfig({
    this.apiKey,
    this.appId,
    this.messagingSenderId,
    this.projectId,
    this.storageBucket,
  });

  PlatformConfig.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    appId = json['appId'];
    messagingSenderId = json['messagingSenderId'];
    projectId = json['projectId'];
    storageBucket = json['storageBucket'];
  }

  String? apiKey;
  String? appId;
  String? messagingSenderId;
  String? projectId;
  String? storageBucket;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['apiKey'] = apiKey;
    map['appId'] = appId;
    map['messagingSenderId'] = messagingSenderId;
    map['projectId'] = projectId;
    map['storageBucket'] = storageBucket;
    return map;
  }
}

class AndroidConfig extends PlatformConfig {
  AndroidConfig({
    super.apiKey,
    super.appId,
    super.messagingSenderId,
    super.projectId,
    super.storageBucket,
  });

  AndroidConfig.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    appId = json['appId'];
    messagingSenderId = json['messagingSenderId'];
    projectId = json['projectId'];
    storageBucket = json['storageBucket'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['apiKey'] = apiKey;
    map['appId'] = appId;
    map['messagingSenderId'] = messagingSenderId;
    map['projectId'] = projectId;
    map['storageBucket'] = storageBucket;
    return map;
  }
}

class IosConfig extends PlatformConfig {
  IosConfig({
    super.apiKey,
    super.appId,
    super.messagingSenderId,
    super.projectId,
    super.storageBucket,
    this.iosBundleId,
  });

  IosConfig.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    appId = json['appId'];
    messagingSenderId = json['messagingSenderId'];
    projectId = json['projectId'];
    storageBucket = json['storageBucket'];
    iosBundleId = json['iosBundleId'];
  }

  String? iosBundleId;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['apiKey'] = apiKey;
    map['appId'] = appId;
    map['messagingSenderId'] = messagingSenderId;
    map['projectId'] = projectId;
    map['storageBucket'] = storageBucket;
    map['iosBundleId'] = iosBundleId;
    return map;
  }
}
