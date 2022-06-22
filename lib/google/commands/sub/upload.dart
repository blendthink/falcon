import 'dart:io';

import 'package:args/args.dart';
import 'package:falcon/google/commands/sub/command.dart';
import 'package:falcon/google/commands/sub/options/bundle_path.dart';
import 'package:falcon/google/commands/sub/options/key_path.dart';
import 'package:falcon/google/commands/sub/options/package_name.dart';
import 'package:falcon/google/commands/sub/options/status.dart';
import 'package:falcon/google/commands/sub/options/track.dart';
import 'package:falcon/google/data/api/client.dart';
import 'package:falcon/google/data/api/repository.dart';
import 'package:falcon/google/data/status.dart';
import 'package:falcon/google/data/track.dart';
import 'package:falcon/util/logger.dart';

class UploadSubcommand extends GoogleSubcommand {
  @override
  String get name => 'upload';

  @override
  String get description => 'Uploads a new Android App Bundle.';

  UploadSubcommand()
      : super([
          PackageNameOption(),
          BundlePathOption(),
          StatusOption(),
          TrackOption(),
        ]);

  @override
  Future<void> run() async {
    final params = OptionParams.fromResults(argResults, usageException);

    final client = await newAuthClient(params.keyFile);
    final repository = UploadRepository(client);

    try {
      log.i('Uploading..');
      await repository.upload(
        packageName: params.packageName,
        bundleFile: params.bundleFile,
        track: params.track,
        status: params.status,
      );
      log.i('Upload succeeded!');
    } finally {
      client.close();
    }
  }
}

class OptionParams {
  final File keyFile;
  final String packageName;
  final File bundleFile;
  final Track track;
  final Status status;

  factory OptionParams.fromResults(
    ArgResults argResults,
    Never Function(String message) usageException,
  ) {
    final keyFile = KeyPathOption.file(argResults, usageException);
    final packageName =
        PackageNameOption.packageName(argResults, usageException);
    final bundleFile = BundlePathOption.file(argResults, usageException);
    final track = TrackOption.track(argResults);
    final status = StatusOption.status(argResults);

    return OptionParams._(
      keyFile: keyFile,
      packageName: packageName,
      bundleFile: bundleFile,
      track: track,
      status: status,
    );
  }

  OptionParams._({
    required this.keyFile,
    required this.packageName,
    required this.bundleFile,
    required this.track,
    required this.status,
  });
}
