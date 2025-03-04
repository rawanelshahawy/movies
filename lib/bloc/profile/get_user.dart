import 'package:bloc/bloc.dart';
import 'package:movies/bloc/profile/states.dart' show ProfileInitState, ProfileLoadingState, ProfileState, ProfileSuccessState;
import 'package:shared_preferences/shared_preferences.dart';

class GetProfileAcc extends Cubit<ProfileState> {
  GetProfileAcc() : super(ProfileInitState());

  String name = "";
  int avaterId = 0;
  late SharedPreferences shapref;
  getUser() async {
    emit(ProfileLoadingState());
    shapref = await SharedPreferences.getInstance();
    name = shapref.getString("name") ?? "";
    avaterId = shapref.getInt("avaterId") ?? 0;
    print(avaterId);
    emit(ProfileSuccessState());
  }

  logOut(_) {
    shapref.remove("name");
    shapref.remove("email");
    shapref.remove("phone");
    shapref.remove("pass");
    shapref.remove("avaterId");
    shapref.remove("isLogin");
    shapref.remove("id");
    shapref.remove("token");
  }
}
