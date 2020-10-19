import 'dart:convert';

import 'package:clean_arch/app_module.dart';
import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('deve recuperar o usecase sem erro', () {
    final usecase = Modular.get<SearchByTextI>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('deve recuperar list de result search', () async {
    when(dio.get(any)).thenAnswer((realInvocation) async =>
        Response(data: jsonDecode(gitHubResponse), statusCode: 200));
    final usecase = Modular.get<SearchByTextI>();
    final result = await usecase.call('renan');
    expect(result | null, isA<List<ResultSearch>>());
  });
}
