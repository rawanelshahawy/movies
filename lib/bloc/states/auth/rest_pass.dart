abstract class RestPass {}

class RestPassInitState extends RestPass {}

class RestPasLoadingState extends RestPass {}

class RestPassErrorState extends RestPass {
  String? error;
  RestPassErrorState({this.error});
}

class RestPassSuccessState extends RestPass {}
