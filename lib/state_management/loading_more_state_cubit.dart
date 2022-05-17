

import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingMoreStateCubit extends Cubit<bool>{
  LoadingMoreStateCubit() : super(false);

  startLoading(){
    emit(true);
  }
  finishLoading(){
    emit(false);
  }
}