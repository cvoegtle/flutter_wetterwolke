import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wetterwolke/configuration.dart';

void main() {
  test('diagram configuration derialisation', () {
    Map<String, dynamic> json = {
      'description': 'Hallo Christian',
      'url': 'https://www.voegtle.org/~christian'
    };
    var diagram = DiagramConfiguration.fromJson(json);
    expect('Hallo Christian', diagram.description);
    expect('https://www.voegtle.org/~christian', diagram.url);

    var json2 = diagram.toJson();
    expect(json, json2);
  });

  test('location configuration deserialisation', () {
    var jsonString =
        '{"location": "herzo","city": "Herzogenaurach","cityShortcut": "HZA","weatherForecast": "http://wetterstationen.meteomedia.de/?station=194919&wahl=vorhersage","windRelevant": true,"diagrams": [{"description": "7 Tage","url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1655654633&format=image"},{"description": "Wind","url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1843697553&format=image"},{"description": "30 Tage","url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=951457656&format=image"},{"description": "Vor einem Jahr","url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=2068675477&format=image"}]}';
    var json = jsonDecode(jsonString);
    var location = LocationConfiguration.fromJson(json);
    expect(4, location.diagrams.length);
    expect("Vor einem Jahr", location.diagrams[3].description);
  });

  test('configuration deserialisation', () {
    var jsonString =
        '{        "diagrams": [  {  "description": "PB-BN-FR",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=291472484&format=image"  },  {  "description": "OWL",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=738029596&format=image"  },  {  "description": "Familienwetter",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1089204796&format=image"  },  {  "description": "Durchschnitt",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1780492499&format=image"  },  {  "description": "Sommer 2019",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1460370869&format=image"  },  {  "description": "Sommer 2018",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1617791090&format=image"  },  {  "description": "Winter 2018/19",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=2026888598&format=image"  },  {  "description": "Winter 2017/18",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=170000012&format=image"  },  {  "description": "Regen",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=477091892&format=image"  }  ],  "locations": [  {  "location": "tegelweg8",  "city": "Paderborn",  "cityShortcut": "PB",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=104300&wahl=vorhersage",  "windRelevant": false,  "diagrams": [  {  "description": "2 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=426012227&format=image"  },  {  "description": "Sonneneinstrahlung",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=443476029&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=183626445&format=image"  },  {  "description": "Jahresverlauf",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=747368525&format=image"  },  {  "description": "Der gleiche Tage vor einem Jahr",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=2118924146&format=image"  }  ]  },  {  "location": "bali",  "city": "Bad Lippspringe",  "cityShortcut": "BaLi",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=104300&wahl=vorhersage",  "windRelevant": true,  "diagrams": [  {  "description": "7 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=376041681&format=image"  },  {  "description": "Luftfeuchtigkeit",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1408859930&format=image"  },  {  "description": "Wind",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1959064763&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1067873495&format=image"  },  {  "description": "Vergleich mit Paderborn",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1754363161&format=image"  },  {  "description": "Vor einem Jahr",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=583402693&format=image"  }  ]  },  {  "location": "leoxity",  "city": "Leopoldshöhe",  "cityShortcut": "Leo",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=103250&wahl=vorhersage",  "windRelevant": true,  "diagrams": [  {  "description": "7 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1205500547&format=image"  },  {  "description": "Wind",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=75598496&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1610295076&format=image"  },  {  "description": "Vor einem Jahr",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=322622774&format=image"  },  {  "description": "Solarproduktion",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=255192281&format=image"  },  {  "description": "Tagesproduktion",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1485103805&format=image"  },  {  "description": "Monatsproduktion",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1189452944&format=image"  }  ]  },  {  "location": "forstweg17",  "city": "Bonn",  "cityShortcut": "BN",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=105170&wahl=vorhersage ",  "windRelevant": true,  "diagrams": [  {  "description": "2 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=529970705&format=image"  },  {  "description": "Wind",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=914845123&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1771661938&format=image"  },  {  "description": "Jahresverlauf",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=2014590801&format=image"  },  {  "description": "Vor einem Jahr",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1706278998&format=image"  }  ]  },  {  "location": "elb",  "city": "Magdeburg",  "cityShortcut": "MD",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=103610&wahl=vorhersage",  "windRelevant": false,  "diagrams": [  {  "description": "7 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=2090578754&format=image"  },  {  "description": "Luftfeuchtigkeit",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=808641441&format=image"  },  {  "description": "MD-PB-FR",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=439313787&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=446471860&format=image"  }  ]  },  {  "location": "herzo",  "city": "Herzogenaurach",  "cityShortcut": "HZA",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=194919&wahl=vorhersage",  "windRelevant": true,  "diagrams": [  {  "description": "7 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1655654633&format=image"  },  {  "description": "Wind",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1843697553&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=951457656&format=image"  },  {  "description": "Vor einem Jahr",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=2068675477&format=image"  }  ]  },  {  "location": "ochsengasse",  "city": "Freiburg",  "cityShortcut": "FR",  "weatherForecast": "http://wetterstationen.meteomedia.de/?station=108030&wahl=vorhersage",  "windRelevant": true,  "diagrams": [  {  "description": "2 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=145042526&format=image"  },  {  "description": "Wind",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1045869484&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1650739963&format=image"  },  {  "description": "Jahresverlauf",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1963429675&format=image"  },  {  "description": "Vor einem Jahr",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1557105940&format=image"  }  ]  },  {  "location": "instant",  "city": "Irgendwo in Deutschland",  "cityShortcut": "MO",  "weatherForecast": "",  "windRelevant": false,  "diagrams": [  {  "description": "7 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1380559031&format=image"  }  ]  },  {  "location": "shenzhen",  "city": "Shenzen",  "cityShortcut": "SZ",  "weatherForecast": "http://www.wetter.com/china/shenzhen/CN0GD0012.html",  "windRelevant": false,  "diagrams": [  {  "description": "7 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=2&oid=1981128132&format=image"  },  {  "description": "30 Tage",  "url": "https://wetterimages.appspot.com/weatherstation/image?sheet=1&oid=1526059248&format=image"  }  ]  }  ]}';
    var json = jsonDecode(jsonString);
    var configuration = Configuration.fromJson(json);
    expect(9, configuration.diagramsOverall.length);
    expect("OWL", configuration.diagramsOverall[1].description);
    
    expect(9, configuration.locations.length);
    expect("Bad Lippspringe", configuration.locations[1].city);
    
    var json2 = configuration.toJson();
    expect(json, json2);
    var jsonString1 = jsonEncode(json);
    var jsonString2 = jsonEncode(json2);
    expect(jsonString1, jsonString2);
  });
  
}
