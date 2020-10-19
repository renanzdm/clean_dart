import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository_i.dart';
import 'package:clean_arch/modules/search/infra/datasources/search_datasource.dart';
import 'package:clean_arch/modules/search/infra/models/result_search_model.dart';
import 'package:clean_arch/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDataSourceMock extends Mock implements SearchDataSourceI {}

main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de result search', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) => Future.value(<ResultSearchModel>[]));

    final result = await repository.search('renan');
    expect(result | null, isA<List<ResultSearch>>());
  });
  test('deve retornar um DataSourceError se data source falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search('renan');
    expect(result.fold((l) => l, (r) => r), isA<DataSourceError>());
  });
}
