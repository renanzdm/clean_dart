import 'package:clean_arch/modules/search/domain/entities/result_search.dart';
import 'package:clean_arch/modules/search/domain/errors/errors.dart';
import 'package:clean_arch/modules/search/domain/repositories/search_repository_i.dart';
import 'package:dartz/dartz.dart';

abstract class SearchByTextI {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByTextI {
  final SearchRepositoryI searchRepositoryI;

  SearchByTextImpl(this.searchRepositoryI);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    return searchRepositoryI.search(searchText);
  }
}
