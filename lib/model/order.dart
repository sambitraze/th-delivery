import 'package:Th_delivery/model/User.dart';
import 'package:Th_delivery/model/cartItem.dart';
import 'package:Th_delivery/model/deliveryBoy.dart';

// DeliveryBoy deliveryBoyFromJson(String str) => DeliveryBoy.fromJson(json.decode(str));

// String deliveryBoyToJson(DeliveryBoy data) => json.encode(data.toJson());

class Order {
    Order({
        this.orderType,
        this.status,
        this.id,
        this.items,
        this.orderId,
        this.customer,
        this.custName,
        this.deliveryby,
        this.custNumber,
        this.paymentType,
        this.txtId,
        this.amount,
        this.packing,
        this.gst,
        this.gstRate,
        this.paid,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String orderType;
    String status;
    String id;
    List<CartItem> items;
    String orderId;
    User customer;
    String custName;
    DeliveryBoy deliveryby;
    String custNumber;
    String paymentType;
    dynamic txtId;
    String amount;
    String packing;
    String gst;
    String gstRate;
    bool paid;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderType: json["orderType"] == null ? null : json["orderType"],
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        items: json["items"] == null ? null : List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x))),
        orderId: json["orderId"] == null ? null : json["orderId"],
        customer: json["customer"] == null ? null : User.fromJson(json["customer"]),
        custName: json["custName"] == null ? null : json["custName"],
        deliveryby: json["deliveryby"] == null ? null : DeliveryBoy.fromJson(json["deliveryby"]),
        custNumber: json["custNumber"] == null ? null : json["custNumber"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        txtId: json["txtId"],
        amount: json["amount"] == null ? null : json["amount"],
        packing: json["packing"] == null ? null : json["packing"],
        gst: json["gst"] == null ? null : json["gst"],
        gstRate: json["gstRate"] == null ? null : json["gstRate"],
        paid: json["paid"] == null ? null : json["paid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "orderType": orderType == null ? null : orderType,
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "orderId": orderId == null ? null : orderId,
        "customer": customer == null ? null : customer.toJson(),
        "custName": custName == null ? null : custName,
        "deliveryby": deliveryby == null ? null : deliveryby.toJson(),
        "custNumber": custNumber == null ? null : custNumber,
        "paymentType": paymentType == null ? null : paymentType,
        "txtId": txtId,
        "amount": amount == null ? null : amount,
        "packing": packing == null ? null : packing,
        "gst": gst == null ? null : gst,
        "gstRate": gstRate == null ? null : gstRate,
        "paid": paid == null ? null : paid,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}