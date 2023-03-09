import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollViewScreen',
      body: renderPerformance(),
    );
  }


  Widget renderContainer({
    required Color color,
  }) {
    return Container(
      height: 300,
      color: color,
    );
  }

  // 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(
            color: e,
          ),
        )
            .toList(),
      ),
    );
  }

  // 화면이 넘어가지 않아도 스크롤
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      // NeverScrollableScrollPhysics() - 스크롤 안되게
      // AlwaysScrollableScrollPhysics() - 스크롤 되게
      // BouncingScrollPhysics - 상단 스크롤 iOS 스타일
      // ClampingScrollPhysics - 상단 고정 스크롤 android 스타일
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // SingleChildScroolView render Performance
  // 한 번에 다 rendering 되기 때문에 주의하기
  Widget renderPerformance(){
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length],
          ),
        )
            .toList(),
      ),
    );
  }
}