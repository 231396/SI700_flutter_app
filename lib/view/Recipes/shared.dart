import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/global.dart';

Widget urlToImage(String imgUrl){
	try {
		return Image.network(imgUrl,
			width: 250,
			height: 250,
			errorBuilder: imageErrorHandler,
		);
	} catch (e) {
		return const Icon(Icons.insert_drive_file, size: 250);
	}
}

Widget clipboardButton(BuildContext context, String clipString) => TextButton.icon(
		label: Text("Copy"),
		icon: Icon(Icons.copy),
		style: ElevatedButton.styleFrom(
			primary: Colors.transparent,
			textStyle: const TextStyle(fontSize: 12),
		),
		onPressed: () async {
			await Clipboard.setData(ClipboardData(text: clipString));
			ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copiado')));
		},
);