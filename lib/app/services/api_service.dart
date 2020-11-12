import 'dart:convert';

import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class APIService{
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async{
    //final url = 'https://apigw.nubentos.com:443/token?grant_type=client_credentials ';

    //Sends Request First and wait for response
    final response = await http.post(
        api.tokenURI().toString(),
        headers: {'Authorization': 'Basic ${api.apikey}'},

    );
    //This will run on response arrival

    if(response.statusCode == 200){
      final data = json.decode(response.body);
      print(data);
      final accessToken = data['access_token'];
      if(accessToken!=null){
        return accessToken;
      }
    }
    print('request ${api.tokenURI()} failed\n Response: ${response.statusCode} ${response.reasonPhrase}');
    throw response;

  }


  Future<int> getEndPointData({@required String accessToken, @required Endpoint endpoint }) async {
    print("POST REQUEST: endpoint here--> $endpoint");

    final uri = api.endpointURI(endpoint);
    print(uri);
    final response = await http.get(
      uri.toString(),
      headers: {'Accept': 'application/json','Authorization': 'Bearer $accessToken'},
    );


    //JSON PARSING
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      print(data);
      if(data.isNotEmpty){
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _reponseJsonKeys[endpoint];
        final int result = endpointData[responseJsonKey];
        if(result!=null){
          return result;
        }
      }
      else
        print("Empty Data");

    }
    print('request ${api.endpointURI(endpoint)} failed\n Response: ${response.statusCode} ${response.reasonPhrase}');
    throw response;

  }



  Future<int> getEndPointDataForQuery({@required String accessToken, @required Endpoint endpoint, @required String queryCountry}) async {
    print("Country Choses ----> $queryCountry");

    final uri = api.endpointURIforQuery(endpoint, queryCountry);
    print(uri);
    final response = await http.get(
      uri.toString(),
      headers: {'Accept':'application/json', 'Authorization': 'Bearer $accessToken'},
    );

    //JSON PARSING
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode((response.body));
      print(data);
      if(data.isNotEmpty){
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _reponseJsonKeys[endpoint];
        final int result = endpointData[responseJsonKey];
        if(result!=null){
          return result;
        }


      }


    }

    print(' request ${api.endpointURIforQuery(endpoint, queryCountry)} failed  \n  Response: ${response.statusCode}  ${response.reasonPhrase}');
    throw response;



  }

  static Map<Endpoint, String> _reponseJsonKeys = {
    Endpoint.cases : 'data',
    Endpoint.todayCases: 'data',
    Endpoint.active :'data',
    Endpoint.deaths: 'data'
  };








}