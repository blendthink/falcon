import 'dart:io';

import 'package:falcon/google/data/status.dart';
import 'package:falcon/google/data/track.dart' as t;
import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class UploadRepository {
  final AutoRefreshingAuthClient client;

  UploadRepository(this.client);

  Future<void> upload({
    required String packageName,
    required File bundleFile,
    required t.Track track,
    required Status status,
  }) async {
    final api = AndroidPublisherApi(client);

    final edits = api.edits;
    final appEdit = await edits.insert(AppEdit(), packageName);
    final editId = appEdit.id!;

    final media = Media(bundleFile.openRead(), bundleFile.lengthSync());

    await edits.bundles.upload(packageName, editId, uploadMedia: media);

    final trackName = track.name;
    await edits.tracks.patch(
      Track(releases: [
        TrackRelease(status: status.name, versionCodes: ['5'])
      ], track: trackName),
      packageName,
      editId,
      trackName,
    );

    await edits.commit(packageName, editId);
  }
}
