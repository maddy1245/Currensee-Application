import 'package:eproject_currensee/features/personalization/controllers/user_controller.dart';
import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/image_string.dart';
import '../images/t_circular_image.dart';

class TuserProfileTile extends StatelessWidget {
  const TuserProfileTile({
    super.key,
    required this.onpressed,
  });
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: TCircularImage(
        image: TImage.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: onpressed,
          icon: Icon(
            Iconsax.edit,
            color: TColors.white,
          )),
    );
  }
}
