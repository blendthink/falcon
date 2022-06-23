import 'dart:io';

import 'package:args/args.dart' show ArgResults;
import 'package:falcon/common/command.dart';
import 'package:falcon/common/option.dart';

class BundlePathOption extends Option {
  static const _name = 'bundlePath';

  BundlePathOption()
      : super(
          _name,
          abbr: 'b',
          help: 'set .aab file path',
          defaultsTo: './build/app/outputs/bundle/release/app-release.aab',
        );

  static File file(
    ArgResults argResults,
    Never Function(String message) usageException,
  ) {
    final path = argResults.requireParam<String>(_name);
    final file = File(path);
    if (!file.existsSync()) {
      usageException('Not found file: $path');
    }
    return file;
  }
}
