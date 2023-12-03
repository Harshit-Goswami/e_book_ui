import 'dart:convert';

import 'package:e_book_app_ui/app_colors.dart' as AppColors;
import 'package:e_book_app_ui/detail_audio_page.dart';
import 'package:e_book_app_ui/my_tabs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late List popularBooks;
  late List books;
  late ScrollController _scrollController;

  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/popularBooks.json')
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString('json/books.json')
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.only(top: 10, left: 20),
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 28),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage("img/menu.png"),
                    size: 20,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search, size: 28),
                      SizedBox(width: 10),
                      Icon(Icons.notifications, size: 28)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  "Popular Books",
                  style: TextStyle(fontSize: 28),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: Stack(children: [
                Positioned(
                    right: 0,
                    left: -50,
                    child: SizedBox(
                      height: 180,
                      child: PageView.builder(
                        itemCount:
                            popularBooks == null ? 0 : popularBooks.length,
                        physics: const BouncingScrollPhysics(),
                        controller: PageController(viewportFraction: 0.8),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 180,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image:
                                        AssetImage(popularBooks[index]['img']),
                                    fit: BoxFit.fill)),
                          );
                        },
                      ),
                    ))
              ]),
            ),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColors.sliverBackground,
                    elevation: 0,
                    shadowColor: AppColors.sliverBackground,
                    surfaceTintColor: AppColors.sliverBackground,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.all(0),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: const EdgeInsets.only(right: 10),
                          controller: _tabController,
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: const Offset(0, 0))
                              ]),
                          tabs: const [
                            AppTabs(color: AppColors.menu1Color, text: 'New'),
                            AppTabs(
                                color: AppColors.menu2Color, text: 'Popular'),
                            AppTabs(
                                color: AppColors.menu3Color, text: 'Trending')
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: books == null ? 0 : books.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  DetailAudioPage(bookData: books,index: index),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.tabVarViewColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: const Offset(0, 0))
                                ]),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image:
                                              AssetImage(books[index]['img'])),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 24,
                                            color: AppColors.starColor,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            books[index]['rating'],
                                            style: const TextStyle(
                                                color: AppColors.menu2Color),
                                          )
                                        ],
                                      ),
                                      Text(
                                        books[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        books[index]['text'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            color: AppColors.subTitleText),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.loveColor),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Love',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Avenir",
                                              color: AppColors.background),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                  const Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
