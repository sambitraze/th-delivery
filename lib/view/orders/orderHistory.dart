import 'package:Th_delivery/model/order.dart';
import 'package:Th_delivery/services/orderservice.dart';
import 'package:Th_delivery/view/orders/orderCard.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLoading = false;
  List<Order> all = [];
  List<Order> completed = [];
  List<Order> ongoing = [];
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    // TODO: implement initState
    loadDataForScreen();
    super.initState();
  }

  loadDataForScreen() async {
    setState(() {
      isLoading = true;
    });
    await getOrders();
    setState(() {
      isLoading = false;
    });
  }

  getOrders() async {
    var _orders = await OrderService.getAllOrders();
    print(_orders.length);
    setState(() {
      all = _orders.where((orders) {
        if (true)
          return true;        
      }).toList();
      ongoing = _orders.where((orders) {
        if (orders.status == 'placed')
          return true;
        else
          return false;
      }).toList();

      completed = _orders.where((orders) {
        if (orders.status == 'completed')
          return true;
        else
          return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(105.0),
        child: AppBar(
          backgroundColor: Colors.black,
          brightness: Brightness.light,
          centerTitle: true,
          title: new Text('Order List',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 0.46,
                  fontWeight: FontWeight.w500)),
          bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.orange,
              tabs: [
                new Tab(
                  text: 'All',
                ),
                new Tab(text: 'new'),
                new Tab(text: 'Completed'),
              ],
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : all.length == 0
                  ? Center(
                      child: Text('No Orders',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: all.length,
                      itemBuilder: (BuildContext context, int index) {
                        var orders = all[index];
                        return OrderCard(order: orders);
                      }),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ongoing.length == 0
                  ? Center(
                      child: Text('No Orders',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: ongoing.length,
                      itemBuilder: (BuildContext context, int index) {
                        var orders = ongoing[index];
                        return OrderCard(order: orders);
                      }),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : completed.length == 0
                  ? Center(
                      child: Text('No Orders',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: completed.length,
                      itemBuilder: (BuildContext context, int index) {
                        var orders = completed[index];
                        return OrderCard(order: orders);
                      }),
        ],
      ),
    );
  }
}
