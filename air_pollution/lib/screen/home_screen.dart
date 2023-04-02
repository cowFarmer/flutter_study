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
import 'package:air_pollution/screen/const/regions.dart';
import 'package:air_pollution/screen/const/status_level.dart';
import 'package:air_pollution/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    for (ItemCode itemCode in ItemCode.values) {
      final statModels = await StatRepository.fetchData(
        itemCode: itemCode,
      );

      // stats[ItemCode.PM10]
      stats.addAll({
        itemCode: statModels,
      });
    }
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // hamberger bar
      drawer: MainDrawer(
        selectedRegion: region,
        onRegionTap: (String region) {
          setState(() {
            this.region = region;
          });
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
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

          Map<ItemCode, List<StatModel>> stats = snapshat.data!;
          StatModel pM10recentStat = stats[ItemCode.PM10]![0];

          final status = DataUtils.getStatusFromItemCodeAndValue(
            value: pM10recentStat.seoul,
            itemCode: ItemCode.PM10,
          );

          return CustomScrollView(
            slivers: [
              MainAppBar(
                region: region,
                stat: pM10recentStat,
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
