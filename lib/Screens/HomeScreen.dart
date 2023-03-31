import 'dart:convert';

import 'package:covid_19_app/Model/WorldStateModel.dart';
import 'package:covid_19_app/Screens/CountriesScreen.dart';
import 'package:covid_19_app/ViewModel/Utilities/reusableRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Future<WorldStateModel> getWorldStateApi() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Some thing went wrong');
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> colorList = [Colors.yellow, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('All World Records'),
        backgroundColor: Colors.grey[300],

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),


              FutureBuilder<WorldStateModel>(
                  future: getWorldStateApi(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitWave(
                          color: Colors.black,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              animationDuration: Duration(milliseconds: 1200),
                              chartLegendSpacing: 32,
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 25,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: true,
                                decimalPlaces: 1,
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              width: double.infinity * 0.89,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow:[
                                    BoxShadow(
                                        offset: Offset(5, 5),
                                        color: Colors.grey.shade500,
                                        blurRadius: 15),
                                    BoxShadow(
                                        offset: Offset(-5, -5),
                                        color: Colors.grey.shade100,
                                        blurRadius: 15),
                                  ]),
                              child: Column(
                                children: [
                                  ReusableRow(
                                      name: 'Updated',
                                      number: snapshot.data!.updated.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Cases',
                                      number: snapshot.data!.cases.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Today Cases',
                                      number: snapshot.data!.todayCases.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Deaths',
                                      number: snapshot.data!.deaths.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Today Deaths',
                                      number: snapshot.data!.todayDeaths.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Recoverd',
                                      number: snapshot.data!.recovered.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Today Recoverd',
                                      number: snapshot.data!.active.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Active',
                                      number: snapshot.data!.recovered.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReusableRow(
                                      name: 'Critical',
                                      number: snapshot.data!.critical.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  ReusableRow(
                                      name: 'Tests',
                                      number: snapshot.data!.tests.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  ReusableRow(
                                      name: 'Population',
                                      number: snapshot.data!.population.toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  ReusableRow(
                                      name: 'Affected Countries',
                                      number: snapshot.data!.affectedCountries
                                          .toString()),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black54,
                                  ),


                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesScreen()));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration:BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow:[
                                      BoxShadow(
                                          offset: Offset(5, 5),
                                          color: Colors.grey.shade500,
                                          blurRadius: 15),
                                      BoxShadow(
                                          offset: Offset(-5, -5),
                                          color: Colors.grey.shade100,
                                          blurRadius: 15),
                                    ]),
                                child: Center(child: Text('A L L - C O U N T R I E S', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),


            ],
          ),
        ),
      ),
    );
  }
}
