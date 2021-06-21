import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/global.dart';

Widget urlToImage(String imgUrl){
	return networkImage(imgUrl, 300, 250);
}


Widget uidRecipe(BuildContext context, String uid){
	return Container(
		padding: const EdgeInsets.all(10.0),
		alignment: Alignment.centerLeft,
		child: Row(
				children: [
				Text("ID: $uid"),
				const SizedBox(width: 10),
				clipboardButton(context, uid),
			],
		),
	);
}

Widget clipboardButton(BuildContext context, String clipString) => TextButton.icon(
		label: Text("Copiar"),
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