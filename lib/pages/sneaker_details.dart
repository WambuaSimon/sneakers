import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sneakers/model/sneaker_model.dart';
import 'package:flutter_sneakers/utils/extension.dart';

class SneakerDetails extends StatelessWidget {
  const SneakerDetails({Key? key, required this.sneaker}) : super(key: key);
final Sneaker sneaker;
  @override
  Widget build(BuildContext context) {
    String title= sneaker.title;
    if(title==null){
      title= "Not defined!";
    }

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Details")),),
      body: Card(
        margin: EdgeInsets.all(8),
        elevation: 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(5),

              child: Text(
                sneaker.title.capitalize(),
                style: TextStyle(color: Colors.black,fontSize: 18),
              ),

            ),

            Hero(
              tag: "imageUrl",
              child: CachedNetworkImage(
                imageUrl: sneaker.media.imageUrl.toString(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),

              ),
            ),
            Divider(height: 1,color: Colors.black,),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Brand: ${sneaker.brand}",style: TextStyle(fontSize: 18),),
                  Text("Year: ${sneaker.year.toString()}",style: TextStyle(fontSize: 18),),
                  Text("Retail: \$${sneaker.retailPrice.toString()}",style: TextStyle(fontSize: 18),),

                ],
              ),
            )
          ],
        ),
      ),


    );
  }
}
