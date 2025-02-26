import 'firebase_config.dart';

class ApplicationConfig {
  ApplicationConfig({
    this.name,
    this.version,
    this.description,
    this.author,
    this.rapidApiKey,
    this.firebaseConfig,
  });

  ApplicationConfig.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
    description = json['description'];
    author = json['author'];
    rapidApiKey = json['rapidApiKey'];
    firebaseConfig = json['firebaseConfig'] != null
        ? FirebaseConfig.fromJson(json['firebaseConfig'])
        : null;
  }
  String? name;
  String? version;
  String? description;
  String? author;
  String? rapidApiKey;
  FirebaseConfig? firebaseConfig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['version'] = version;
    map['description'] = description;
    map['author'] = author;
    map['rapidApiKey'] = rapidApiKey;
    if (firebaseConfig != null) {
      map['firebaseConfig'] = firebaseConfig?.toJson();
    }
    return map;
  }
}
