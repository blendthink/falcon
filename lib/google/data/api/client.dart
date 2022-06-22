import 'dart:io';

import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

Future<AutoRefreshingAuthClient> newAuthClient(File keyFile) async {
  final json = keyFile.readAsStringSync();
  final credentials = ServiceAccountCredentials.fromJson(json);
  final scopes = [AndroidPublisherApi.androidpublisherScope];

  return await clientViaServiceAccount(credentials, scopes);
}
