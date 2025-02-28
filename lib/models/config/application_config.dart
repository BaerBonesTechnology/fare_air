class ApplicationConfig {
  ApplicationConfig({
    this.name,
    this.version,
    this.description,
    this.author,
    this.rapidApiKey,
  });

  ApplicationConfig.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    version = json['version'];
    description = json['description'];
    author = json['author'];
    rapidApiKey = json['rapidApiKey'];
  }
  String? name;
  String? version;
  String? description;
  String? author;
  String? rapidApiKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['version'] = version;
    map['description'] = description;
    map['author'] = author;
    map['rapidApiKey'] = rapidApiKey;

    return map;
  }
}
