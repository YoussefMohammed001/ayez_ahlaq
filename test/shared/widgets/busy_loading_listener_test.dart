import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/shared/widgets/busy_loading_listener.dart';

class _BusyCubit extends Cubit<bool> {
  _BusyCubit() : super(false);

  void set(bool value) => emit(value);
}

void main() {
  late _BusyCubit cubit;
  late List<String> log;

  setUp(() {
    cubit = _BusyCubit();
    log = [];
  });

  Future<void> pump(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: cubit,
        child: BusyLoadingListener<_BusyCubit, bool>(
          isBusy: (busy) => busy,
          onShow: () => log.add('show'),
          onHide: () => log.add('hide'),
          child: const SizedBox(),
        ),
      ),
    ),
  );

  testWidgets('shows while busy and hides when done', (tester) async {
    await pump(tester);

    cubit.set(true);
    await tester.pump();
    cubit.set(false);
    await tester.pump();

    expect(log, ['show', 'hide']);
  });

  testWidgets('does nothing when the state does not change', (tester) async {
    await pump(tester);

    cubit.set(false);
    await tester.pump();

    expect(log, isEmpty);
  });

  testWidgets('every update shows and hides again', (tester) async {
    await pump(tester);

    for (var i = 0; i < 2; i++) {
      cubit.set(true);
      await tester.pump();
      cubit.set(false);
      await tester.pump();
    }

    expect(log, ['show', 'hide', 'show', 'hide']);
  });
}
