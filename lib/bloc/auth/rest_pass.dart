import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/class/app_links_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen/rest_pass.dart' show RestPass;
import '../states/auth/rest_pass.dart' show RestPasLoadingState, RestPassErrorState, RestPassInitState, RestPassSuccessState;


class RestPassBloc extends Cubit<RestPass> {
  RestPassBloc() : super(RestPassInitState() as RestPass);

  TextEditingController oldPass = TextEditingController();

  TextEditingController newPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  restPass() async {
    try {
      if (formKey.currentState!.validate()) {
        emit(RestPasLoadingState() as RestPass);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token") ?? '';

        Uri url = Uri.parse(AppLinksApi.restPass);
        http.Response res = await http.patch(
          url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "oldPassword": oldPass.text,
            "newPassword": newPass.text,
          }),
        );

        if (res.statusCode >= 200 && res.statusCode < 300) {
          emit(RestPassSuccessState() as RestPass);
        } else {
          emit(RestPassErrorState(error: res.statusCode.toString()) as RestPass);
        }
      }
    } catch (e) {
      emit(RestPassErrorState(error: e.toString()) as RestPass);
    }
  }
}
