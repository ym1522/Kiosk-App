// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'items.dart';
import 'package:kiosk/controller.dart';
import 'model_cart.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final controller = Get.put(CountController());
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Items;
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xffffffff),
              foregroundColor: Color(0xffe51937),
              title: Text(
                item.menu,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25
                ),
              ),
            ),
        body: Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xfff2f2f2),
                          width: 2.5
                        )
                      ),
                      child: Image.network(item.img)
                    ),
                    SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.menu,
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${item.price}원',
                            style: TextStyle(
                              fontSize: 30, 
                              fontWeight: FontWeight.bold, 
                              color: Color(0xffe51937)
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '주문 수량\t\t',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.remove();
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 30,
                                  color: Color(0xffe51937),
                                )
                              ),
                              Obx(
                                () => Text(
                                  '${controller.quantity.value}',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.add();
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 30,
                                  color: Color(0xffe51937),
                                )
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Divider(color: Colors.grey[500], thickness: 1.5, endIndent: 10),
                          Padding(padding: EdgeInsets.all(10)),
                          Text(
                            item.description,
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    )
                  ]
                )
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xfff2f2f2),
                  child: Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xffe51937),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          fixedSize: Size(100, 70)
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Text(
                          '장바구니',
                          style: TextStyle(
                            fontSize: 23, 
                            fontWeight: FontWeight.normal
                          ),
                        )
                      ),
                      Obx(
                        () => Text(
                          '\t\t\t\t${(controller.quantity.value) * item.price}원',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          CartModel.addCart(item.menu, controller.quantity, item.img, item.price);
                          showDialog(
                            context: context, 
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Text(
                                  '담기 완료!',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffe51937),
                                                                            
                                    ),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    }, 
                                    child: Text('확인', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  )
                                ],
                              );
                            }
                          );
                        },
                        child: Text(
                          '담기',
                          style: TextStyle(
                            backgroundColor: Color(0xfff2f2f2),
                            color: Color(0xffe51937),
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
    );
  }
}
