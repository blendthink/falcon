import 'package:args/command_runner.dart';
import 'package:falcon/google/commands/google_commands.dart';

class FalconCommandRunner extends CommandRunner<dynamic> {
  FalconCommandRunner()
      : super(
          'falcon',
          'Tool for uploading to Google Play Store and App Store Connect',
        ) {
    addCommand(GoogleCommandGroup());
    // TODO(blendthink): add AppleCommandGroup
  }

  static const _docUrl = 'https://pub.dev/packages/falcon';

  @override
  String get usageFooter => 'See $_docUrl for detailed documentation.';
}
