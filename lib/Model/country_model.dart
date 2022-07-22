

class CountryModel {
  String? name;
  String? image;
  CountryModel({this.name,
  this.image});
  static List<CountryModel>? allCountries(){
    var vpnServer =  <CountryModel>[];
    vpnServer.add(CountryModel(
      name: 'USA',
      image: 'assets/images/united-state.png'
    ));
    vpnServer.add(CountryModel(
        name: 'UK',
        image: 'assets/images/united-kingdom.png'

    ));
    vpnServer.add(CountryModel(
        name: 'Singapore',
        image: 'assets/images/singapore.png'
    ));
    vpnServer.add(CountryModel(
        name: 'Canada',
        image: 'assets/images/canada.png'
    ));
  }
}