import 'package:args/args.dart' show ArgResults;
import 'package:falcon/common/command.dart';
import 'package:falcon/google/data/status.dart';

class StatusOption extends Option<Status> {
  static const _name = 'status';

  StatusOption()
      : super(
          _name,
          abbr: 's',
          allowed: Status.values.map((e) => e.name),
          help: 'bundle status',
          defaultsTo: Status.draft.name,
        );

  static Status status(ArgResults argResults) {
    final status = argResults.requireParam<String>(_name);
    return Status.values.byName(status);
  }
}
