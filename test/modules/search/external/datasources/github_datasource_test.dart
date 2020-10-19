import 'dart:convert';

import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GitHubDataSourceImpl(dio);

  test('deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((realInvocation) async =>
        Response(data: jsonDecode(gitHubResponse), statusCode: 200));
    final future = datasource.getSearch('searchtext');
    expect(future, completes);
  });
  test('deve retornar um DataSourceError se o statuscode não for 200',
      () async {
    when(dio.get(any)).thenAnswer(
        (realInvocation) async => Response(data: null, statusCode: 401));
    final future = datasource.getSearch('texto');
    expect(future, throwsA(isA<DataSourceError>()));
  });
  test('deve retornar uma Exception', () async {
    when(dio.get(any)).thenThrow(Exception());
    final future = datasource.getSearch('texto');
    expect(future, throwsA(isA<Exception>()));
  });
}
