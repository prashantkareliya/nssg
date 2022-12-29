import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/screens/contact/add_contact_basic_information.dart';
import 'package:nssg/screens/contact/contact_bloc_dir/get_contact_bloc.dart';
import 'package:nssg/screens/contact/contact_data_dir/contact_datasource.dart';
import 'package:nssg/screens/contact/contact_data_dir/contact_repository.dart';
import 'package:nssg/screens/contact/contact_model_dir/contact_response_model.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../constants/constants.dart';
import '../../constants/navigation.dart';
import '../../constants/strings.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';

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
      duration: const Duration(milliseconds: 300),
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
      duration: const Duration(milliseconds: 300),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? false
            : true,
        child: Padding(
          padding: EdgeInsets.only(right: 24.sp, top: 8.sp, left: 15.sp),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.sp),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Provider.of<WidgetChange>(context, listen: false)
                          .appbarVisibility();
                      searchKey = "";
                    },
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor)),
                SizedBox(width: 5.w),
                Expanded(
                  child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchKey = value;
                          searchItemList = [];
                        });
                        for (var element in contactItems!) {
                          if (element.contactName!.contains(searchKey)) {
                            searchItemList!.add(element);
                          } else if (element.contactCompany!
                              .contains(searchKey)) {
                            searchItemList!.add(element);
                          }
                        }
                      },
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
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchKey.isNotEmpty
                        ? searchItemList!.length
                        : contactItems!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.sp, vertical: 6.sp),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 5,
                          child: Container(
                            width: query.width,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 1.0.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 3.sp),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "${LabelString.lblFullName}: ",
                                            style: CustomTextStyle
                                                .labelFontHintText),
                                      ),
                                      Expanded(
                                        child: Text(
                                            "${searchKey.isNotEmpty ? searchItemList![index].contactName : contactItems![index].contactName}",
                                            style: CustomTextStyle.labelText),
                                      ),
                                      Container(
                                        height: 3.h,
                                        width: 6.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(80.0)),
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.redColor)),
                                        child: Center(
                                            child: Icon(
                                          Icons.delete_rounded,
                                          size: 12.sp,
                                          color: AppColors.redColor,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 3.sp),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "${LabelString.lblCompany}: ",
                                            style: CustomTextStyle
                                                .labelFontHintText),
                                      ),
                                      Expanded(
                                        child: Text(
                                            "${searchKey.isNotEmpty ? searchItemList![index].contactCompany : contactItems![index].contactCompany}",
                                            style: CustomTextStyle.labelText),
                                      ),
                                      Container(
                                        height: 3.h,
                                        width: 6.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(80.0)),
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.blackColor)),
                                        child: Center(
                                            child: Icon(Icons.edit_rounded,
                                                size: 12.sp,
                                                color: AppColors.blackColor)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.sp, vertical: 3.sp),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "${LabelString.lblMobilePhone}: ",
                                            style: CustomTextStyle
                                                .labelFontHintText),
                                      ),
                                      Expanded(
                                          child: Text(
                                              contactItems![index]
                                                  .phone
                                                  .toString(),
                                              style:
                                                  CustomTextStyle.labelText)),
                                      SizedBox(height: 3.h, width: 6.w)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.sp, vertical: 3.sp),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "${LabelString.lblPrimaryEmail}: ",
                                            style: CustomTextStyle
                                                .labelFontHintText),
                                      ),
                                      Expanded(
                                        child: Text(
                                            contactItems![index]
                                                .email
                                                .toString(),
                                            style: CustomTextStyle.labelText),
                                      ),
                                      SizedBox(height: 3.h, width: 6.w)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 1.0.h),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  //Add contact button
  Padding buildAddContactButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.sp, bottom: 8.sp),
      child: FloatingActionButton(
          onPressed: () =>
              callNextScreen(context, const AddContactBasicInformationPage()),
          child: const Icon(Icons.add)),
    );
  }

  //call API method for get contact list
  Future<void> getContact() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'query',
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKey, //2017
      'module_name': 'Contacts',
    };
    contactBloc.add(GetContactListEvent(queryParameters));
  }
}

/*


 */