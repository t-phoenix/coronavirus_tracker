import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/services/api_service.dart';
import 'package:coronavirus_tracker/modal/CardData.dart';
import 'package:coronavirus_tracker/widgets/DropDown.dart';
import 'package:coronavirus_tracker/widgets/card.dart';
import 'package:flutter/material.dart';

class CasesAddedTodayByCountry extends StatefulWidget {


  @override
  _CasesAddedTodayByCountryState createState() => _CasesAddedTodayByCountryState();
}

class _CasesAddedTodayByCountryState extends State<CasesAddedTodayByCountry> {



  List<String> _countries = <String>["World", "USA", "India", "Spain", "Italy", "UK", "France", "Germany", "Turkey", "Russia", "Iran", "Brazil", "Canada", "Belgium", "Netherlands", "Peru", "Switzerland", "Pakistan", "Singapore", "Japan", "Indonesia", "bangladesh"];

  String _currentSelectedCountry= '';
  String _accessToken = '';
  int _cases ;

  List<CardData> _casedatalist =<CardData>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getaccessToken();


  }


  //API connection start here
  final apiService = APIService(API.sandbox());

  void _getaccessToken()async{
    final accessToken = await apiService.getAccessToken();
    setState(() {
      _accessToken = accessToken;
    });

  }



  //get cases function here
  void _getTotalCasesDataByCountry()async{
    final cases = await apiService.getEndPointDataForQuery(accessToken: _accessToken, endpoint: Endpoint.todayCases, queryCountry: _currentSelectedCountry);
    print(cases);
    setState(() {
      _cases = cases;
      _casedatalist.add(CardData(title: _currentSelectedCountry, data: _cases));
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cases ADDED TODAY in a  country", style: TextStyle(fontSize: 16),),
        backgroundColor: Color(0xff204051),
      ),

      //DROPDOWN button here
      body: Container(
        alignment: Alignment.center,
        color: Color(0xff204051),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[

            DropDown(title: _countries,onChanged: (value){
              setState(() {
                _currentSelectedCountry= value;
              });
            },),


            // Text representation of country selcted
            Container(

                padding: EdgeInsets.all(1),


                alignment:Alignment.center,
                child:  Text(_currentSelectedCountry, style: TextStyle(color: Colors.white, fontSize: 12),) ),


            //Cards should start here
            Container(
              height: MediaQuery.of(context).size.height,
              //child: _casedatalist.isEmpty ?
              //SizedBox(height: 10, width: 10,):
              child:ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _casedatalist.length,
                  itemBuilder: (BuildContext context, int index){
                    return DataCard(title: _casedatalist[index].title, data:  _casedatalist[index].data,);
                  }),
            ),

            /*if(_cases!=null)
              DataCard(title: _currentSelectedCountry, data:  _cases,),*/
          ],
        ),

      ),
      bottomNavigationBar: FloatingActionButton(
        onPressed: _getTotalCasesDataByCountry,
        backgroundColor: Color(0xff3b6978),
        tooltip: 'getData',
        child: Icon(Icons.get_app),
      ),

    );
  }
}
