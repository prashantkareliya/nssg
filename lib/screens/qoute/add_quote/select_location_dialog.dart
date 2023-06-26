import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';

class SelectLocation extends StatefulWidget {
  var quantity;
  var productName;
  List<String>? locations;
  List<String>? titles;

  var productTitle;
  SelectLocation(this.quantity, this.productName, this.locations, this.titles, this.productTitle,
      {super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  List<TextEditingController> textControllers = [];
  List<String> titleControllers = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.quantity; i++) {
      try {
        textControllers.add(TextEditingController(text: widget.locations?[i]));
        titleControllers.add(widget.productTitle ?? "");
      }catch(e) {
        textControllers.add(TextEditingController());
        titleControllers.add(widget.productTitle ?? "");
      }
    }
  }

  @override
  void dispose() {
    for (final controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onPressed: () => Navigator.pop(context, "cancel"),
                      icon: Icon(Icons.close_rounded, color: AppColors.blackColor))),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.productName, style: CustomTextStyle.labelMediumBoldFontText)),
              SizedBox(height: 20.h),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.quantity,
                  itemBuilder: (context, index) {
                    /*textControllers.add(TextEditingController());
                    titleControllers.add(widget.productName);*/
                    return TextField(
                      controller: textControllers[index],
                      decoration: InputDecoration(
                        hintText: "Location ${index + 1}",
                        labelText: "Location ${index + 1}",
                      ),
                    );
                  }),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: BorderButton(
                          btnString: ButtonString.btnCancel,
                          onClick: () => Navigator.pop(context))),
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: CustomButton(
                          title: ButtonString.btnSave,
                          onClick: () {
                            Navigator.pop(context, [
                              textControllers.map((e) => e.text).toList(),
                              titleControllers.map((e) => e.toString()).toList()
                            ]);
                          })),
                ],
              ),
            ],
          ),
        ));
  }
}
