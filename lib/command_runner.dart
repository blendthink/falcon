import 'package:args/command_runner.dart';
import 'package:falcon/commands/flags/version.dart';
import 'package:falcon/common/option.dart';
import 'package:falcon/gen/pubspec.dart';
import 'package:falcon/google/commands/group/command.dart';
import 'package:falcon/util/logger.dart';

class FalconCommandRunner extends CommandRunner<dynamic> {
  FalconCommandRunner()
      : super(
          'falcon',
          'Tool for uploading to Google Play Store and App Store Connect',
        ) {
    addFlags([VersionFlag()]);
    addCommand(GoogleCommandGroup());
    // TODO(blendthink): add AppleCommandGroup
  }

  static const _docUrl = 'https://pub.dev/packages/falcon';

  @override
  String get usageFooter => 'See $_docUrl for detailed documentation.';

  @override
  Future run(Iterable<String> args) async {
    final argResults = parse(args);

    if (VersionFlag.enabled(argResults)) {
      log.i(pubspec.version);
      return;
    }

    return Future.sync(() => runCommand(argResults));
  }

  void addFlags(List<Flag> flags) {
    for (final flag in flags) {
      argParser.addFlag(
        flag.name,
        abbr: flag.abbr,
        help: flag.help,
        defaultsTo: flag.defaultsTo,
        negatable: flag.negatable,
        callback: flag.callback,
        hide: flag.hide,
        aliases: flag.aliases,
      );
    }
  }
}
