import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '9A8E8FEB-2C64-4582-AE4C-9D3A05A50DA6';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //TODO 5: Return a Map of the results instead of a single value.

    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/BTC$selectedCurrency';

      var uri = Uri.http('rest.coinapi.io', '/v1/exchangerate/BTC/', {
        '': '$selectedCurrency',
        'apikey': '$apiKey'
      });

      print(uri);

      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        return lastPrice;
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}


