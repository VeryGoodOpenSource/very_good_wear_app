import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A simple [ValueNotifier] that listens to ambient mode changes.
///
/// These changes are emitted by the "AmbientModeSupport" API in the
/// Android side's main activity trough a [MethodChannel].
class AmbientModeListener extends ValueNotifier<bool> {
  AmbientModeListener._() : super(false) {
    _channel.setMethodCallHandler(_onMethodCallHandler);
  }

  static const MethodChannel _channel = MethodChannel('ambient_mode');

  static final instance = AmbientModeListener._();

  Future<dynamic> _onMethodCallHandler(MethodCall call) async {
    value = switch (call.method) {
      'onEnterAmbient' || 'onUpdateAmbient' => true,
      'onExitAmbient' => false,
      _ => throw UnimplementedError()
    };
  }

  bool get isAmbientModeActive => value;
}
