import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_appllication/Authentication/login_register.dart';
import 'package:web_appllication/MenuPage/user.dart';
import 'package:web_appllication/OverviewPages/depot_overview.dart';
import 'package:web_appllication/OverviewPages/detailed_Eng.dart';
import 'package:web_appllication/OverviewPages/quality_checklist.dart';
import 'package:web_appllication/Planning/cities.dart';
import 'package:web_appllication/components/loading_page.dart';
import '../KeyEvents/key_eventsUser.dart';
import '../KeyEvents/view_AllFiles.dart';
import '../OverviewPages/Jmr_screen/jmr.dart';
import '../OverviewPages/closure_summary_table.dart';
import '../OverviewPages/daily_project.dart';
import '../OverviewPages/energy_management.dart';
import '../OverviewPages/material_vendor.dart';
import '../OverviewPages/monthly_summary.dart';
import '../OverviewPages/o&m_dashboard/o&m_dashboard_screen.dart';
import '../OverviewPages/safety_summary.dart';
import '../OverviewPages/sidebar_nav/nav_screen.dart';
import '../Planning/depot.dart';
import '../Planning/overview.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          const LoginRegister());

  static Handler navPagedHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];

        print('UserId: $userId');

        return NavigationPage(
          userId: userId,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;

                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';
                String userId = cityData?['userId'] ?? 'null';
                print('UserId: $userId');

                if (userId != 'null') {
                  // User is logged in, return your widget
                  return NavigationPage(userId: userId);
                } else {
                  // User is not logged in, navigate to login screen
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginRegister()));
                  // Return an empty container or loading widget since you're navigating
                }
              }
              return LoadingPage();
            });
      }
    }
  });

  // Handle the case where modalRoute or modelRoute is null
  // or return some default widget

  static Handler evBusDepotHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          const ONMDashboard());

  static Handler citiesHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          const CitiesPage());

  static Handler userHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          const MenuUserPage());

  static Handler depotHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final cityName = modelRoute['cityName'];

        return Mydepots(cityName: cityName);
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');

                // Return your widget here using userId
                if (userId != 'null') {
                  return Mydepots(cityName: cityName);
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
              }
              return LoadingPage();
            });
      }
    }

    //  Mydepots(
    //   cityName: modelRoute['cityName'],
    //   userId: modelRoute['userId'],
    // );
  });

  static Handler overviewPageHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final cityName = modelRoute['cityName'];

        return MyOverview(
          depoName: modelRoute['depoName'],
          cityName: modelRoute['cityName'],
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';
                if (userId != 'null') {
                  return MyOverview(
                    depoName: depotName,
                    cityName: cityName,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler depotOverviewhandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return DepotOverview(
            userid: userId, cityName: cityName, depoName: depoName);
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  return DepotOverview(
                      userid: userId, cityName: cityName, depoName: depotName);
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
              }

              // Return your widget here using userId

              return LoadingPage();
            });
      }
    }
  });

  static Handler projectPlanninghandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return KeyEventsUser(
          userId: userId,
          cityName: cityName,
          depoName: depoName,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');

                // Return your widget here using userId
                return KeyEventsUser(
                  userId: userId,
                  cityName: cityName,
                  depoName: depotName,
                );
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler materialProcurementhandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return MaterialProcurement(
          userId: userId,
          cityName: cityName,
          depoName: depoName,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');

                if (userId != 'null') {
                  // Return your widget here using userId
                  return MaterialProcurement(
                    userId: userId,
                    cityName: cityName,
                    depoName: depotName,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler dailyProgressthandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return DailyProject(
          userId: userId,
          cityName: cityName,
          depoName: depoName,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  return DailyProject(
                    userId: userId,
                    cityName: cityName,
                    depoName: depotName,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler monthlyProgressthandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return MonthlySummary(
          userId: userId,
          cityName: cityName,
          depoName: depoName,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != null) {
                  return MonthlySummary(
                    userId: userId,
                    cityName: cityName,
                    depoName: depotName,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler detailEngthandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return DetailedEng(
            cityName: cityName, depoName: depoName, userId: userId);
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  // Return your widget here using userId
                  return DetailedEng(
                    cityName: cityName,
                    depoName: depotName,
                    userId: userId,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler jmrhandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return Jmr(
          userId: userId,
          cityName: cityName,
          depoName: depoName,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  return Jmr(
                    userId: userId,
                    cityName: cityName,
                    depoName: depotName,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler safetyChecklisthandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return SafetySummary(
          userId: userId,
          depoName: depoName,
          cityName: cityName,
          id: 'Safety Report',
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  return SafetySummary(
                    userId: userId,
                    depoName: depotName,
                    cityName: cityName,
                    id: 'Safety Report',
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }

                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler qualityChecklisthandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return QualityChecklist(
          cityName: cityName,
          depoName: depoName,
          userId: userId,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  return QualityChecklist(
                    cityName: cityName,
                    depoName: depotName,
                    userId: userId,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler depotinsighteshandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return ViewAllPdf(
            title: 'Overview Page',
            cityName: cityName,
            depoName: depoName,
            docId: 'OverviewepoImages');
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  return ViewAllPdf(
                      title: 'Overview Page',
                      cityName: cityName,
                      depoName: depotName,
                      docId: 'OverviewepoImages');
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
                // Return your widget here using userId
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler closureReporthandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return ClosureSummaryTable(
          userId: userId,
          // userId: widget.userid,
          cityName: cityName,
          depoName: depoName,
          id: 'Closure Report',
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');

                if (userId != 'null') {
                  // Return your widget here using userId
                  return ClosureSummaryTable(
                    userId: userId,
                    // userId: widget.userid,
                    cityName: cityName,
                    depoName: depotName,
                    id: 'Closure Report',
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Return an empty container or loading widget since you're navigating
                }
              }
              return LoadingPage();
            });
      }
    }
  });

  static Handler demandEnergyhandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    ModalRoute? modalRoute = ModalRoute.of(context!);

    if (modalRoute != null) {
      Map<String, dynamic>? modelRoute =
          modalRoute.settings.arguments as Map<String, dynamic>?;

      if (modelRoute != null) {
        final userId = modelRoute['userId'];
        final cityName = modelRoute['cityName'];
        final depoName = modelRoute['depoName'];

        return EnergyManagement(
          // userId: widget.userId,
          cityName: cityName,
          depoName: depoName,
        );
      } else {
        return FutureBuilder<Map<String, dynamic>?>(
            future: _getCityDataFromSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Do something with userId
                Map<String, dynamic>? cityData = snapshot.data;
                String userId = cityData?['userId'] ?? 'null';
                String cityName = cityData?['cityName'] ?? 'defaultCityName';
                String depotName = cityData?['depotName'] ?? 'defaultDepotName';

                print('CityName: $cityName, DepotName: $depotName');
                if (userId != 'null') {
                  // Return your widget here using userId
                  return EnergyManagement(
                    // userId: widget.userId,
                    cityName: cityName,
                    depoName: depotName,
                  );
                } else {
                  // User is not logged in, navigate to login screen
                  return LoginRegister();
                  // Future.microtask(() {
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => const LoginRegister(),
                  //   ));
                  // });
                  // Return an empty container or loading widget since you're navigating
                }
              }
              return LoadingPage();
            });
      }
    }
  });

  static void setupRouter() {
    router.define(
      'login',
      handler: loginHandler,
    );
    router.define('login/EVDashboard', handler: navPagedHandler);
    router.define('login/EVDashboard/Cities', handler: citiesHandler);
    router.define('login/EVDashboard/Cities/EVBusDepot', handler: depotHandler);
    router.define('login/EVDashboard/Cities/EVBusDepot/overviewpage',
        handler: overviewPageHandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/OverviewPage/DepotOverview',
        handler: depotOverviewhandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/ProjectPlanning',
        handler: projectPlanninghandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/MaterialProcurement',
        handler: materialProcurementhandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DailyProgress',
        handler: dailyProgressthandler);

    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/MonthlyProgress',
        handler: monthlyProgressthandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DetailedEngineering',
        handler: detailEngthandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/Jmr',
        handler: jmrhandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/SafetyChecklist',
        handler: safetyChecklisthandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/QualityChecklist',
        handler: qualityChecklisthandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DepotInsightes',
        handler: depotinsighteshandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/ClosureReport',
        handler: closureReporthandler);
    router.define(
        'login/EVDashboard/Cities/EVBusDepot/EVBusDepot/OverviewPage/DemandEnergy',
        handler: demandEnergyhandler);
  }

  // static Future<String?> _getUserIdFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString('employeeId');
  //   return userId;
  // }

  static Future<Map<String, dynamic>?>?
      _getCityDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('employeeId');
    String? cityName = prefs.getString('cityName');
    String? depotName = prefs.getString('depotName');

    return {'userId': userId, 'cityName': cityName, 'depotName': depotName};
  }

  // FutureBuilder<Map<String, dynamic>?> _yourCustomMethod(Widget pageName) {
  //   return FutureBuilder<Map<String, dynamic>?>(
  //     future: _getCityDataFromSharedPreferences(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         // Do something with userId
  //         Map<String, dynamic>? cityData = snapshot.data;

  //         String cityName = cityData?['cityName'] ?? 'defaultCityName';
  //         String depotName = cityData?['depotName'] ?? 'defaultDepotName';

  //         print('CityName: $cityName, DepotName: $depotName');

  //         // Return your widget here using userId
  //         return MyOverview(
  //           depoName: depotName,
  //           cityName: cityName,
  //         );
  //       }
  //       return LoadingPage();
  //     },
  //   );
  // }
}
