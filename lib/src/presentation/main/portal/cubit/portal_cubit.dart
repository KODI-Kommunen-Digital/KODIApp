import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

import 'cubit.dart';

class PortalCubit extends Cubit<PortalState> {
  PortalCubit() : super(const PortalLoading());
  bool doesScroll = false;

  dynamic response;

  Future<void> onLoad() async {
    emit(const PortalLoading());
    //final prefBox = await Preferences.openBox();

    //final userId = prefBox.getKeyValue(Preferences.userId, 0);
    emit(const PortalState.loaded());
  }

  String onDateParse(String date) {
    final parsedDateTime = DateTime.parse(date);
    var createDate = DateFormat('dd.MM.yyyy').format(parsedDateTime);
    return createDate;
  }

  bool getDoesScroll() {
    return doesScroll;
  }

  void setDoesScroll(bool scroll) {
    doesScroll = scroll;
  }

  void scrollUp() {
    emit(const PortalLoading());
    emit(const PortalState.loaded());
  }
}
