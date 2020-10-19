import 'package:clean_arch/modules/search/infra/models/result_search_model.dart';

abstract class SearchDataSourceI {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}
