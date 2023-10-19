import 'package:todo_statemanagement/common/common.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/search/s_stock_detail.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/search/search_stock_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAutoCompleteList extends StatelessWidget
    with SearchStockDataProvider {
  final TextEditingController controller;
  SearchAutoCompleteList(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final stock = searchData.autoCompleteList[index];
        final stockName = stock.name;
        Tap(
          onTap: () {
            controller.clear();
            searchData.addHistory(stock);
            Nav.push(StockDetail(stockName: stockName));
          },
          child: stockName.text.make().p(20),
        );
      },
      itemCount: searchData.autoCompleteList.length,
    );
  }
}
