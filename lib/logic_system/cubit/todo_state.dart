abstract class TodoState {}

final class TodoInitial extends TodoState {}

class ChangeCurrentIndexState extends TodoState {}

class ShowBottomSheetLoaded extends TodoState {}

class ShowButtomSheetVisibleState extends TodoState {}

class CreatDataBaseTableSucceedState extends TodoState {}

class CreatDataBaseTableErrorState extends TodoState {
  final String error;
  CreatDataBaseTableErrorState(this.error);
}

class InsertDataBaseRawSucceedState extends TodoState {}

class InsertDataBaseRawErrorState extends TodoState {
  final String error;
  InsertDataBaseRawErrorState(this.error);
}

class GetDataFromDataBaseLoadingState extends TodoState {}

class GetDataFromDataBaseSucceedState extends TodoState {}

class GetDataFromDataBaseErrorState extends TodoState {
  final String error;
  GetDataFromDataBaseErrorState(this.error);
}

class CreateDataBaseSucceedState extends TodoState{}
