import 'package:clean_arch/app_widget.dart';
import 'package:clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:clean_arch/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GitHubDataSourceImpl(i())),
      ];

  @override
  List<ModularRouter> get routers => throw UnimplementedError();
  @override
  Widget get bootstrap => AppWidget();
}
