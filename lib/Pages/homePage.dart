import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_app/Custom%20Widgets/categoryIcons.dart';
import 'package:ecomerce_app/Pages/itemPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Custom Widgets/item.dart';
import '../Provider/provider.dart';

class Homepage extends StatelessWidget {

  Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    final provider  = context.read<itemProvider>();
    final listener = context.watch<itemProvider>(); // This will listen for changes

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(


            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(13))
            ),
            child: Column (
          
              children: [
                SizedBox(height: 80,),
                
                Text("Delivery Address",style: TextStyle(color: Colors.grey[600]),),
                const Text("Mondra Colony House # A11",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child:TextField(
                        onChanged: (value){
                          provider.query = value;
                          provider.filterFunction(provider.query.toString());

                          print(provider.filteredItems);
                        },

                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: (){},
                          ),
                          hintText: "Search ",
                          hintStyle: const TextStyle(fontSize: 20,color: Colors.grey),

                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none
                          ),
                        ),
                      )
                    ),
                  ),
                ),

                CarouselSlider(items: provider.posters.map((item){
                  return Container(

                    margin: const EdgeInsets.symmetric(vertical: 10,),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                    ),
                    child: Image.asset(item, fit: BoxFit.fill, width: 1000.0),

                  );
                }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 18/9,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 10),


                    )
                ),

              ],
            ),
          ),
          const SizedBox(height: 20,),

          Container(
            decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22)
            ),


            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                  child: Text("Categories",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26),),
                ),

                SizedBox(
                  height: 100,

                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,

                    itemCount: provider.CatIcons.length,
                    itemBuilder: (context, index) {
                    return Categoryicons(
                        backColor: provider.categoryIndex == index? Colors.purple.shade300:Colors.white,
                        imgPath: provider.CatIcons[index],
                       onTap: (){
                      listener.UpCatIndex(index);
                       listener.AddingItems(); 

                     });

                  },),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.filteredItems.length,
                  itemBuilder: (context, index) {
                    return Item(
                      favIcon:  provider.filteredItems[index]["isFav"]  ? Icons.favorite:Icons.favorite_outline_outlined, favIconColor:listener.filteredItems[index]["isFav"]  ?Colors.red:Colors.black,
                      onTapFav: (){
                        listener.favFunction1(index: index);


                        },
                      onTap: (){
                        provider.resetQuantity();
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Itempage(item: provider.filteredItems[index]);
                        }));
                      },
                        itemPrice: provider.filteredItems[index]["price"],
                        itemName: provider.filteredItems[index]["name"],
                        imgPath: "assets/home/${provider.filteredItems[index]["name"].toString().toLowerCase()}.png"


                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 170/260,

                  ),

                )
              ],
            ),

          ),



        ],

      ),
    );
  }
}






