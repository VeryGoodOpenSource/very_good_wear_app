import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A singleton [ValueNotifier] that listens to ambient mode changes.
///
/// These changes are emitted by the "AmbientModeSupport" API in the
/// Android side's main activity trough a [MethodChannel].
///
/// The [bool] value indicates if the ambient mode is active.
class AmbientModeListener extends ValueNotifier<bool> {
  AmbientModeListener._(MethodChannel channel) : super(false) {
    channel.setMethodCallHandler(_onMethodCallHandler);
  }

  @visibleForTesting
  AmbientModeListener.test(MethodChannel channel) : this._(channel);

  static final instance = AmbientModeListener._(
    const MethodChannel('ambient_mode'),
  );

  bool get isAmbientModeActive => value;

  Future<dynamic> _onMethodCallHandler(MethodCall call) async {
    value = switch (call.method) {
      'onEnterAmbient' || 'onUpdateAmbient' => true,
      'onExitAmbient' => false,
      _ => throw UnimplementedError()
    };
  }
}
