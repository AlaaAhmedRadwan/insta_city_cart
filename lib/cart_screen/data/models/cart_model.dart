class CartResponse {
  List<Cart> carts;
  int totalOrder;

  CartResponse({required this.carts, required this.totalOrder});


  factory CartResponse.fromJson(Map<String, dynamic> json) {
    var cartList = json['carts'] as List;
    List<Cart> cartsList = cartList.map((cart) => Cart.fromJson(cart)).toList();

    return CartResponse(
      carts: cartsList,
      totalOrder: json['totalOrder'],
    );
  }

}


class Cart {
  int vendorId;
  String vendorName;
  List<Product> products;
  int id;
  Order order;

  Cart({
    required this.vendorId,
    required this.vendorName,
    required this.products,
    required this.id,
    required this.order, // Add this named parameter
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> productsList =
    productList.map((product) => Product.fromJson(product)).toList();

    return Cart(
      vendorId: json['vendor_id'],
      vendorName: json['vendorName'],
      products: productsList,
      id: json['id'],
      order: Order.fromJson(json['order']), // Provide the 'order' argument here
    );
  }
}
class Product {
  int id;
  int productId;
  int attributeId;
  String attributes;
  int price;
  int amount;
  int userId;
  String createdAt;
  String code;
  int isNotified;
  String notes;
  ProductDetail product;
  List<dynamic> cartProductSpecification;
  int priceAfterDiscount;

  Product({
    required this.id,
    required this.productId,
    required this.attributeId,
    required this.attributes,
    required this.price,
    required this.amount,
    required this.userId,
    required this.createdAt,
    required this.code,
    required this.isNotified,
    required this.notes,
    required this.product,
    required this.cartProductSpecification,
    required this.priceAfterDiscount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productId: json['product_id'],
      attributeId: json['attribute_id'],
      attributes: json['attributes'],
      price: json['price'],
      amount: json['amount'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      code: json['code'],
      isNotified: json['is_notified'],
      notes: json['notes'],
      product: ProductDetail.fromJson(json['product']),
      cartProductSpecification: json['cart_product_specification'],
      priceAfterDiscount: json['PriceAfterDiscount'],
    );
  }
}

class ProductDetail {
  dynamic rate;
  int rateCount;

  ProductDetail({required this.rate, required this.rateCount});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      rate: json['rate'],
      rateCount: json['rateCount'],
    );
  }
}

class Order {
  int subtotal;
  String vendorName;
  int vendorId;

  Order(
      {required this.subtotal,
      required this.vendorName,
      required this.vendorId});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      subtotal: json['Subtotal'],
      vendorName: json['vendor_name'],
      vendorId: json['vendor_id'],
    );
  }
}
