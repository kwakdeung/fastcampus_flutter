import 'package:flutter/material.dart';

class TodaysDiscoveryFragment extends StatelessWidget {
  const TodaysDiscoveryFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 700,
    );
  }

  Widget get myAccount => Placeholder();
  Widget get myStocks => Placeholder();
}
