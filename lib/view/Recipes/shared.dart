import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';

Widget urlToImage(String imgUrl){
	try {
		return Image.network(imgUrl,
			width: 250,
			height: 250,
			errorBuilder: imageErrorHandler,
		);
	} catch (e) {
		return imageErrorHandler(null, null, null);
	}
}