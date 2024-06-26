import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../widgets/chart.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cardData = [
      {"title": "Climate", "subtitle": "20˚c"},
      {"title": "Lights", "subtitle": "2 on"},
      {"title": "Security", "subtitle": "3/4 CCTV"},
      {"title": "Humidity", "subtitle": "30˚c"},
      {"title": "AQI", "subtitle": "Good"},
      // Add more card data as needed
    ];
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              Container(
                  padding: EdgeInsets.only(right: sx(20)),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/41008271?v=4'),
                  )),
            ],
            title: const Text(
              'Smart Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(sx(15)),
            child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: sy(55),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cardData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            width: sx(150), // Set the desired width
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cardData[index]['title']!,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(cardData[index]['subtitle']!,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: sy(10),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Quick Access',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: sy(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // crossAxisCount: 2,
                      //crossAxisSpacing: sx(10),
                      //    mainAxisSpacing: sy(5),
                      children: [
                        Container(
                          width: sx(230),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [0.0, 0.2, 0.95],
                                colors: [
                                  Color.fromRGBO(66, 124, 231, 1),
                                  Color.fromRGBO(80, 130, 224, 1.0),
                                  Color.fromRGBO(89, 131, 211, 1.0),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Switch(
                                    activeColor: Colors.white,
                                    value: controller.doorLocker.value,
                                    onChanged: (value) =>
                                        {controller.doorLocker.value = value},
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Locked',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 12),
                                ),
                                const Text(
                                  'Door Locker',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: sx(230),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Switch(
                                    activeColor:
                                        const Color.fromRGBO(89, 131, 211, 1.0),
                                    value: controller.gateLocker.value,
                                    onChanged: (value) =>
                                        {controller.gateLocker.value = value},
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Unlocked',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                                const Text(
                                  'Gate Locker',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8))),
                      child:  ListTile(
                        title: Text(
                          'Energy Consumption',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                            padding:  EdgeInsets.only(top: 18.0),
                            child: Obx(() => Container(
                              child: DropdownButton<String>(
                                value: controller.day.value,
                                onChanged: (String? newValue) {
                                  controller.day.value = newValue!;
                                },
                                items: <String>[
                                  'Today',
                                  'Yesterday',

                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(

                                    value: value,
                                    child: Text(
                                      value,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ))),
                      )),
                  SizedBox(
                      height: 250,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: LineChartSample4()))
                ]),
          ));
    });
  }
}
