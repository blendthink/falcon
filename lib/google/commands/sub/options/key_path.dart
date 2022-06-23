import 'dart:io';

import 'package:args/args.dart' show ArgResults;
import 'package:falcon/common/command.dart';
import 'package:falcon/common/option.dart';

class KeyPathOption extends Option {
  static const _name = 'keyPath';

  KeyPathOption()
      : super(
          _name,
          abbr: 'k',
          help: 'set service-account.json path',
          defaultsTo: './service-account.json',
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
