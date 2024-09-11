import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/screens/SettingsScreens/MASettingsEditBeneficiaryScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;

import '../../utils/NBColors.dart';


class MASearchBeneficiaries extends StatefulWidget {
  final Future? beneficiaryList;
  const MASearchBeneficiaries({Key? key,  this.beneficiaryList,  }) : super(key: key);

  @override
  State<MASearchBeneficiaries> createState() => _MASearchBeneficiariesState();
}

class _MASearchBeneficiariesState extends State<MASearchBeneficiaries> {

  List<AddBeneficiary> eventList= [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                finish(context);
              }),
        ],
        title: const Text("Search Beneficiary List", style: TextStyle(color: Colors.black, fontSize: 16),),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                    future: widget.beneficiaryList,
                    builder: (context, AsyncSnapshot snapshot){
                      if(snapshot.data==null) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      else  if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            Text(
                              "No data",

                              style: TextStyle(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }
                      List<AddBeneficiary> schoolEvents = snapshot.data;
                      return SearchableList<AddBeneficiary>(
                          style: const TextStyle(fontSize: 16),
                          onPaginate: () async {
                          },
                          builder: (AddBeneficiary event) => ActorItem(beneficiary: event),
                          loadingWidget: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoActivityIndicator(),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Loading beneficiary')
                            ],
                          ),
                          errorWidget: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('No Record of Bank')
                            ],
                          ),
                          asyncListCallback: () async {
                            return schoolEvents;
                          },
                          asyncListFilter: (q, list) {
                            return list
                                .where((element) => element.fullName!.toLowerCase().contains(q.toLowerCase()))
                                .toList();
                          },
                          cursorColor: NBPrimaryColor,
                          emptyWidget: const EmptyView(),
                          onRefresh: () async {},
                          onItemSelected: (AddBeneficiary item) {},
                          inputDecoration:  const InputDecoration(
                            hintText: 'Event Beneficiary',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFA7B4AD)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF608E75)),
                            ),
                          )
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ActorItem extends StatelessWidget {
  final AddBeneficiary beneficiary;

  const ActorItem({
    Key? key,
    required this.beneficiary,
  }) : super(key: key);


  String getInitials(bank_account_name) {
    List<String> names = bank_account_name.split(" ");
    String initials = "";
    int numWords = 2;

    if(numWords < names.length) {
      numWords = names.length;
    }
    for(var i = 0; i < numWords; i++){
      initials += '${names[i][0]}';
    }
    return initials;
  }
  @override
  Widget build(BuildContext context) {
    var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
      0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];

    return GestureDetector(
      onTap: () async {
        bottomsheet.showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                MASettingsEditBeneficiaryScreen(beneficiaryDetails:beneficiary));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding:  const EdgeInsets.all(5.0),
              leading:  Container(
                width: 60,
                height: 80,
                alignment: Alignment.center,
                decoration:  BoxDecoration(
                    borderRadius:  BorderRadius.circular(30.0),
                    color:  Color(colors[0]).withOpacity(0.1)
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(getInitials(beneficiary.fullName!.toUpperCase(), ),
                    textAlign: TextAlign.center,
                    style: boldTextStyle(  color:  Color(colors[0])),),
                ),
              ),

              title: Text(
                '${beneficiary.fullName}',
                style: boldTextStyle(
                  color: Colors.black,

                ),
              ),
              subtitle:Text(
                '${beneficiary.createdAt}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ) ,

              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){
                      bottomsheet.showCupertinoModalBottomSheet(
                          expand: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              MASettingsEditBeneficiaryScreen(beneficiaryDetails:beneficiary));

                    },
                    child: Container(

                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                            borderRadius:  BorderRadius.circular(10.0),
                            color:  Colors.grey.withOpacity(0.2)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_forward_ios_outlined, size: 13,),
                        )),
                  // ),

                  ),
                ],
              )),
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('No Bank found with this name'),
      ],
    );
  }
}

class Actor {
  int age;
  String name;
  String lastName;

  Actor({
    required this.age,
    required this.name,
    required this.lastName,
  });
}