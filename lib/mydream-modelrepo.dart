import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

class MyDreamModel with ChangeNotifier {
  //-----iap -----//
  List<String> storyIDs = ["mydream.hare", "mydream.hedgehog"];
  List<String> purchasedStories = [];

  /// Is the API available on the device
  bool _available = true;

  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  // List<PurchaseDetails> _purchases = [];

  /// Updates to purchases
  StreamSubscription<List<PurchaseDetails>> iapsub;

  bool hareLocked = true;
  bool hedgehogLocked = true;
  bool iapInitialized = false;

  Database userdb;
  List<dynamic> purchasesdb = [];

  // PurchaseDetails testConsumeDetails;

  /* void testConsume() async{
    if(!iapInitialized){
      await initializeIAP();
    }
    await _iap.consumePurchase(testConsumeDetails);
    print("purchase consumed");
    hedgehogLocked = true;
    updateDBPurchases();
  } */

  @override
  void dispose() {
    if (iapInitialized) {
      iapsub.cancel();
    }
    super.dispose();
  }

  void purchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          if (purchaseDetails.productID == "mydream.hare") {
            hareLocked = false;
          } else if (purchaseDetails.productID == "mydream.hedgehog") {
            hedgehogLocked = false;
          }

          updateDBPurchases();

          notifyListeners();
        }

        if (purchaseDetails.pendingCompletePurchase) {
          // print("pending completion");
          await _iap.completePurchase(purchaseDetails);
          // print("purchase completed");
        }
      }
    });
  }

  /// Initialize data
  void initializeDB() async {
    // print('db init');
    var directory = await getApplicationDocumentsDirectory();

    String dbPath = directory.path + '/userdata.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    userdb = await dbFactory.openDatabase(dbPath);

    var user = getFromDB('user');

    if (user == null) {
      // print("new user");
      setInDB('user', true);
      // print("user created");
    } else {
      // print("old user");

      getDBPurchases();
    }
  }

  Future getFromDB(key) async {
    var store = StoreRef.main();

    var value = await store.record(key).get(userdb);
    return value;
  }

  Future setInDB(key, value) async {
    var store = StoreRef.main();

    await store.record(key).put(userdb, value);
    return true;
  }

  void getDBPurchases() async {
    var store = StoreRef.main();
    purchasesdb = await store.record('purchases').get(userdb);

    if (purchasesdb == null) {
      purchasesdb = [];
    } else {
      for (var purchaseObject in purchasesdb) {
        if (purchaseObject['hare'] == false) {
          hareLocked = false;
        } else if (purchaseObject['hedgehog'] == false) {
          hedgehogLocked = false;
        }
      }
    }

    notifyListeners();
  }

  Future updateDBPurchases() async {
    List userPurchases = [];
    userPurchases.add({"hare": hareLocked});
    userPurchases.add({"hedgehog": hedgehogLocked});

    var store = StoreRef.main();

    await store.record('purchases').put(userdb, userPurchases);

    return true;
  }

  Future initializeIAP() async {
    print('iap initialize');

    // Listen to new purchases
    iapsub = _iap.purchaseUpdatedStream.listen((purchaseDetailsList) {
      purchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      iapsub.cancel();
    }, onError: (error) {
      print("in app purchase error");
      print(error.toString());
    });

    _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      // Verify and deliver a purchase with your own business logic
      // _verifyPurchase();

    } else {
      iapInitialized = true;
      return false;
    }

    iapInitialized = true;
    return true;
  }

  String getProductTitle(String storyID) {
    String productTitle = "";
    for (var i = 0; i < _products.length; i++) {
      if (storyID == _products[i].id) {
        productTitle = _products[i].title;

        productTitle = productTitle.replaceAll("(MyDream)", "");
      }
    }

    return productTitle;
  }

  String getProductDescription(String storyID) {
    for (var i = 0; i < _products.length; i++) {
      if (storyID == _products[i].id) {
        String desc = _products[i].description.replaceAll("\n", "");
        return desc;
      }
    }

    return "";
  }

  String getProductPrice(String storyID) {
    for (var i = 0; i < _products.length; i++) {
      if (storyID == _products[i].id) {
        return _products[i].price;
      }
    }

    return "";
  }

  /// Get all products available for sale
  Future<void> _getProducts() async {
    Set<String> ids = Set.from(storyIDs);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    if (response.error != null) {
      print("get products error " + response.error.message);
    } else if (response.productDetails.isEmpty) {
      print("get products is empty");
    } else {
      _products = response.productDetails;
    }
  }

  /// Gets past purchases
  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();

    if (response.error != null) {
      print("get past purchases error " + response.error.message);
    } else {
      for (PurchaseDetails purchase in response.pastPurchases) {
        if (purchase.productID == "mydream.hare") {
          hareLocked = false;
        } else if (purchase.productID == "mydream.hedgehog") {
          hedgehogLocked = false;
          // testConsumeDetails = purchase;
        }
      }

      notifyListeners();
    }
  }

  /// Purchase a product
  void purchaseProduct(String itemID) {
    ProductDetails prod;
    for (var prodItem in _products) {
      if (prodItem.id == itemID) {
        prod = prodItem;
        break;
      }
    }

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: prod, applicationUserName: null, sandboxTesting: true);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }
}
