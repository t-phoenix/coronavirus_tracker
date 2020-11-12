import 'package:coronavirus_tracker/app/services/api_keys.dart';
import 'package:flutter/cupertino.dart';


enum Endpoint {
  cases,
  todayCases,
  active,
  deaths,

}



class API{
  API({@required this.apikey});
  final String apikey;


  factory API.sandbox() => API(apikey: APIKeys.nCovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi/2.0.0';

  Uri tokenURI() => Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: 'token',
    queryParameters: {'grant_type': 'client_credentials'}
  );


  Uri endpointURI(Endpoint endpoint) => Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: '$basePath/${_paths[endpoint]}',

  );
  //https://apigw.nubentos.com:443/t/nubentos.com/ncovapi/2.0.0/cases

  Uri endpointURIforQuery(Endpoint endpoint, String country) => Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: '$basePath/${_paths[endpoint]}',
    queryParameters: {'country': '$country'}

  );


  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.todayCases: 'todayCases',
    Endpoint.active: 'active',
    Endpoint.deaths: 'deaths',
  };
}