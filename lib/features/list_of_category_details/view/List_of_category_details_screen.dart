import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/common/button.dart';
import 'package:rservation_user/features/list_of_category_details/additional_options+business_layer/additional_options_cubit.dart';
import 'package:rservation_user/features/list_of_category_details/view/slider_widget.dart';
import 'package:rservation_user/features/user_resservation_detailss/business_layer/add_reservation_cubit.dart';
import '../../../common/check_list_widget.dart';
import '../../../common/list_of_data.dart';
import '../../drawer/drawe_widget.dart';
import '../../list_of_category/business_layer/items_cubit.dart';
import '../../user_resservation_detailss/view/user_details_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfCategoryDetailsScreen extends StatelessWidget {
  final String name;
  final String description ;
  final String address;
  final String price;
  final String  priceIn;
  String categoryName;
  String itemId;
  // List<Data>? itemDevices ;


  ListOfCategoryDetailsScreen({
    Key? key, required this.name, required this.description, required this.address,
    required this.price, required this.priceIn,
    required this.categoryName,required this.itemId,
    // required this.itemDevices

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(itemId);
    print("............................item id................................");
    var categoryItems = ItemsCubit.get(context);

    return Scaffold(
      drawer: DrawerWidget(),

      appBar: AppBar(

        backgroundColor: Colors.deepOrange,
        title: Center(child: Text("التفاصيل", style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //slider
            Container(

              width:100.w ,
              height: 30.h,
              child: BlocProvider(

              create: (context) => SliderCubit(),
              child: SliderWidget(),

              ),

            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${name}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          SingleChildScrollView(
                            child: Container(
                              // height: 20.h,
                              child: Text("${description}",
                                style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',fontSize: 20.sp, ),
                                textDirection: TextDirection.rtl,
                                maxLines: 5,overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,),
                            ),
                          ),

                          Text(" : الوصف", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),


                        ],
                      ),



                      SizedBox(height: 8,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${price}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',  fontSize: 20.sp),),

                          Row(
                            children: [
                              Text(" : ${priceIn}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
                              Text(" السعر ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(" المقتنيات  ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        ],
                      ),
                      Container(
                          // height: 15.h,
                          child: ListOfData(checklistItems: ['5 ترابيزاتٍ','تلاجه','10 كراسي'," uhig"],),),

                      SizedBox(height: 5,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(" الاضافات ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        ],
                      ),
                   Container(
                     child: BlocProvider(
  create: (context) => AdditionalOptionsCubit()..getAdditionalOptions(itemId),
  child: ChecklistPage(),
),
                   )

                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 15,),
            Button0(widget:Center(child: Text("للحجز", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontSize: 20.sp, fontWeight: FontWeight.bold),)),
                 function: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  BlocProvider(
  create: (context) => AddReservationCubit(),
  child: AddReservationScreen(categoryName: categoryName,  itemId: itemId,),
)));
            }),
            SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }
}
