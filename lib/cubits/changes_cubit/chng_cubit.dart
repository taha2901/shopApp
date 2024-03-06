import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/helper/cach.dart';

part 'chng_state.dart';

class ChangeCubit extends Cubit<ChangeState> {
  ChangeCubit() : super(ChngInitial());

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangesModeState());
    } else {
      isDark = !isDark;
      ChachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangesModeState());
      });
    }
  }
}
