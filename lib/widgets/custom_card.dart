import 'package:crunchbox/model/response.dart';
import 'package:crunchbox/pages/product/details_page.dart';
import 'package:crunchbox/themes/colors.dart';
import 'package:crunchbox/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final int productID;
  final String productName;
  final AsyncSnapshot snapshots;
  final int index;

  const CustomCard(
      {Key? key,
      required this.productID,
      required this.productName,
      required this.snapshots,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(7.0),
            bottomRight: Radius.circular(7.0)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(
                        productId: productID,
                        productName: productName,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              // child: Image.asset(
              //   'assets/default_image.jpg',
              //   fit: BoxFit.fitWidth,
              // ),
              child: Image.network(
                '${snapshots.data[index].images[0].productImageSrc}',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${snapshots.data[index].name}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('\$${snapshots.data[index].price}'),
                  Flexible(
                    child: RatingBar(
                      rating:
                          double.parse('${snapshots.data[index].ratingCount}'),
                      color: kShrineAltYellow,
                      starCount: 5,
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
