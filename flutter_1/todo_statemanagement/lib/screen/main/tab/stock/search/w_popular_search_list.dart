import 'package:animations/animations.dart';
import 'package:todo_statemanagement/common/common.dart';
import 'package:todo_statemanagement/common/dart/extension/datetime_extension.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/search/popular_stock_dummy.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/search/s_stock_detail.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/search/w_popular_stock_item.dart';
import 'package:flutter/material.dart';

class PopularSearchList extends StatefulWidget {
  const PopularSearchList({super.key});

  @override
  State<PopularSearchList> createState() => _PopularSearchListState();
}

class _PopularSearchListState extends State<PopularSearchList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            '인기 검색'.text.bold.make(),
            emptyExpanded,
            '오늘 ${DateTime.now().formattedTime} 기준'.text.size(12).make(),
          ],
        ).pSymmetric(h: 20),
        height20,
        ...popularStocks
            .mapIndexed((e, index) => OpenContainer<bool>(
                  openColor: context.backgroundColor,
                  closedColor: context.backgroundColor,
                  openBuilder: (BuildContext context, VoidCallback _) {
                    return StockDetail(stockName: e.name);
                  },
                  closedBuilder: (BuildContext context, VoidCallback aciton) {
                    return Row(
                      children: [
                        (index + 1).text.bold.white.size(16).make(),
                        width20,
                        e.name.text.bold.white.size(16).make(),
                        emptyExpanded,
                        e.todayPercentageString.text
                            .color(e.getTodayPercentageColor(context))
                            .size(16)
                            .make(),
                      ],
                    ).pSymmetric(h: 20, v: 20);
                  },
                ))
            .toList()
      ],
    );
  }
}
