import 'package:apple_shop/utility/extentions/string_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_category/product_category.bloc.dart';
import '../../data/model/category.dart';
import '../../dependency_injection/di.dart';
import '../screens/product_category_screen.dart';
import 'catched_image.dart';

class ItemList extends StatefulWidget {
  final Categoryy list;
  const ItemList({super.key, required this.list});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    String color = widget.list.color;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<ProductCategoryBloc>(
              create: (context) {
                return locator.get<ProductCategoryBloc>();
              },
              child: ProductCategoryScreen(widget.list),
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: color.colorParse(),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  shadows: [
                    BoxShadow(
                      color: color.colorParse(),
                      blurRadius: 25,
                      spreadRadius: -12,
                      offset: const Offset(0.0, 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27,
                width: 27,
                child: Center(
                  child: CatchImage(image: widget.list.icon),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.list.title,
            style: const TextStyle(
              fontFamily: 'GB',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
