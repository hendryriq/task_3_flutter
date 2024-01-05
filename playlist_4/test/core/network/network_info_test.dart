
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:task_3/core/platform/network_info.dart';

class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  NetworkInfoImpl? networkInfo;
  MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker!);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
          () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker?.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);

        final result = networkInfo?.isConnected;

        verify(mockDataConnectionChecker?.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
