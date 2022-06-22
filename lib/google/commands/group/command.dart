import 'package:falcon/common/command.dart';
import 'package:falcon/google/commands/sub/command.dart';
import 'package:falcon/google/commands/sub/upload.dart';

class GoogleCommandGroup extends CommandGroup<GoogleSubcommand> {
  @override
  final name = 'google';
  @override
  final description = 'Google Play Store related commands';

  GoogleCommandGroup() {
    addSubcommands([
      UploadSubcommand(),
    ]);
  }
}
