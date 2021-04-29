import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';

Widget appBarTabsOnly({Color backgroundColor, List<Tab> tabs}) => AppBar(
	backgroundColor: backgroundColor,
	flexibleSpace: Column(
		mainAxisAlignment: MainAxisAlignment.end,
		children: [ TabBar(tabs: tabs) ],
	),
);


ListView listViewRecipesBuild(List<SingleRecipe> recipes, Widget Function(BuildContext, SingleRecipe recipe) routePage) => ListView.separated(
	shrinkWrap: true,
	padding: const EdgeInsets.all(8),
	itemCount: recipes.length,
	separatorBuilder: (BuildContext context, int index) => const Divider(),
	itemBuilder: (BuildContext context, int index) => GestureDetector(
		onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => routePage(context, recipes[index]))),
		child:Container(
		height: 75,
		color: Colors.yellow[500],
		child: Row(
					children: [
						Padding(
							padding: EdgeInsets.symmetric(horizontal: 15), 
							child: Image.network(recipes[index].imagesUrl, height: 70, width: 50)
						),
						Expanded(child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text("${recipes[index].recipeTitle}", style: TextStyle(fontSize: 24), overflow: TextOverflow.ellipsis),
								Text("${recipes[index].author}", style: TextStyle(color: Colors.amber[900]),)
							],
						))
					],
				)
	)),
);
