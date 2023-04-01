import 'package:air_pollution/component/card_title.dart';
import 'package:air_pollution/component/category_card.dart';
import 'package:air_pollution/component/hourly_card.dart';
import 'package:air_pollution/component/main_app_bar.dart';
import 'package:air_pollution/component/main_card.dart';
import 'package:air_pollution/component/main_drawer.dart';
import 'package:air_pollution/model/stat_model.dart';
import 'package:air_pollution/repository/stat_repository.dart';
import 'package:air_pollution/screen/const/colors.dart';
import 'package:air_pollution/screen/const/data.dart';
import 'package:air_pollution/screen/const/status_level.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();

    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // hamberger bar
      drawer: MainDrawer(),
      body: FutureBuilder<List<StatModel>>(
        future: fetchData(),
        builder: (context, snapshat) {
          if (snapshat.hasError) {
            return Center(
              child: Text('에러가 있습니다.'),
            );
          }

          if (!snapshat.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<StatModel> stats = snapshat.data!;
          StatModel recentStat = stats[0];

          final status = statusLevel.where(
            (element) => element.minFineDust < recentStat.seoul,
          ).last;

          return CustomScrollView(
            slivers: [
              MainAppBar(
                stat: recentStat,
                status: status,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CategoryCard(),
                    const SizedBox(height: 16.0),
                    HourlyCard(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
