import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../srs/fsrs_algorithm.dart';
import '../srs/sm2_algorithm.dart';
import '../srs/srs_algorithm.dart';

final srsAlgorithmProvider = Provider<SrsAlgorithm>((ref) {
  return AppConfig.useFsrs ? FsrsAlgorithm() : Sm2Algorithm();
});
