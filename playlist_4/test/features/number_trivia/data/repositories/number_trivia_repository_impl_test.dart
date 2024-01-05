import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_3/core/platform/network_info.dart';
import 'package:task_3/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:task_3/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:task_3/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:task_3/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:task_3/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body){
    group('device is online', () {
      setUp(() {
       when(mockNetworkInfo.isConnected).thenAnswer((_)async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body){
    group('device is offline', () {
      setUpAll(() async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: tNumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel as NumberTrivia;

    test(
        'should check if the device is online',
            () async{
          when(mockNetworkInfo.isConnected).thenAnswer((_) async =>true);

          repository.getConcreteNumberTrivia(tNumber);
          verify(mockNetworkInfo.isConnected);
            });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is success',
              () async{
            when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = repository.getConcreteNumberTrivia(1);

            verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
            expect(result, equals(Right(tNumberTrivia)));
          });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
              () async{
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getConcreteNumberTrivia(tNumber);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastNumberTrivia());
            expect(result, equals(Right(tNumberTrivia)));
          });

      test(
          'should return CacheFailure when there is no cached data present',
              () async{
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getConcreteNumberTrivia(tNumber);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastNumberTrivia());
            expect(result, equals(Right(tNumberTrivia)));
          });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel as NumberTrivia;

    test(
        'should check if the device is online',
            () async{
          when(mockNetworkInfo.isConnected).thenAnswer((_) async =>true);

          repository.getConcreteNumberTrivia();
          verify(mockNetworkInfo.isConnected);
        });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is success',
              () async{
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = repository.getConcreteNumberTrivia(1);

            verify(mockRemoteDataSource.getRandomNumberTrivia());
            expect(result, equals(Right(tNumberTrivia)));
          });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
              () async{
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getRandomNumberTrivia(tNumber);

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastNumberTrivia());
            expect(result, equals(Right(tNumberTrivia)));
          });

      test(
          'should return CacheFailure when there is no cached data present',
              () async{
            when(mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getRandomNumberTrivia();

            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getLastNumberTrivia());
            expect(result, equals(Right(tNumberTrivia)));
          });
    });
  });

}
