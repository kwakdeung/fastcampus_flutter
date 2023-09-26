import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/data/preference/prefs.dart';
import 'package:fast_app_base/common/widget/w_big_button.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/d_number.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_animated_app_bar.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_switch_menu.dart';
import 'package:fast_app_base/screen/opensource/s_opensource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: 2000.ms);

  @override
  void initState() {
    animationController.addListener(() {
      final status = animationController.status;
      switch (status) {
        case AnimationStatus.forward:
        case AnimationStatus.reverse:
        case AnimationStatus.completed:
        case AnimationStatus.dismissed:
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 150),
            children: [
              Obx(
                () => SwitchMenu(
                  '푸시 설정',
                  Prefs.isPushOnRx.get(),
                  onChanged: (isOn) {
                    Prefs.isPushOnRx.set(isOn);
                  },
                ),
              ),
              Obx(() => Slider(
                  value: Prefs.sliderPosition.get(),
                  onChanged: (value) {
                    animationController.animateTo(value, duration: 0.ms);
                    Prefs.sliderPosition.set(value);
                  })),
              Obx(
                () => BigButton(
                  text:
                      '날짜 ${Prefs.birthday.get() == null ? "" : Prefs.birthday.get()?.formattedDate}',
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(90.days),
                        lastDate: DateTime.now().add(90.days));
                    if (date != null) {
                      Prefs.birthday.set(date);
                    }
                  },
                ),
              ),
              Obx(
                () => BigButton(
                  text: '저장된 숫자 ${Prefs.number.get()}',
                  onTap: () async {
                    final number = await NumberDialog().show();
                    if (number != null) {
                      Prefs.number.set(number);
                    }
                  },
                ),
              ),
              BigButton(
                text: '오픈소스 화면',
                onTap: () async {
                  Nav.push(const OpensourceScreen());
                },
              ),
              BigButton(
                text: '애니메이션 forward',
                onTap: () async {
                  animationController.forward();
                },
              ),
              BigButton(
                text: '애니메이션 reverse',
                onTap: () async {
                  animationController.reverse();
                },
              ),
              BigButton(
                text: '애니메이션 repeat',
                onTap: () async {
                  animationController.repeat();
                },
              ),
              BigButton(
                text: '애니메이션 reset',
                onTap: () async {
                  animationController.reset();
                },
              ),
              BigButton(
                text: '오픈소스 화면',
                onTap: () async {
                  Nav.push(const OpensourceScreen());
                },
              ),
              BigButton(
                text: '오픈소스 화면',
                onTap: () async {
                  Nav.push(const OpensourceScreen());
                },
              ),
              BigButton(
                text: '오픈소스 화면',
                onTap: () async {
                  Nav.push(const OpensourceScreen());
                },
              ),
              BigButton(
                text: '오픈소스 화면',
                onTap: () async {
                  Nav.push(const OpensourceScreen());
                },
              ),
              BigButton(
                text: '오픈소스 화면',
                onTap: () async {
                  Nav.push(const OpensourceScreen());
                },
              ),
            ],
          ),
          AnimatedAppBar(
            '설정',
            scrollController: scrollController,
            animationController: animationController,
          ),
        ],
      ),
    );
  }
}
