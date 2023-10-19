import 'package:todo_statemanagement/screen/main/tab/stock/stocks_dummy.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/tab/w_stock_item.dart';
import 'package:flutter/material.dart';

class InterestStockList extends StatelessWidget {
  const InterestStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...myInterestStocks.map((element) => StockItem(element)).toList(),
      ],
    );
  }
}
