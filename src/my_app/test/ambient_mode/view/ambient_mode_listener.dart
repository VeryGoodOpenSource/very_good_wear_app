import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_wearos_app/ambient_mode/ambient_mode.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  group('$AmbientModeListener', () {
    test('instance exists', () {
      final listener = AmbientModeListener.instance;
      expect(listener.isAmbientModeActive, isFalse);
    });

    test('updates when ambient mode is activated', () {
      final listener = AmbientModeListener.instance..value = false;

      messenger.sendMethodCall(const MethodCall('onEnterAmbient'));

      expect(listener.isAmbientModeActive, isTrue);
    });

    test('updates when ambient mode is update', () {
      final listener = AmbientModeListener.instance..value = false;

      messenger.sendMethodCall(const MethodCall('onUpdateAmbient'));

      expect(listener.isAmbientModeActive, isTrue);
    });

    test('updates when ambient mode is deactivated', () async {
      final listener = AmbientModeListener.instance..value = true;

      messenger.sendMethodCall(const MethodCall('onExitAmbient'));

      expect(listener.isAmbientModeActive, isFalse);
    });

    test('doesnt change on unkown method', () async {
      final listener = AmbientModeListener.instance..value = true;

      messenger.sendMethodCall(const MethodCall('onUnknownMethod'));

      expect(listener.isAmbientModeActive, isTrue);
    });
  });
}

extension on TestDefaultBinaryMessenger {
  void sendMethodCall(MethodCall call) {
    final data = const StandardMethodCodec().encodeMethodCall(call);
    handlePlatformMessage('ambient_mode', data, (data) {});
  }
}
