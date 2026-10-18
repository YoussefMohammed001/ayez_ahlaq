import 'package:ayez_ahlaq/core/di/services_locator.dart';
import 'package:ayez_ahlaq/core/session/session_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _CounterCubit extends Cubit<int> {
  _CounterCubit() : super(0);

  void increment() => emit(state + 1);
}

void main() {
  setUp(() {
    sl.reset();
    sl.registerFactory(_CounterCubit.new);
    SessionScope.reset();
  });

  test('returns the same instance until the session is reset', () {
    final first = SessionScope.cubit<_CounterCubit>()..increment();

    expect(SessionScope.cubit<_CounterCubit>(), same(first));
    expect(SessionScope.cubit<_CounterCubit>().state, 1);
  });

  test('reset hands out a fresh cubit with initial state', () {
    final first = SessionScope.cubit<_CounterCubit>()..increment();

    SessionScope.reset();
    final second = SessionScope.cubit<_CounterCubit>();

    expect(second, isNot(same(first)));
    expect(second.state, 0);
  });
}
