import 'dart:async';
import 'dart:io';

class MemoryWatchdog {
  static const int _maxMb = 1400;
  Timer? _timer;

  void start(void Function() onPressure) {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final usedMb = ProcessInfo.currentRss ~/ (1024 * 1024);
      if (usedMb > _maxMb) onPressure();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}
