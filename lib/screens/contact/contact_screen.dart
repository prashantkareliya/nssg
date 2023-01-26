import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/screens/contact/contact_datasource.dart';
import 'package:nssg/screens/contact/contact_repository.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:nssg/utils/preferences.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../components/custom_appbar.dart';
import '../../components/custom_dialog.dart';
import '../../components/global_api_call.dart';
import '../../constants/constants.dart';
import '../../constants/navigation.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/helpers.dart';

import '../../utils/widgetChange.dart';
import 'add_contact/add_contact_screen.dart';
import 'get_contact/contact_bloc_dir/get_contact_bloc.dart';
import 'get_contact/contact_model_dir/get_contact_response_model.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Result>? contactItems = [];
  List<Result>? searchItemList = [];
  String searchKey = "";

  @override
  void initState() {
    super.initState();
    getContact();
  }

  GetContactBloc contactBloc =
      GetContactBloc(ContactRepository(contactDataSource: ContactDataSource()));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: Column(
          children: [
            buildAppbar(context),
            buildSearchBar(context),
            buildContactList(query),
          ],
        ),
        floatingActionButton: buildAddContactButton(context),
      ),
    );
  }

  //Design appbar field
  AnimatedOpacity buildAppbar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow,
        child: BaseAppBar(
          appBar: AppBar(),
          title: LabelString.lblContact,
          titleTextStyle: CustomTextStyle.labelFontText,
          isBack: false,
          searchWidget: Padding(
            padding: EdgeInsets.only(right: 12.sp),
            child: IconButton(
                onPressed: () =>
                    Provider.of<WidgetChange>(context, listen: false)
                        .appbarVisibility(),
                icon: Icon(Icons.search, color: AppColors.blackColor)),
          ),
          backgroundColor: AppColors.backWhiteColor,
        ),
      ),
    );
  }

  //Design search field
  AnimatedOpacity buildSearchBar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? false
            : true,
        child: Padding(
          padding:
              EdgeInsets.only(right: 24.sp, top: 8.sp, left: 15.sp, bottom: 0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.sp),
            child: Row(
              children: [
                InkWell(
                    onTap: () => closeSearchBar(),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor)),
                SizedBox(width: 5.w),
                Expanded(
                  child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchKey = value;
                          searchItemList = [];

                          for (var element in contactItems!) {
                            if (element.contactName!
                                .toLowerCase()
                                .contains(searchKey.toLowerCase())) {
                              searchItemList!.add(element);
                            } else if (element.contactCompany!
                                .toLowerCase()
                                .contains(searchKey.toLowerCase())) {
                              searchItemList!.add(element);
                            }
                          }
                        });
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: LabelString.lblSearch,
                          suffixIcon: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: Icon(Icons.search,
                                  color: AppColors.whiteColor, size: 15.sp)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.primaryColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.primaryColor)),
                          contentPadding:
                              EdgeInsets.only(left: 10.sp, top: 0, bottom: 0))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Contact list design
  BlocListener<GetContactBloc, GetContactState> buildContactList(Size query) {
    return BlocListener<GetContactBloc, GetContactState>(
      bloc: contactBloc,
      listener: (context, state) {
        if (state is ContactLoadFail) {
          Helpers.showSnackBar(context, state.error.toString());
        }
        if (state is ContactsLoaded) {
          contactItems = state.contactList;
          preferences.setPreference(
              PreferenceString.contactList, jsonEncode(state.contactList));
        }
        if (state is DeleteContact) {
          getContact();
          Helpers.showSnackBar(context, state.message.toString());
        }
      },
      child: BlocBuilder<GetContactBloc, GetContactState>(
        bloc: contactBloc,
        builder: (context, state) {
          if (state is ContactLoadingState) {
            isLoading = state.isBusy;
          }
          if (state is ContactsLoaded) {
            isLoading = false;
          }
          if (state is ContactLoadFail) {
            isLoading = false;
          }

          return Expanded(
            child: isLoading
                ? loadingView()
                : RefreshIndicator(
                    onRefresh: () => getContact(),
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 10.sp),
                      physics: const BouncingScrollPhysics(),
                      itemCount: searchKey.isNotEmpty
                          ? searchItemList!.length
                          : contactItems!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.sp)),
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        elevation: 0,
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: 12.sp),
                                        child: ContactDetail(
                                            contactItems![index].id));
                                  },
                                ).then((value) {
                                  if (value == "delete") {
                                    getContact();
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(12.sp)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.sp, horizontal: 15.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                searchKey.isNotEmpty
                                                    ? searchItemList![index]
                                                        .contactName
                                                        .toString()
                                                    : contactItems![index]
                                                        .contactName
                                                        .toString(),
                                                style: CustomTextStyle
                                                    .labelMediumBoldFontText),
                                            SizedBox(height: 1.3.h),
                                            Text(
                                                contactItems![index]
                                                    .email
                                                    .toString(),
                                                style:
                                                    CustomTextStyle.labelText),
                                            SizedBox(height: 0.7.h),
                                            Text(
                                                contactItems![index]
                                                    .mobile
                                                    .toString(),
                                                style:
                                                    CustomTextStyle.labelText),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(LabelString.lblViewMore,
                                              style:
                                                  CustomTextStyle.commonText),
                                          SizedBox(width: 2.w),
                                          Image.asset(ImageString.imgViewMore,
                                              height: 2.h)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        /*Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            elevation: 3,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        elevation: 0,
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: 12.sp),
                                        child: ContactDetail(
                                            contactItems![index].id));
                                  },
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.0.h),
                                        ContactTileField(
                                            LabelString.lblFullName,
                                            searchKey.isNotEmpty
                                                ? searchItemList![index]
                                                    .contactName
                                                : contactItems![index]
                                                    .contactName),
                                        ContactTileField(
                                            LabelString.lblCompany,
                                            searchKey.isNotEmpty
                                                ? searchItemList![index]
                                                    .contactCompany
                                                : contactItems![index]
                                                    .contactCompany),
                                        ContactTileField(
                                            LabelString.lblMobilePhone,
                                            contactItems![index]
                                                .mobile
                                                .toString()),
                                        ContactTileField(
                                            LabelString.lblPrimaryEmail,
                                            contactItems![index].email.toString()),
                                        SizedBox(height: 2.0.h),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          highlightColor: AppColors.transparent,
                                          splashColor: AppColors.transparent,
                                          onTap: () {
                                            callNextScreen(
                                              context,
                                              AddContactPage(
                                                  contactItems![index].id.toString()),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.sp),
                                            child: Center(
                                                child: Icon(Icons.edit_rounded,
                                                    size: 14.sp,
                                                    color:
                                                        AppColors.blackColor)),
                                          ),
                                        ),
                                        InkWell(
                                          highlightColor: AppColors.transparent,
                                          splashColor: AppColors.transparent,
                                          onTap: () {
                                            //Dialog to confirm delete contact or not
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (ctx) =>
                                                  ValidationDialog(
                                                Message.deleteContact,
                                                //Yes button
                                                () {
                                                  Navigator.pop(context);
                                                  deleteContact(
                                                      contactItems![index]
                                                          .id
                                                          .toString());
                                                  */ /*setState(() {
                                                    contactItems!.removeAt(index);
                                                  });*/ /*
                                                },
                                                () => Navigator.pop(
                                                    context), //No button
                                              ),
                                            );
                                          },
                                          child: Center(
                                              child: Icon(
                                            Icons.delete_rounded,
                                            color: AppColors.redColor,
                                            size: 14.sp,
                                          )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );*/
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(height: 10.sp);
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }

  //Add contact button
  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          // callNextScreen(context, AddContactBasicInformationPage("NoId"));
          callNextScreen(context, AddContactPage("NoId"));
        },
        child: const Icon(Icons.add));
  }

  //call API method for get contact list
  Future<void> getContact() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'query',
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyContact, //2017
      //'page': "1",
      'module_name': 'Contacts',
    };
    contactBloc.add(GetContactListEvent(queryParameters));
  }

  //Method for delete contact
  deleteContact(String contactId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'delete',
      'sessionName': preferences.getString(PreferenceString.sessionName),
      'id': contactId, //2017
      'appversion': Constants.of().appversion,
    };
    contactBloc.add(DeleteContactEvent(queryParameters));
  }

  void closeSearchBar() {
    Provider.of<WidgetChange>(context, listen: false).appbarVisibility();
    searchKey = "";
  }
}

class ContactTileField extends StatelessWidget {
  String? field;
  String? fieldDetail;

  TextAlign? textAlign;

  ContactTileField(this.field, this.fieldDetail, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.sp, top: 8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text("$field :", style: CustomTextStyle.labelFontHintText),
          ),
          Expanded(
              child: Text(
                  textAlign: textAlign,
                  fieldDetail!,
                  style: CustomTextStyle.labelText)),
        ],
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  var id;

  ContactDetail(this.id, {Key? key}) : super(key: key);

  Future<dynamic>? getDetail;

  GetContactBloc contactBloc =
      GetContactBloc(ContactRepository(contactDataSource: ContactDataSource()));

  @override
  Widget build(BuildContext context) {
    getDetail = getContactDetail(id);
    return FutureBuilder<dynamic>(
      future: getDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var dataContact = snapshot.data["result"];
          return Container(
            height: 70.h,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.close_rounded,
                            color: AppColors.transparent)),
                    Text(LabelString.lblContactDetail,
                        style: CustomTextStyle.labelBoldFontText),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close_rounded,
                            color: AppColors.blackColor),
                        highlightColor: AppColors.transparent,
                        splashColor: AppColors.transparent)
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 5,
                                child: Column(
                                  children: [
                                    ContactTileField(LabelString.lblFullName,
                                        "${dataContact["firstname"]} ${dataContact["lastname"]}"),
                                    ContactTileField(LabelString.lblCompany,
                                        dataContact["contact_company"]),
                                    ContactTileField(LabelString.lblOfficePhone,
                                        dataContact["phone"]),
                                    ContactTileField(LabelString.lblMobilePhone,
                                        dataContact["mobile"]),
                                    ContactTileField(
                                        LabelString.lblPrimaryEmail,
                                        dataContact["email"]),
                                    ContactTileField(
                                        LabelString.lblSecondaryEmail,
                                        dataContact["secondaryemail"]),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          callNextScreen(context,
                                              AddContactPage(id.toString()));
                                        },
                                        child: Image.asset(ImageString.icEdit,
                                            height: 2.5.h)),
                                    SizedBox(height: 2.h),
                                    InkWell(
                                      onTap: () {
                                        //Dialog to confirm delete contact or not
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (ctx) => ValidationDialog(
                                            Message.deleteContact,
                                            //Yes button
                                            () {
                                              deleteContact(id.toString());
                                              Navigator.pop(context);
                                              Navigator.pop(context, "delete");
                                            },
                                            () => Navigator.pop(context), //No button
                                          ),
                                        );
                                      },
                                      child: Image.asset(ImageString.icDelete,
                                          height: 2.5.h),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.sp),
                            child: Text(
                                LabelString.lblInstallationAddressDetails,
                                style: CustomTextStyle.labelBoldFontTextBlue),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: Column(
                                  children: [
                                    ContactTileField(LabelString.lblAddress,
                                        dataContact["mailingstreet"]),
                                    ContactTileField(LabelString.lblCity,
                                        dataContact["mailingcity"]),
                                    ContactTileField(LabelString.lblCountry,
                                        dataContact["mailingcountry"]),
                                    ContactTileField(LabelString.lblPostalCode,
                                        dataContact["mailingzip"]),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Image.asset(ImageString.icEdit,
                                        color: AppColors.transparent,
                                        height: 2.5.h),
                                    SizedBox(height: 2.h),
                                    Image.asset(ImageString.icDelete,
                                        color: AppColors.transparent,
                                        height: 2.5.h),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.sp),
                            child: Text(LabelString.lblInvoiceAddressDetails,
                                style: CustomTextStyle.labelBoldFontTextBlue),
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: Column(
                                  children: [
                                    ContactTileField(LabelString.lblAddress,
                                        dataContact["otherstreet"]),
                                    ContactTileField(LabelString.lblCity,
                                        dataContact["othercity"]),
                                    ContactTileField(LabelString.lblCountry,
                                        dataContact["othercountry"]),
                                    ContactTileField(LabelString.lblPostalCode,
                                        dataContact["otherzip"]),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Image.asset(ImageString.icEdit,
                                        color: AppColors.transparent,
                                        height: 2.5.h),
                                    SizedBox(height: 2.h),
                                    Image.asset(ImageString.icDelete,
                                        color: AppColors.transparent,
                                        height: 2.5.h),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.5.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          final message = HandleAPI.handleAPIError(snapshot.error);
          return Text(message);
        }
        return SizedBox(height: 70.h, child: loadingView());
      },
    );
  }

  //Method for delete contact
  deleteContact(String contactId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'delete',
      'sessionName': preferences.getString(PreferenceString.sessionName),
      'id': contactId, //2017
      'appversion': Constants.of().appversion,
    };
    contactBloc.add(DeleteContactEvent(queryParameters));
  }
}

/*
class ContactDetail extends StatefulWidget {
  var id;

  ContactDetail(this.id, {Key? key}) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {

}
*/
