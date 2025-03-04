import 'package:bloc/bloc.dart';
import 'package:movies/bloc/states/bottom_nav/buttom_nav.dart';

class ButtomNavBar extends Cubit<ButtomNav> {
  ButtomNavBar() : super(ButtomNavInitState());
  int currentIndex = 0;

  changePage(value) {
    currentIndex = value;
    emit(ButtomNavSuccessState());
  }
}
