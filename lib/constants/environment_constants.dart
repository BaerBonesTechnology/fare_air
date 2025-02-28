import 'dart:convert';

import 'package:fare_air/constants/endpoints.dart';

import '../models/config/config_model.dart';
import 'defaults.dart';

final ConfigModel _configuration = ConfigModel.fromJson(
    jsonDecode(const String.fromEnvironment('config')..replaceAll("\\", "")));
final appName = _configuration.applicationConfig?.name;
final environment = _configuration.env;
final Map<String, String> rapidApiHeaders = {
  rapidApiHostKey: skyScrapperHost,
  rapidApiKeyKey: _configuration.applicationConfig?.rapidApiKey ?? ''
};
