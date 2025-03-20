
import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:eproject_currensee/features/personalization/controllers/update_name_controller.dart';
import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:eproject_currensee/utils/constants/text_string.dart';
import 'package:eproject_currensee/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Tsizes.defaultspace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use Real Name for easy Verifcation .This name will appear on several pages. ',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: Tsizes.spacebtwsections),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value)=>TValidator.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: InputDecoration(labelText: Ttext.firstName,prefixIcon: Icon(Iconsax.user)),
                  ),

            SizedBox(height: Tsizes.spacebtwinputfield),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value)=>TValidator.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: InputDecoration(labelText: Ttext.lastName,prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Tsizes.spacebtwsections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=> controller.updateUserName, child: Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
