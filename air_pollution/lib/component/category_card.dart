import 'package:air_pollution/component/card_title.dart';
import 'package:air_pollution/component/main_card.dart';
import 'package:air_pollution/component/main_stat.dart';
import 'package:air_pollution/model/stat_and_status_model.dart';
import 'package:air_pollution/const/colors.dart';
import 'package:air_pollution/utils/data_utils.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final List<StatAndStatusModel> models;

  const CategoryCard({
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                backgroundColor: darkColor,
                title: '종류별 통계',
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) => MainStat(
                          width: constraint.maxWidth / 3,
                          category: DataUtils.getItemCodeKrString(
                              itemCode: model.itemCode),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat: '${model.stat.getLevelFromRegion(
                            region,
                          )}${DataUtils.getUnitFromItemCode(
                            itemCode: model.itemCode,
                          )}',
                        ),
                      )
                      .toList(),
                  // children: List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //     width: constraint.maxWidth / 3,
                  //     category: '미세먼지${index}',
                  //     imgPath: 'asset/img/best.png',
                  //     level: '최고',
                  //     stat: '0㎍/㎥',
                  //   ),
                  // ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
