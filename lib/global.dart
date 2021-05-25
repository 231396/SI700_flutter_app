import 'package:flutter/material.dart';

final tabTextStyle = TextStyle(
	fontSize: 16,
	color: Colors.black54,
);

String basicValidator(String str){
	if (str == null || str.isEmpty)
		return 'Campo em branco';
    return null;
}