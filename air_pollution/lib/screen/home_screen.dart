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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    final statModels = await StatRepository.fetchData();

    print(statModels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // hamberger bar
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
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
      ),
    );
  }
}
