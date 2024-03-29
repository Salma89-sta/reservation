import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rservation_user/colors/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rservation_user/core/cache_helper/cache_helper.dart';
import 'package:rservation_user/features/home/business_layer/user_reservations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rservation_user/features/home/view/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ReservedCardToUser extends StatelessWidget {
  final dynamic reservedProductImage;
  final String reservedProductName;
  final String fromDate;
  final String toDate;
  final String status;
  final String ReservationId;


  const ReservedCardToUser({Key? key,required this.reservedProductImage, required this.reservedProductName, required this.fromDate, required this.toDate, required this.status, required this.ReservationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Center(
        child: Container(
          width: 85.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:Border.all(
          color: Colors.deepOrange,
            width:2,

        ),


          ),

          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: reservedProductImage,
                  width: 98.w,
                  placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget
                  errorWidget: (context, url, error) => Icon(Icons.error), // Error widget
                ),
              ),
              SizedBox(height: 5,),

              Text("${reservedProductName}", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 20.sp),),
              SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text("${fromDate}", style: TextStyle(color: AppColors.lightGrey, fontFamily: 'Cairo',fontSize: 18.sp),),
                  Text(" : من ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',fontSize: 20.sp),),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${toDate}", style: TextStyle(color: AppColors.lightGrey, fontFamily: 'Cairo',fontSize: 18.sp),),
                  Text(" : الي ", style: TextStyle(color: Colors.indigo, fontFamily: 'Cairo',fontSize: 20.sp),),

                ],
              ),
              SizedBox(height: 10,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: AppColors.lightGrey,)),
                  Divider(),
                  BlocConsumer<UserReservationsCubit, UserReservationsState>(
  listener: (context, state) {
    if(state is UserDeleteReservationSuccess){
      Fluttertoast.showToast(msg: "تم الغاء الحجز", textColor: Colors.white, backgroundColor: Colors.deepOrange);
    }else{
      Fluttertoast.showToast(msg: "حدث خطا اثناء الالغاء", textColor: Colors.white, backgroundColor: Colors.deepOrange);

    }
  },
  builder: (context, state) {
    return IconButton(onPressed: (){
      if(status == '0'){
        final cubit = UserReservationsCubit.get(context);
        cubit.userDeleteReservation(ReservationId);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(
  create: (context) => UserReservationsCubit()..getUserReservations(CacheHelper.getData(key: 'id')),
  child: HomeScreen(),
)));

      }else{
        Fluttertoast.showToast(msg: "هذا الحجز تمت الموافقه عليه لا يمكن مسحه", textColor: Colors.white, backgroundColor: Colors.deepOrange);

      }



    }, icon: Icon(Icons.delete, color: AppColors.lightGrey,));
  },
),
                  Divider(),
                  InkWell(
                    onTap: (){
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog( // <-- SEE HERE
                            content: SingleChildScrollView(
                              child: ListBody(
                                children:  <Widget>[
                                  Center(child: Text((status == '0')?"في الانتظار": "تمت الموافقه")),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Center(
                                child: TextButton(
                                  child: const Text('رجوع'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),

                            ],
                          );
                        },
                      );

                    },
                    child: Text(" متابعه حاله الحجز ", style: TextStyle(color: Colors.black, fontFamily: 'Cairo',fontSize: 18.sp,decoration: TextDecoration.underline,
                    ), ),
                  ),

                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
