import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository_i.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepositoryI {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);
  test('Deve retornar uma lista de result search', () async {
    when(repository.search(any))
        .thenAnswer((result) async => Future.value(Right(<ResultSearch>[])));

    final result = await usecase.call('renan');
    expect(result, isA<Right>());
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um invalid text error', () async {
    // when(repository.search(any))
    //     .thenAnswer((result) async => Future.value(Right(<ResultSearch>[])));

    var result = await usecase.call(null);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    result = await usecase.call('');

    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });
}
