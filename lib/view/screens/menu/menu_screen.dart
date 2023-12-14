import 'package:sixam_mart_store/controller/auth_controller.dart';
import 'package:sixam_mart_store/controller/splash_controller.dart';
import 'package:sixam_mart_store/data/model/response/menu_model.dart';
import 'package:sixam_mart_store/helper/route_helper.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/util/images.dart';
import 'package:sixam_mart_store/view/screens/menu/widget/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MenuModel> _menuList = [];

    _menuList.add(MenuModel(icon: '', title: 'profile'.tr, route: RouteHelper.getProfileRoute()));

    if(Get.find<AuthController>().modulePermission.item) {
      _menuList.add(MenuModel(
        icon: Images.add_food, title: 'add_item'.tr, route: RouteHelper.getItemRoute(null),
        isBlocked: !Get.find<AuthController>().profileModel.stores[0].itemSection,
      ));
    }
    if(Get.find<AuthController>().modulePermission.item) {
      _menuList.add(MenuModel(icon: Images.categories, title: 'categories'.tr, route: RouteHelper.getCategoriesRoute()));
    }
    if(Get.find<AuthController>().modulePermission.bankInfo) {
      _menuList.add(MenuModel(icon: Images.credit_card, title: 'bank_info'.tr, route: RouteHelper.getBankInfoRoute()));
    }
    if(Get.find<AuthController>().modulePermission.campaign) {
      _menuList.add(MenuModel(icon: Images.campaign, title: 'campaign'.tr, route: RouteHelper.getCampaignRoute()));
    }
    if(Get.find<AuthController>().profileModel.stores[0].selfDeliverySystem == 1 && Get.find<AuthController>().getUserType() == 'owner') {
      _menuList.add(MenuModel(icon: Images.delivery_man, title: 'delivery_man'.tr, route: RouteHelper.getDeliveryManRoute()));
    }
    if(Get.find<SplashController>().configModel.moduleConfig.module.addOn && Get.find<AuthController>().modulePermission.addon) {
      _menuList.add(MenuModel(icon: Images.addon, title: 'addons'.tr, route: RouteHelper.getAddonsRoute()));
    }
    if(Get.find<AuthController>().modulePermission.chat) {
      _menuList.add(MenuModel(icon: Images.chat, title: 'conversation'.tr, route: RouteHelper.getConversationListRoute()));
    }
    _menuList.add(MenuModel(icon: Images.language, title: 'language'.tr, route: RouteHelper.getLanguageRoute('menu')));
    _menuList.add(MenuModel(icon: Images.coupon, title: 'coupon'.tr, route: RouteHelper.getCouponRoute()));
    _menuList.add(MenuModel(icon: Images.expense, title: 'expense_report'.tr, route: RouteHelper.getExpenseRoute()));
    _menuList.add(MenuModel(icon: Images.policy, title: 'privacy_policy'.tr, route: RouteHelper.getPrivacyRoute()));
    _menuList.add(MenuModel(icon: Images.terms, title: 'terms_condition'.tr, route: RouteHelper.getTermsRoute()));
    _menuList.add(MenuModel(icon: Images.log_out, title: 'logout'.tr, route: ''));

    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: (1/1.2),
            crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL, mainAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),
          itemCount: _menuList.length,
          itemBuilder: (context, index) {
            return MenuButton(menu: _menuList[index], isProfile: index == 0, isLogout: index == _menuList.length-1);
          },
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      ]),
    );
  }
}
