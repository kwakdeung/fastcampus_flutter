import 'package:todo_statemanagement/common/common.dart';
import 'package:todo_statemanagement/screen/main/tab/stock/setting/w_os_switch.dart';
import 'package:flutter/material.dart';

class SwitchMenu extends StatelessWidget {
  final String title;
  final bool isOn;
  final void Function(bool isOn) onChanged;

  const SwitchMenu(this.title, this.isOn, {super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        title.text.bold.make(),
        emptyExpanded,
        OsSwitch(value: isOn, onChanged: onChanged),
      ],
    ).p20();
  }
}
