// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cartProvider.dart';
import 'model_cart.dart';
import 'cartItems.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItemProvider = Provider.of<CartProvider>(context);
    return FutureBuilder(
      future: cartItemProvider.fetchItems(),
      builder: (context, snapshot) {
        if (cartItemProvider.cartItems.length == 0){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('My Cart'),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: cartItemProvider.cartItems.length,
                    itemBuilder: (BuildContext context, int index){
                      return Column(
                        children: [
                          Row(
                            children: [
                              Image.network(cartItemProvider.cartItems[index].img, width: 100, height: 100,),
                              Text(
                                '${cartItemProvider.cartItems[index].menu} x${cartItemProvider.cartItems[index].quantity}',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: (){
                                  CartModel.delCart(cartItemProvider.cartItems[index].menu);
                                },
                                icon: Icon(Icons.delete_forever),
                                iconSize: 40,
                                color: Colors.grey[400],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Icon(Icons.subdirectory_arrow_right),
                              Text(
                                '  수량: ${cartItemProvider.cartItems[index].quantity}개\t\t\t\t\t결제 금액: ${cartItemProvider.cartItems[index].total}원',
                                style: TextStyle(
                                  fontSize: 17
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Divider(thickness: 1.0, indent: 0.0),
                        ],
                      );
                    },
                  ),
                ),
                Spacer(),
                Container(
                  height: 70,
                  color: Colors.green[200],
                  child: Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          fixedSize: Size(100, 70)
                        ),
                        onPressed: (){

                        }, 
                        child: Text(
                          '메뉴추가',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
                        )
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: (){

                        }, 
                        child: Text(
                          '결제하기',
                          style: TextStyle(
                            backgroundColor: Colors.green[200],
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ],
                  ),
                )
              ],
              
            ),

          );
        }
      },
    );
  }
}