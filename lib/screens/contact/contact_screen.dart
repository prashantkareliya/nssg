import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/screens/contact/contact_datasource.dart';
import 'package:nssg/screens/contact/contact_repository.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:nssg/utils/preferences.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:page_transition/page_transition.dart';
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

bool? isDelete = false;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Result>? contactItems = [];
  List<Result>? searchItemList = [];
  String searchKey = "";

  //This variable for contact detail new design, send to open drawer end drawer
  String? setContactId = "";

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
        /* endDrawer: GestureDetector(
          onHorizontalDragUpdate: null,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 50.sp),
              color: Colors.transparent,
              child: Drawer(child: ContactDetail(setContactId))),
        ),*/
        /*endDrawerEnableOpenDragGesture: false,
        onEndDrawerChanged: (value) {
          */ /*if (value == false) {
            getContact();
          }*/ /*
          if (isDelete == true) {
            getContact();
          }
        },*/
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
                  child: Consumer<WidgetChange>(
                      builder: (context, updateKey, search) {
                    return TextField(

                        onChanged: (value) {
                          Provider.of<WidgetChange>(context, listen: false).updateSearch(value);
                          searchKey = updateKey.updateSearchText.toString();

                          searchItemList = [];
                          for (var element in contactItems!) {
                            if (element.contactName!.toLowerCase().contains(searchKey.toLowerCase())) {
                              searchItemList!.add(element);
                            } else if (element.contactCompany!.toLowerCase().contains(searchKey.toLowerCase())) {
                              searchItemList!.add(element);
                            }else if(element.firstname!.toLowerCase().contains(searchKey.toLowerCase())){
                              searchItemList!.add(element);
                            }else if((element.lastname!.toLowerCase().contains(searchKey.toLowerCase()))){
                              searchItemList!.add(element);
                            }else if((element.email!.toLowerCase().contains(searchKey.toLowerCase()))){
                              searchItemList!.add(element);
                            }else if((element.mailingzip!.toLowerCase().contains(searchKey.toLowerCase()))){
                              searchItemList!.add(element);
                            }else if((element.otherzip!.toLowerCase().contains(searchKey.toLowerCase()))){
                              searchItemList!.add(element);
                            }
                          }
                        },
                        keyboardType: TextInputType.text,
                        autofocus: true,
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
                            contentPadding: EdgeInsets.only(
                                left: 10.sp, top: 0, bottom: 0)));
                  }),
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
          isDelete = false;
          preferences.setPreference(PreferenceString.contactList, jsonEncode(state.contactList));
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
                    child: AnimationLimiter(
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 10.sp),
                        physics: const BouncingScrollPhysics(),
                        itemCount:  searchKey.isNotEmpty
                            ? searchItemList!.length
                            : contactItems!.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              curve: Curves.decelerate,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 12.sp, right: 12.sp),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.sp)),
                                      elevation: 2,
                                      child: Consumer<WidgetChange>(
                                        builder:
                                            (context, contactId, updateBudget) {
                                          return InkWell(
                                            onTap: () {
                                              //change string value with use of provider
                                              if (searchKey.isNotEmpty) {
                                                Provider.of<WidgetChange>(context,listen: false)
                                                    .updateContact(searchItemList![index].id.toString());
                                                setContactId = contactId.updateContactId.toString();
                                              } else {
                                                Provider.of<WidgetChange>(context,listen: false)
                                                    .updateContact(contactItems![index].id.toString());
                                                setContactId = contactId.updateContactId.toString();
                                              }
                                              Navigator.push(
                                                      context, PageTransition(
                                                          type: PageTransitionType.rightToLeft,
                                                          child: ContactDetail(setContactId, "contact", ""))).then((value) {
                                                if (value == "delete") {
                                                  getContact();
                                                }
                                              });

                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.sp)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.sp,
                                                    horizontal: 15.sp),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                              searchKey.isNotEmpty
                                                                  ? searchItemList![index].contactName.toString()
                                                                  : contactItems![index].contactName.toString(),
                                                              style: CustomTextStyle.labelMediumBoldFontText),
                                                          SizedBox(height: 1.3.h),
                                                          InkWell(
                                                            onTap: (){
                                                              if( searchKey.isNotEmpty){
                                                                sendMail(searchItemList![index].email.toString(), context);
                                                              }else{
                                                                sendMail(contactItems![index].email.toString(), context);
                                                              }

                                                            },
                                                            child: Text(
                                                                searchKey.isNotEmpty
                                                                    ? searchItemList![index].email.toString()
                                                                    :contactItems![index].email.toString(),
                                                                style: GoogleFonts.roboto(
                                                                    textStyle: TextStyle(
                                                                    fontSize: 12.sp,
                                                                    color: AppColors.primaryColor))),
                                                          ),
                                                          SizedBox(height: 0.7.h),
                                                          InkWell(
                                                            onTap: () => callFromApp (searchKey.isNotEmpty
                                                                  ? searchItemList![index].mobile.toString()
                                                                  : contactItems![index].mobile.toString()),

                                                            child: Text(searchKey.isNotEmpty
                                                                ? searchItemList![index].mobile.toString()
                                                                :contactItems![index].mobile.toString(),
                                                                style: CustomTextStyle.labelText),
                                                          )],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            LabelString.lblViewMore,
                                                            style: CustomTextStyle.commonText),
                                                        SizedBox(width: 2.w),
                                                        Image.asset(ImageString.imgViewMore,
                                                            height: 2.h)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )),
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
                              //Nirav, pintu, Mango, Kano, Hemant, Akshit, Akshay, Kartik, CJ, Yug, Ganesh
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
                  ),
          );
        },
      ),
    );
  }

  //Add contact button
  SizedBox buildAddContactButton(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: FittedBox(
          child:  FloatingActionButton.small(
            elevation: 0,
              onPressed: () {
                callNextScreen(context, AddContactPage("NoId"));
              },
              child: Lottie.asset('assets/lottie/adding.json'))
      ),
    );

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

  String? quote;

  var dropdownvalue;

  ContactDetail(this.id, this.quote, this.dropdownvalue, {Key? key}) : super(key: key);

  Future<dynamic>? getDetail;

  GetContactBloc contactBloc =
      GetContactBloc(ContactRepository(contactDataSource: ContactDataSource()));

  @override
  Widget build(BuildContext context) {
    getDetail = getContactDetail(id, context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 60.sp),
                color: Colors.transparent,
                child: Drawer(
                  child: FutureBuilder<dynamic>(
                    future: getDetail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var dataContact = snapshot.data["result"];
                        return snapshot.data["success"] == true
                            ? Container(
                                height: 70.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15.sp, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () => callNextScreen(context, AddContactPage(id.toString())),
                                              icon: Image.asset(ImageString.icEdit, height: 2.5.h)),
                                          SizedBox(height: 2.h),
                                          if (quote != "quote") InkWell(
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
                                                    isDelete = true;
                                                    deleteContact(id.toString());
                                                    Navigator.pop(context);
                                                    Navigator.pop(context, "delete");
                                                  },
                                                  () => Navigator.pop(context), //No button
                                                ),
                                              );
                                            },
                                            child: Image.asset(
                                                ImageString.icDelete,
                                                height: 2.5.h),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close_rounded,
                                                  color: AppColors.blackColor),
                                              highlightColor:
                                                  AppColors.transparent,
                                              splashColor: AppColors.transparent)
                                        ],
                                      ),
                                      Text(
                                          "${dataContact["firstname"].toString().isNotEmpty ? dataContact["firstname"].toString().capitalize() : dataContact["firstname"]} "
                                          "${dataContact["lastname"].toString().isNotEmpty ? dataContact["lastname"].toString().capitalize() : dataContact["lastname"]}",
                                          style: GoogleFonts.roboto(textStyle: TextStyle(
                                              fontSize: 20.sp,
                                              color: AppColors.fontColor,
                                              fontWeight: FontWeight.w500))

                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              ImageString.icCompany,height: 2.h, color: AppColors.primaryColor),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                              child:
                                              dropdownvalue != "" && dropdownvalue.isNotEmpty ?
                                              Text(dropdownvalue["name"]=="" ? "" : dropdownvalue["name"],
                                                  style:CustomTextStyle.labelText)
                                              : Text(dataContact["contact_company"]== "" ? " " : dataContact["contact_company"],
                                                  style:CustomTextStyle.labelText))
                                        ],
                                      ),
                                      divider(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              ImageString.icPhone,height: 2.h, color: AppColors.primaryColor),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: dataContact["mobile"],
                                                        style: CustomTextStyle.labelText,
                                                        recognizer: TapGestureRecognizer()..onTap = () => callFromApp(dataContact["mobile"].toString())
                                                    ),
                                                    WidgetSpan(
                                                        child: dataContact["phone"] =="" || dataContact["mobile"] ==""
                                                            ? Container()
                                                            : Padding(
                                                                padding: EdgeInsets.symmetric(horizontal:8.sp),
                                                                child: Container(
                                                                    height: 2.5.h,
                                                                    width: 0.3.w,
                                                                    color: AppColors.blackColor),
                                                              )),
                                                    TextSpan(
                                                        text: dataContact["phone"],
                                                        style: CustomTextStyle.labelText,
                                                      recognizer: TapGestureRecognizer()..onTap = ()=>
                                                          callFromApp(dataContact["phone"].toString())
                                                    )
                                                  ]),
                                            ),
                                          )
                                        ],
                                      ),
                                      divider(),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(child: Icon(Icons.email_outlined, color: AppColors.primaryColor, size: 13.sp)),
                                            WidgetSpan(child: SizedBox(width: 2.w)),
                                            TextSpan(
                                                text: dataContact["email"].toString(),
                                                style: GoogleFonts.roboto(textStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColors.primaryColor
                                                )),
                                                recognizer: TapGestureRecognizer()..onTap = () {
                                                  sendMail(dataContact["email"].toString(), context);
                                                }
                                            ),
                                            const TextSpan(text: ", "),
                                            TextSpan(
                                                text: "${dataContact["secondaryemail"]}",
                                                style: GoogleFonts.roboto(textStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColors.primaryColor)),
                                                recognizer: TapGestureRecognizer()..onTap = (){
                                                  sendMail(dataContact["secondaryemail"].toString(), context);
                                                })
                                          ],
                                        ),
                                      ),

                                      divider(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              ImageString.icAddress,height: 2.h,color: AppColors.primaryColor),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                  text: LabelString.lblInvoiceAddress,
                                                  style: GoogleFonts.roboto(textStyle: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: AppColors.primaryColor,
                                                      fontWeight: FontWeight.bold)),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                        "\n${dataContact["mailingstreet"]}, ${dataContact["mailingcity"]}, ${dataContact["mailingcountry"]}, ${dataContact["mailingcountry"]}, ${dataContact["mailingzip"]}",
                                                        style: GoogleFonts.roboto(textStyle: TextStyle(
                                                            height: 1.5,
                                                            fontSize: 12.sp,
                                                            color: AppColors.blackColor,
                                                            fontWeight: FontWeight.normal)))
                                                  ]),
                                            ),
                                          )
                                        ],
                                      ),
                                      divider(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              ImageString.icAddress,height: 2.h,color: AppColors.primaryColor),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                  text: LabelString.lblInstallationAddress,
                                                  style: GoogleFonts.roboto(textStyle: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: AppColors.primaryColor,
                                                      fontWeight: FontWeight.bold)),
                                                  children: [
                                                    TextSpan(
                                                        text: dropdownvalue != "" && dropdownvalue.isNotEmpty ?
                                                        "\n${dropdownvalue["address"]}, ${dropdownvalue["city"]}, ${dropdownvalue["country"]}, ${dropdownvalue["postcode"]}"
                                                          : "\n${dataContact["otherstreet"]}, ${dataContact["othercity"]}, ${dataContact["othercountry"]}, ${dataContact["otherzip"]}",
                                                        style: GoogleFonts.roboto(textStyle: TextStyle(
                                                            height: 1.5,
                                                            fontSize: 12.sp,
                                                            color: AppColors.blackColor,
                                                            fontWeight: FontWeight.normal)))
                                                  ]),
                                            ),
                                          )
                                        ],
                                      ),
                                      divider(),
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close_rounded,
                                          color: AppColors.blackColor),
                                      highlightColor:
                                      AppColors.transparent,
                                      splashColor: AppColors.transparent),
                                ),
                                SizedBox(height: 5.h),
                                Text(ErrorString.deletedItemError,
                                    style: CustomTextStyle.labelMediumBoldFontText),
                              ],
                            );
                      }
                      else if (snapshot.hasError) {
                        final message = HandleAPI.handleAPIError(snapshot.error);
                        return Text(message);
                      }
                      return SizedBox(height: 70.h, child: loadingView());
                    },
                  ),
                )),
          )),
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

  Divider divider() {
    return Divider(
        color: AppColors.borderColor,
        height: 3.5.h,
        endIndent: 15.sp,
        thickness: 1.0);
  }
}