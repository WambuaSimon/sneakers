import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sneakers/bloc/sneaker_bloc.dart';
import 'package:flutter_sneakers/model/sneaker_model.dart';
import 'package:flutter_sneakers/pages/sneaker_details.dart';
import 'package:flutter_sneakers/utils/extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    bloc.getSneakers();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.subject.stream,
        builder: (context, AsyncSnapshot<SneakerResponse> snapshot) {
          if (snapshot.hasData) {
            return _homePageWidget(snapshot.requireData);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }else{
            return Center(child: CircularProgressIndicator());
          }

        });
  }
}

Widget _homePageWidget(SneakerResponse sneakerResponse) {
  return Scaffold(
    appBar: AppBar(
      title: const Center(child: Text("Sneakers")),
    ),
    body: GridView.builder(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: sneakerResponse.results.length,
        itemBuilder: (BuildContext context, int index) {

          Sneaker sneaker = sneakerResponse.results[index] ;
          String? mediaUrl = sneaker.media.imageUrl;
          if (mediaUrl == null){
            mediaUrl = "https://files.letsrun.com/images/shoes/shoe-placeholder.png";
          }

          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SneakerDetails(sneaker: sneaker,)));
              },
              child: Card(
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      alignment: Alignment.center,
                      child: Hero(
                        tag: "imageUrl",
                        child: CachedNetworkImage(
                          imageUrl: mediaUrl,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),

                        ),
                      )

                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(
                          left: 0.0, top: 0.0, right: 5.0, bottom: 5.0),
                      child: Text(
                        '\$${sneaker.retailPrice}',
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,

                      child: Text(
                        sneaker.shoe.capitalize(),
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ));
        }),
  );
}
