import 'package:todo_statemanagement/screen/main/tab/stock/vo_popular_stock.dart';

class Stock extends PopularStock {
  final String stockImagePath;

  Stock({
    required super.stockName,
    required this.stockImagePath,
    required super.currentPrice,
    required super.yesterdayClosePrice,
  });
}
