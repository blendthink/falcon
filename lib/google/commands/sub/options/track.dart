import 'package:args/args.dart' show ArgResults;
import 'package:falcon/common/command.dart';
import 'package:falcon/google/data/track.dart';

class TrackOption extends Option<Track> {
  static const _name = 'track';

  TrackOption()
      : super(
          _name,
          abbr: 't',
          allowed: Track.values.map((e) => e.name),
          help: 'bundle track',
          defaultsTo: Track.internal.name,
        );

  static Track track(ArgResults argResults) {
    final track = argResults.requireParam<String>(_name);
    return Track.values.byName(track);
  }
}
