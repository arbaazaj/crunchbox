class Product {
  final bool onSale;
  final bool purchasable;

  final int id;
  final int ratingCount;
  final int stockQuantity;

  final List<ProductImages> images;
  final List<Category> categories;
  final List<ProductVariation> variation;

  final String name;
  final String price;
  final String shortDescription;
  final String averageRating;
  final String regularPrice;
  final String salePrice;
  final String stockStatus;

  Product({
    required this.purchasable,
    required this.categories,
    required this.variation,
    required this.shortDescription,
    required this.regularPrice,
    required this.salePrice,
    required this.stockQuantity,
    required this.stockStatus,
    required this.id,
    required this.name,
    required this.images,
    required this.averageRating,
    required this.price,
    required this.ratingCount,
    required this.onSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var listOfProductImages = json['images'] as List;
    var listOfProductCategory = json['categories'] as List;
    var listOfProductVariation = json['variations'] as List;

    List<ProductImages> imagesList = listOfProductImages
        .map((data) => ProductImages.fromJson(data))
        .toList();
    List<Category> categories =
        listOfProductCategory.map((data) => Category.fromJson(data)).toList();

    List<ProductVariation> variations = listOfProductVariation
        .map((data) => ProductVariation.fromJson(data))
        .toList();

    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        onSale: json['on_sale'],
        purchasable: json['purchasable'],
        regularPrice: json['regular_price'],
        shortDescription: json['short_description'],
        stockQuantity: json['stock_quantity'],
        stockStatus: json['stock_status'],
        averageRating: json['average_rating'],
        ratingCount: json['rating_count'],
        salePrice: json['sale_price'],
        images: imagesList,
        categories: categories,
        variation: variations);
  }
}

class ProductImages {
  final int productImageId;
  final String productImageSrc;
  final String productImageName;
  final String productImageAlt;

  ProductImages(
      {required this.productImageId,
      required this.productImageSrc,
      required this.productImageName,
      required this.productImageAlt});

  factory ProductImages.fromJson(Map<String, dynamic> json) {
    return ProductImages(
        productImageId: json['id'],
        productImageSrc: json['src'],
        productImageName: json['name'],
        productImageAlt: json['alt']);
  }
}

class ProductVariation {
  final int id;
  final int stockQuantity;
  final String stockStatus;
  final String description;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final bool purchasable;
  final List<ProductVariationImage> images;
  final List<ProductVariationMetaData> metaData;
  final List<ProductVariationAttribute> attributes;

  ProductVariation(
      {required this.id,
      required this.stockQuantity,
      required this.stockStatus,
      required this.description,
      required this.price,
      required this.regularPrice,
      required this.salePrice,
      required this.onSale,
      required this.purchasable,
      required this.images,
      required this.metaData,
      required this.attributes});

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    var listOfVariationImages = json['images'] as List;
    var listOfMetaData = json['metadata'] as List;
    var listOfAttributes = json['attributes'] as List;

    List<ProductVariationImage> variationImages = listOfVariationImages
        .map((data) => ProductVariationImage.fromJson(data))
        .toList();

    List<ProductVariationMetaData> metaData = listOfMetaData
        .map((data) => ProductVariationMetaData.fromJson(json[data]))
        .toList();
    List<ProductVariationAttribute> attributes = listOfAttributes
        .map((data) => ProductVariationAttribute.fromJson(data))
        .toList();

    return ProductVariation(
        id: json['id'],
        stockQuantity: json['stock_quantity'],
        stockStatus: json['stock_status'],
        description: json['description'],
        price: json['price'],
        regularPrice: json['regular_price'],
        salePrice: json['salePrice'],
        onSale: json['onSale'],
        purchasable: json['purchasable'],
        images: variationImages,
        metaData: metaData,
        attributes: attributes);
  }
}

class ProductVariationAttribute {
  final int id;
  final String name;
  final String option;

  ProductVariationAttribute(
      {required this.id, required this.name, required this.option});

  factory ProductVariationAttribute.fromJson(Map<String, dynamic> json) {
    return ProductVariationAttribute(
      id: json['id'],
      name: json['name'],
      option: json['option'],
    );
  }
}

class ProductVariationMetaData {
  final int id;
  final String key;
  final String value;

  ProductVariationMetaData(
      {required this.id, required this.key, required this.value});

  factory ProductVariationMetaData.fromJson(Map<String, dynamic> json) {
    return ProductVariationMetaData(
        id: json['id'], key: json['key'], value: json['value']);
  }
}

class ProductVariationImage {
  final int id;
  final String name;
  final String src;
  final String altImageText;

  ProductVariationImage(
      {required this.id,
      required this.name,
      required this.src,
      required this.altImageText});

  factory ProductVariationImage.fromJson(Map<String, dynamic> json) {
    return ProductVariationImage(
        id: json['id'],
        name: json['name'],
        src: json['src'],
        altImageText: json['alt']);
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class Orders {
  final int id;
  final String orderNumber;
  final String orderKey;
  final String status;
  final String dateCreated;
  final String discountTotal;
  final String discountTax;
  final String shippingTotal;
  final int customerId;
  final String total;
  final String customerNote;
  final Object shipping;
  final String paymentId;
  final String paymentMethodTitle;
  final List lineItems;

  Orders(
      {required this.id,
      required this.orderNumber,
      required this.orderKey,
      required this.status,
      required this.dateCreated,
      required this.discountTotal,
      required this.discountTax,
      required this.shippingTotal,
      required this.customerId,
      required this.total,
      required this.customerNote,
      required this.shipping,
      required this.paymentId,
      required this.paymentMethodTitle,
      required this.lineItems});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
        id: json['id'],
        orderNumber: json['number'],
        orderKey: json['order_key'],
        status: json['status'],
        dateCreated: json['date_created'],
        discountTotal: json['discount_total'],
        discountTax: json['discount_tax'],
        shippingTotal: json['shipping_total'],
        customerId: json['customer_id'],
        total: json['total'],
        customerNote: json['customer_note'],
        paymentId: json['payment_method'],
        paymentMethodTitle: json['payment_method_title'],
        lineItems: json['line_items'],
        shipping: json['shipping']);
  }
}

class CustomersModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String role;
  final String password;
  final Shipping shipping;
  final Billing billing;

  CustomersModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.role,
      required this.password,
      required this.shipping,
      required this.billing});

  factory CustomersModel.fromJson(Map<String, dynamic> customersJson) {
    return CustomersModel(
        id: customersJson['id'],
        role: customersJson['role'],
        firstName: customersJson['first_name'],
        lastName: customersJson['last_name'],
        username: customersJson['username'],
        email: customersJson['email'],
        password: customersJson['password'],
        shipping: Shipping.fromJson(customersJson['shipping']),
        billing: Billing.fromJson(customersJson['billing']));
  }
}

class Billing {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String email;
  final String phone;

  Billing(
      {required this.firstName,
      required this.lastName,
      required this.company,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.pincode,
      required this.country,
      required this.email,
      required this.phone});

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
        firstName: json['first_name'],
        lastName: json['last_name'],
        company: json['company'],
        address1: json['address_1'],
        address2: json['address_2'],
        city: json['city'],
        state: json['state'],
        pincode: json['postcode'],
        country: json['country'],
        email: json['email'],
        phone: json['phone']);
  }
}

class Shipping {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String pincode;
  final String country;

  Shipping(
      {required this.firstName,
      required this.lastName,
      required this.company,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.pincode,
      required this.country});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      firstName: json['first_name'],
      lastName: json['last_name'],
      company: json['company'],
      address1: json['address_1'],
      address2: json['address_2'],
      city: json['city'],
      state: json['state'],
      pincode: json['postcode'],
      country: json['country'],
    );
  }
}
