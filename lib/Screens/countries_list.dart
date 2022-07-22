import 'package:flutter/material.dart';
import 'package:vpn_app/Model/country_model.dart';

class CountriesFlags extends StatefulWidget {
  const CountriesFlags({Key? key}) : super(key: key);

  @override
  State<CountriesFlags> createState() => _CountriesFlagsState();
}

class _CountriesFlagsState extends State<CountriesFlags> {
  final List<CountryModel>? _countryModel = CountryModel.allCountries();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _countryModel?.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    '${_countryModel![index].name}'
                  ),
                  Image.asset('${_countryModel![index].image}')

                ],
              )
            ],
          );
        }
    );
  }
}
