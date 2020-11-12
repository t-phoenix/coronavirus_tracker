import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/views/CasesAddedTodayByCountry.dart';
import 'package:coronavirus_tracker/views/TotalActiveCasesByCountry.dart';
import 'package:coronavirus_tracker/views/TotalDeathsByCountry.dart';
import 'package:coronavirus_tracker/widgets/card.dart';
import 'package:coronavirus_tracker/views/TotalCasesByCountry.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xff204051),
      title: 'Covid19 Data',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
          title: 'Covid19 Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';
  int _cases ;
  int _active ;
  int _todayCases;
  int _deaths;


  final apiService = APIService(API.sandbox());


  @override
  void initState(){
    super.initState();
    //_getWorldData();
    _getaccessToken();

  }

  void _getaccessToken()async{
    final accessToken = await apiService.getAccessToken();
    setState(() {
      _accessToken = accessToken;
    });

  }



  void _getWorldData() async {
    final cases = await apiService.getEndPointData(accessToken: _accessToken, endpoint: Endpoint.cases);
    final active = await apiService.getEndPointData(accessToken: _accessToken, endpoint: Endpoint.active);
    final todayCases = await apiService.getEndPointData(accessToken: _accessToken, endpoint: Endpoint.todayCases);
    final deaths = await apiService.getEndPointData(accessToken: _accessToken, endpoint: Endpoint.deaths);
    print(cases);
    print(active);
    print(todayCases);
    print(deaths);
    setState(() {
     // _accessToken = accessToken;
      _cases = cases;
      _active = active;
      _todayCases = todayCases;
      _deaths = deaths;

    });

  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff204051),
        title: Text(widget.title),
      ),
      body: Container(
        color: Color(0xff204051),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if(_cases==null)
                DataCard(title: "Press Bottom Right Button",data: 1,),
              if(_cases!=null)
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => TotalCasesByCountry()
                      ));

                    },
                    child: DataCard(title: "Total Positive Cases", data: _cases,)),

              if(_todayCases!=null)
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => CasesAddedTodayByCountry()
                      ));

                    },
                    child: DataCard(title: "Cases Added Today",data: _todayCases,)
                ),

              if(_active!=null)
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => TotalActiveCasesByCountry()
                      ));

                    },
                    child: DataCard(title: "Total Active Cases",data: _active,)
                ),

              if(_deaths!=null)
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => TotalDeathsByCountry()
                      ));

                    },
                    child: DataCard(title: "Total Covid19 Deaths",data: _deaths,)
                ),




            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getWorldData,
        backgroundColor: Color(0xff3b6978),
        tooltip: 'getData',
        child: Icon(Icons.get_app),
      ), // This trailing comma makes auto-frmatting nicer for build methods.

    );
  }
}
