part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class GetDataFromServerEvent extends MainPageEvent {
  final String url;

  GetDataFromServerEvent(this.url);
}
