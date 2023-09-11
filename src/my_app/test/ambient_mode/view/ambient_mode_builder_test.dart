import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_wearos_app/ambient_mode/ambient_mode.dart';

class TestAmbientModeListener extends ValueNotifier<bool>
    implements AmbientModeListener {
  // ignore: avoid_positional_boolean_parameters
  TestAmbientModeListener(super.value);

  @override
  bool get isAmbientModeActive => value;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$AmbientModeBuilder', () {
    test('can be instantiated', () {
      final builder = AmbientModeBuilder(
        child: Container(),
        builder: (context, isAmbientMode, _) => Container(),
      );
      expect(builder, isNotNull);
    });

    testWidgets('builds with ambient mode', (tester) async {
      final listener = TestAmbientModeListener(true);

      await tester.pumpWidget(
        MaterialApp(
          home: AmbientModeBuilder(
            listener: listener,
            builder: (context, isAmbientMode, _) {
              return Text(isAmbientMode.toString());
            },
          ),
        ),
      );
      expect(find.text('true'), findsOneWidget);

      listener.value = false;
      await tester.pumpAndSettle();

      expect(find.text('false'), findsOneWidget);
    });
  });
}
