// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/search_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH, data: {'text': text},authorization: token)
        .then((value) {
          searchModel = SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(SearchErrorState());
    });
  }
}
