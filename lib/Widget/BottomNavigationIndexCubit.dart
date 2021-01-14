import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationIndexCubit extends Cubit<int> {
  BottomNavigationIndexCubit(): super(0);

  void changeIndex(int index) {
    emit(index);
  }
}