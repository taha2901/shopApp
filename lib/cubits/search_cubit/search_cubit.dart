import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/Network/end_points.dart';
import 'package:shopapp/components/sign_out.dart';
import 'package:shopapp/helper/api.dart';
import 'package:shopapp/models/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? search;
  void Search(String text) {
    emit(SearchLoadingStates());
    DioHelper().postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      search = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((onError) {
      print('This is Eror YAAAAAAAa  TAhaaaaaaaaaaa , ${onError.toString()}');
      emit(SearchErrorStates());
    });
  }
}
