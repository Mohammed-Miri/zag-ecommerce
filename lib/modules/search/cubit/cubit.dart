import 'package:demo/modles/search_model.dart';
import 'package:demo/modules/search/cubit/states.dart';
import 'package:demo/shared/components/constants.dart';
import 'package:demo/shared/networks/end_points/end_points.dart';
import 'package:demo/shared/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit():super(InitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  search({
    required String text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(url: PRODUCTS_SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
