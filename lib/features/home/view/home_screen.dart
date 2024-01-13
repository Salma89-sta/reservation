import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rservation_user/features/categories/business_layer/categories_cubit.dart';
import 'package:rservation_user/features/home/view/reserved-card.dart';
import '../../drawer/drawe_widget.dart';
import '../business_layer/user_reservations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super( key: key );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocProvider(
        create: (context) => CategoryCubit()..getCategories(),
        child: DrawerWidget(),
      ),

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(child: Text("حجوزاتي", style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold),)),
      ),
      body: BlocConsumer<UserReservationsCubit, UserReservationsState>
        (
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = UserReservationsCubit.get(context);

          return (state is UserReservationsLoading)
              ? Center(child: CircularProgressIndicator())
              :
          (state is UserReservationsLoaded) ? Container(
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cubit.userReservationsData.length,
                itemBuilder: (context, index) {
                  return ReservedCardToUser(
                    reservedProductImage: "cubit.userReservationsData[index].",
                    reservedProductName: cubit.userReservationsData[index]
                        .categoryName.toString(),
                    fromDate: cubit.userReservationsData[index].time.toString(),
                    toDate: cubit.userReservationsData[index].time.toString(),
                    status: cubit.userReservationsData[index].status
                        .toString(), ReservationId: cubit.userReservationsData[index].id!,
                  );
                }
            ),
          ) : Container(
            child: Center(
              child: Text("ليس لديك حجوزات"),
            ),
          );
        },
      ),
    );
  }
}
