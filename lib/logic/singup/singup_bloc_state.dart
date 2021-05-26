
import 'package:flutter_app/model/person.dart';

abstract class SingupState {}

class SingupFailState extends SingupState {}

class SingupSucessState extends SingupState {
	Person person;
	SingupSucessState({this.person});
}