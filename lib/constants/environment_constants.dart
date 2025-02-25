import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../config/model/config_model.dart';
import '../config/model/platform_config.dart';

final ConfigModel _configuration = ConfigModel.fromJson(
    jsonDecode(const String.fromEnvironment('config')..replaceAll("\\", "")));
final AndroidConfig? _androidConfig =
    _configuration.applicationConfig?.firebaseConfig?.androidConfig;
final IosConfig? _iosConfig =
    _configuration.applicationConfig?.firebaseConfig?.iosConfig;
final appName = _configuration.applicationConfig?.name;
final environment = _configuration.env;
final PlatformConfig? config =
    defaultTargetPlatform == TargetPlatform.iOS ? _iosConfig : _androidConfig;
