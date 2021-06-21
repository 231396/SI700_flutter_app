import 'package:flutter/material.dart';

final tabTextStyle = TextStyle(
	fontSize: 16,
	color: Colors.black54,
);

String basicValidator(String str){
	if (str == null || str.isEmpty)
		return 'Campo em vazio';
    return null;
}

bool validURL(String url) => Uri.parse(url).isAbsolute;

bool basicStringValidation(String str) => str == null || str.isEmpty;


Widget _imgErrorFunc(double width, double height){
	return SizedBox(		
		width: width,
		height: height,
		child: Icon(Icons.insert_drive_file, size: (width > height ? width : height)/2),
	);
}

Widget networkImage(String imgUrl, double width, double height){
	if(basicStringValidation(imgUrl) || !Uri.parse(imgUrl).isAbsolute)
		return _imgErrorFunc(width, height);
	return Image.network(imgUrl,
		width: width,
		height: height,
		fit: BoxFit.cover,
		errorBuilder: (context, expection, stack) => _imgErrorFunc(width, height),
	);
}