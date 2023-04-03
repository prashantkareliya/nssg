import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';


class SelectLocation extends StatefulWidget {

  var quantity;
  var productName;
  List<String>? locations;
  List<String>? titles;
  SelectLocation(this.quantity, this.productName, this.locations, this.titles, {super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {

  List<TextEditingController> textControllers = [];
  List<String> titleControllers = [];

  @override
  void initState() {
    super.initState();

    for(String s in widget.locations ?? []){
      final controller = TextEditingController(text: s);
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Location ${textControllers.length}",
          labelText: "Location ${textControllers.length}",
        ),
      );

      if(textControllers.length != widget.quantity){
        setState(() {
          textControllers.add(controller);
          titleControllers.add(widget.productName);
          /*fields.add(field);*/
        });
      }
    }

    for(String s in widget.titles ?? []){
      if(textControllers.length != widget.quantity){
        setState(() {
          titleControllers.add(widget.productName);
          /*fields.add(field);*/
        });
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
            children: <Widget> [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onPressed: () => Navigator.pop(context, "cancel"),
                      icon: Icon(Icons.close_rounded,
                          color: AppColors.blackColor))),
              Align(alignment: Alignment.topLeft,
                  child: Text(widget.productName, style: CustomTextStyle.labelBoldFontText)),

              SizedBox(height: 2.h),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.quantity,
                  itemBuilder: (context,index){
                    textControllers.add(TextEditingController());
                    titleControllers.add(widget.productName);
                    return TextField(
                      controller: textControllers[index],
                      decoration: InputDecoration(
                        hintText: "Location ${index+1}",
                        labelText: "Location ${index+1}",
                      ),
                    );
                  }),
              SizedBox(height: 2.h),
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
                          title: ButtonString.btnSave, onClick: (){
                        Navigator.pop(context, [textControllers.map((e) => e.text).toList(), titleControllers.map((e) => e.toString()).toList()]);
                      })),
                ],
              ),

            ],
          ),
        )
    );
  }
}
