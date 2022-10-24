import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/model/movie_booking_model.dart';
import 'package:movie_booking_app/data/model/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/snack_category_list_vo.dart';
import 'package:movie_booking_app/data/vos/snack_item_vo.dart';
import 'package:movie_booking_app/resourses/colors_resources.dart';
import 'package:movie_booking_app/user_target_pages/check_out_page.dart';
import 'package:movie_booking_app/wigets/quantity_price_controller.dart';

class FoodAndDrinksPage extends StatefulWidget {
  int? movieId;
  int foodTab;
  int? cinemaIndex;
  String? showTime;
  String dateForCheckOut;
  String dateFormat;
  int? cinemaDayTimeSlotId;
  FoodAndDrinksPage({
    this.foodTab = 0,
    required this.movieId,
    required this.cinemaIndex,
    required this.showTime,
    required this.dateForCheckOut,
    required this.dateFormat,
    required this.cinemaDayTimeSlotId,
  });

  @override
  State<FoodAndDrinksPage> createState() => _FoodAndDrinksPageState();
}

MovieBookingModel mModel = MovieBookingModelImpl();
SelectedSnackController snackController = SelectedSnackController();

class _FoodAndDrinksPageState extends State<FoodAndDrinksPage> {
  List<SnackCategoryVO?>? snackCategoryList;
  List<SnackVO?>? snackItemList;

  @override
  void initState() {
    super.initState();
    _getSnacksAllDataBase();

    //_getSnackForAll();

    /// Network Snack Category
    // mModel.getSnackCategory()?.then((response) {
    //   setState(() {
    //     snackCategoryList = response?.data;
    //   });
    // });

    /// DataBase Snack Category
    mModel.getSnackCategoryDataBase()?.then((snackCategories) {
      setState(() {
        snackCategoryList = snackCategories;
      });
    });
  }

  /// Network SnackByCategory
  // void _getSnacksBySnackCategory(int? categoryId) {
  //   mModel.getSnack(categoryId)?.then((response) {
  //     setState(() {
  //       snackItemList = response?.data;
  //     });
  //   });
  // }

  /// DataBaseSnacksAll
  void _getSnacksAllDataBase() {
    mModel.getSnacksDataBase()?.then((snacks) {
      setState(() {
        snackItemList = snacks;
      });
    });
  }

  /// Network SnackAll
  // void _getSnackForAll() {
  //   mModel.getSnackForAll()?.then((response) {
  //     setState(() {
  //       snackItemList = response?.data;
  //     });
  //   });
  // }

  List<Tab> _createTabs() {
    List<Tab> tabs = [
      Tab(
        text: "All",
      )
    ];
    tabs.addAll(snackCategoryList
            ?.map((snackCategory) => Tab(
                  text: snackCategory?.title,
                ))
            .toList() ??
        []);
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _createTabs().length,
      child: Scaffold(
        bottomNavigationBar: FoodCheckOutTotalView(
          cinemaDayTimeSlotId: widget.cinemaDayTimeSlotId,
          showTime: widget.showTime,
          cinemaIndex: widget.cinemaIndex,
          movieId: widget.movieId,
          dateForCheckOut: widget.dateForCheckOut,
          dateFormat: widget.dateFormat,
          snackController: snackController,
          onTapMinus: () {
            setState(() {});
          },
          onTapPlus: () {
            setState(() {});
          },
        ),
        backgroundColor: HOME_PAGE_BACKGROUND_ONE,
        appBar: AppBar(
          backgroundColor: HOME_PAGE_BACKGROUND_ONE,
          leadingWidth: 60,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 26,
            ),
          ),
          title: Text(
            "Grab a bite!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            Icon(
              Icons.search,
              size: 36,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutPage(
                              cinemaDayTimeSlotId: widget.cinemaDayTimeSlotId,
                              dateFormat: widget.dateFormat,
                              movieId: widget.movieId,
                              cinemaIndex: widget.cinemaIndex,
                              showTime: widget.showTime,
                              snackController: snackController,
                              dateForCheckOut: widget.dateForCheckOut,
                            )));
              },
              child: Container(
                margin: EdgeInsets.only(right: 20, left: 30),
                child: Center(
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TabBar(
                  onTap: (tabIndex) {
                    //setState(() {
                    // if (tabIndex != 0) {
                    //   _getSnacksBySnackCategory(
                    //       snackCategoryList?[tabIndex - 1]?.id);
                    // } else {
                    //   _getSnackForAll();
                    // }
                    mModel.getSnacksDataBase()?.then((snackList) {
                      setState(() {
                        if (tabIndex != 0) {
                          snackItemList = snackList
                              ?.where((snack) =>
                          snack?.categoryId ==
                              snackCategoryList?[tabIndex - 1]?.id)
                              .toList();
                        } else {
                          snackItemList = snackList;
                        }
                      });
                    });
                    //  });
                  },
                  isScrollable: true,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  indicatorColor: Color.fromRGBO(0, 255, 106, 1),
                  tabs: _createTabs(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1000,
                  child: FoodGridView(
                    snackItemList: snackItemList,
                    onTap: (selectedItem) {
                      setState(() {
                        snackController.addSnack(selectedItem!);
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class FoodGridView extends StatefulWidget {
  List<SnackVO?>? snackItemList;
  Function(SnackVO?) onTap;
  FoodGridView({required this.snackItemList, required this.onTap});

  @override
  State<FoodGridView> createState() => _FoodGridViewState();
}

class _FoodGridViewState extends State<FoodGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.snackItemList?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 230,
      ),
      itemBuilder: (_, index) {
        var selectedItem = widget.snackItemList?[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(102, 102, 102, 0.8),
                Color.fromRGBO(51, 51, 51, 0.4),
              ],
            ),
          ),
          child: FoodAndDrinkItemComposition(
            image: "${selectedItem?.image}",
            food: "${selectedItem?.name}",
            price: selectedItem?.price ?? 0,
            onTapAdd: () {
              widget.onTap(selectedItem);
              // setState(() {
              //   snackController.addSnack(selectedItem!);
              // });
            },
          ),
        );
      },
    );
  }
}

class FoodAndDrinkItemComposition extends StatefulWidget {
  final String image;
  final String food;
  int price;
  Function onTapAdd;

  FoodAndDrinkItemComposition({
    required this.image,
    required this.food,
    required this.price,
    required this.onTapAdd,
  });

  @override
  State<FoodAndDrinkItemComposition> createState() =>
      _FoodAndDrinkItemCompositionState();
}

class _FoodAndDrinkItemCompositionState
    extends State<FoodAndDrinkItemComposition> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
            height: 100,
          ),
          margin: EdgeInsets.only(left: 10, right: 10, top: 16),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.food,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${widget.price} MMK",
                style: TextStyle(
                  color: Color.fromRGBO(0, 255, 106, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  widget.onTapAdd();
                },
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 255, 106, 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "ADD",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FoodCheckOutTotalView extends StatefulWidget {
  SelectedSnackController snackController;
  int? movieId;
  int? cinemaIndex;
  String? showTime;
  String dateForCheckOut;
  String dateFormat;
  int? cinemaDayTimeSlotId;
  Function onTapPlus;
  Function onTapMinus;
  FoodCheckOutTotalView({
    required this.snackController,
    required this.movieId,
    required this.cinemaIndex,
    required this.showTime,
    required this.dateForCheckOut,
    required this.dateFormat,
    required this.cinemaDayTimeSlotId,
    required this.onTapPlus,
    required this.onTapMinus,
  });

  @override
  State<FoodCheckOutTotalView> createState() => _FoodCheckOutTotalViewState();
}

class _FoodCheckOutTotalViewState extends State<FoodCheckOutTotalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 19),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 255, 106, 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(),
        backgroundColor: Color.fromRGBO(0, 255, 106, 1),
        foregroundColor: Colors.black,
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              Icons.fastfood_outlined,
              size: 32,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: (context),
                  builder: (context) => TotalPriceShowModal(
                    snackController: widget.snackController,
                    onTapMinus: () {
                      setState(() {
                        widget.onTapMinus();
                      });
                    },
                    onTapPlus: () {
                      setState(() {
                        widget.onTapPlus();
                      });
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutPage(
                            cinemaDayTimeSlotId: widget.cinemaDayTimeSlotId,
                            dateFormat: widget.dateFormat,
                            movieId: widget.movieId,
                            cinemaIndex: widget.cinemaIndex,
                            showTime: widget.showTime,
                            snackController: widget.snackController,
                            dateForCheckOut: widget.dateForCheckOut)));
              },
              child: Row(
                children: [
                  Text(
                    "${widget.snackController.totalPrice} MMK",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalPriceShowModal extends StatefulWidget {
  SelectedSnackController snackController;
  Function onTapPlus;
  Function onTapMinus;
  TotalPriceShowModal({
    required this.snackController,
    required this.onTapPlus,
    required this.onTapMinus,
  });

  @override
  State<TotalPriceShowModal> createState() => _TotalPriceShowModalState();
}

class _TotalPriceShowModalState extends State<TotalPriceShowModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: HOME_PAGE_BACKGROUND_ONE,
          ),
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 60),
          child: Column(
            children: [
              SizedBox(
                  height: 70,
                  child: ListView.builder(
                      //padding: EdgeInsets.symmetric(vertical: 4),
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount:
                          widget.snackController.selectedSnackList?.length,
                      itemBuilder: (context, index) {
                        var selectedSnack =
                            widget.snackController.selectedSnackList?[index];
                        return SelectedItemDetailShowModal(
                          widget.snackController,
                          selectedSnack,
                          onTapPlus: (snack) {
                            widget.onTapPlus();
                            setState(() {
                              widget.snackController.addSnack(snack!);
                            });
                          },
                          onTapMinus: (snack) {
                            widget.onTapMinus();
                            setState(() {
                              widget.snackController.reduceSnack(snack!);
                            });
                          },
                        );
                      })),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 255, 106, 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fastfood_outlined,
                      size: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 28,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${widget.snackController.totalPrice} MMK",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedItemDetailShowModal extends StatefulWidget {
  SnackVO? selectedSnack;
  SelectedSnackController snackController;
  Function(SnackVO?) onTapPlus;
  Function(SnackVO?) onTapMinus;
  SelectedItemDetailShowModal(
    this.snackController,
    this.selectedSnack, {
    required this.onTapPlus,
    required this.onTapMinus,
  });

  @override
  State<SelectedItemDetailShowModal> createState() =>
      _SelectedItemDetailShowModalState();
}

class _SelectedItemDetailShowModalState
    extends State<SelectedItemDetailShowModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${widget.selectedSnack?.name}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          //SizedBox(width: 50),
          //Divider(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.onTapPlus(widget.selectedSnack);
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 255, 106, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset("assets/images/adding_plus.png"),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Text(
                "${widget.selectedSnack?.quantity}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 14),
              GestureDetector(
                onTap: () {
                  widget.onTapMinus(widget.selectedSnack);
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 255, 106, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset("assets/images/adding_minus.png"),
                  ),
                ),
              ),
            ],
          ),
          //Spacer(),
          SizedBox(width: 50),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${widget.selectedSnack?.price} MMK",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
