import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelHud extends ChangeNotifier{
  bool IsLoading = false ;

  ChangeIsLoading(bool value){

    IsLoading = value;
    notifyListeners() ;
  }


}