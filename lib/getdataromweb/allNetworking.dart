import 'package:bokaramstore/jsondata/add_new_product_json.dart';
import 'package:bokaramstore/jsondata/add_review_json.dart';
import 'package:bokaramstore/jsondata/cancel_order_json.dart';
import 'package:bokaramstore/jsondata/city_json.dart';
import 'package:bokaramstore/jsondata/create_account_json.dart';
import 'package:bokaramstore/jsondata/edit_profile_json.dart';
import 'package:bokaramstore/jsondata/empty_cart_json.dart';
import 'package:bokaramstore/jsondata/get_about_json.dart';
import 'package:bokaramstore/jsondata/get_all_department_json.dart';
import 'package:bokaramstore/jsondata/get_all_myfavorite_json.dart';
import 'package:bokaramstore/jsondata/get_all_products_category_json.dart';
import 'package:bokaramstore/jsondata/get_all_products_json.dart';
import 'package:bokaramstore/jsondata/get_cart_json.dart';
import 'package:bokaramstore/jsondata/get_cities_json.dart';
import 'package:bokaramstore/jsondata/get_contact_info_json.dart';
import 'package:bokaramstore/jsondata/get_home_json.dart';
import 'package:bokaramstore/jsondata/get_list_notifications_JSON.dart';
import 'package:bokaramstore/jsondata/get_notification_details_json.dart';
import 'package:bokaramstore/jsondata/get_old_orders_json.dart';
import 'package:bokaramstore/jsondata/get_order_details_json.dart';
import 'package:bokaramstore/jsondata/get_products_details_json.dart';
import 'package:bokaramstore/jsondata/get_search_name_json.dart';
import 'package:bokaramstore/jsondata/login_account_json.dart';
import 'package:bokaramstore/jsondata/preparation_profile_json.dart';
import 'package:bokaramstore/jsondata/set_user_data_json.dart';
import 'package:bokaramstore/jsondata/update_order_json.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class AllNetworking {
  var paseurl = 'https://bokaramstore.com';

  //Response response;
  Dio dio = new Dio();

  Future<Get_home_json> Get_home({
    @required String lang,
    @required String token_id,
  }) async {
    Get_home_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_home',
      data: formData,
    )
        .then((value) {

      data = Get_home_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_all_department_json> get_all_department({
    @required String lang,
    @required String token_id,
  }) async {
    Get_all_department_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_all_department',
      data: formData,
    )
        .then((value) {
          print(value);
      data = Get_all_department_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_all_products_json> get_all_products({
    @required String lang,
    @required int limit,
    @required int page_number,
    @required int deb_id,
    @required String token_id,
  }) async {
    Get_all_products_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "limit": limit,
      "page_number": page_number,
      "dep_id": deb_id,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_all_products',
      data: formData,
    )
        .then((value) {
      data = Get_all_products_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_about_json> get_about({
    @required String lang,
  }) async {
    Get_about_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/get_about',
      data: formData,
    )
        .then((value) {
      data = Get_about_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_contact_info_json> get_contact_info({
    @required String lang,
  }) async {
    Get_contact_info_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/get_contact_info',
      data: formData,
    )
        .then((value) {
      data = Get_contact_info_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future create_message({
    @required String lang,
    @required String name,
    @required String phone,
    @required String email,
    @required String subject,
    @required String message,
  }) async {
    var response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "name": name,
      "phone": phone,
      "email": email,
      "subject": subject,
      "message": message,
    });
    await dio
        .post(
      paseurl + '/store_api/create_message',
      data: formData,
    )
        .then((value) {
      response = value.data;
    });
    //  print(data.result.contactInfo[0].);
    return response;
  }

  Future<Create_account_json> create_account({
    @required String phone,
    @required String password,
    @required String firebase_token,
    @required String lang,
    @required String email,
    @required String name,
  }) async {
    Create_account_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "phone": phone,
      "password": password,
      "firebase_token": firebase_token,
      "email": email,
      "name": name,
    });
    await dio
        .post(
      paseurl + '/store_api/create_account',
      data: formData,
    )
        .then((value) {
      data = Create_account_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Login_account_json> login_account({
    @required String phone,
    @required String password,
    @required String firebase_token,
    @required String lang,
  }) async {
    Login_account_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "phone": phone,
      "password": password,
      "firebase_token": firebase_token,
    });
    await dio
        .post(
      paseurl + '/store_api/login_account',
      data: formData,
    )
        .then((value) {
      print('99999999999999999999999999999999999999999999999');
          print(value.data);
      data = Login_account_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_products_details_json> get_products_details({
    @required String product_id,
    @required String lang,
    @required String token_id,
  }) async {
    Get_products_details_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "product_id": product_id,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_products_details',
      data: formData,
    )
        .then((value) {
      data = Get_products_details_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Gdd_new_product_json> add_new_product({
    @required int id_product,
    @required int id_key,
    @required String token_id,
    int id_order,
  }) async {
    Gdd_new_product_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "id_product": id_product,
      "id_key": id_key,
      "token_id": token_id,
      "id_order": id_order,
    });
    await dio
        .post(
      paseurl + '/store_api/add_new_product',
      data: formData,
    )
        .then((value) {
      data = Gdd_new_product_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_cart_json> get_cart({
    @required String lang,
    @required String token_id,
  }) async {
    Get_cart_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_cart',
      data: formData,
    )
        .then((value) {
      data = Get_cart_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Update_order_json> update_order({
    @required int id_product,
    @required int id_key,
    @required String token_id,
    @required String lang,
    @required int id_order,
    @required int quantity_new,
  }) async {
    Update_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "id_product": id_product,
      "id_key": id_key,
      "token_id": token_id,
      "lang": lang,
      "id_order": id_order,
      "quantity_new": quantity_new,
    });
    await dio
        .post(
      paseurl + '/store_api/update_order',
      data: formData,
    )
        .then((value) {
      data = Update_order_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Empty_cart_json> empty_cart({
    @required String lang,
    @required String token_id,
    @required int id_order,
  }) async {
    Empty_cart_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": id_order,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/empty_cart',
      data: formData,
    )
        .then((value) {
      data = Empty_cart_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Set_user_data_json> set_user_data({
    @required String phone,
    @required String token_id,
    @required String lang,
    @required int share_value,
    @required int city_id,
    @required String address,
    @required int id_order,
    @required String fullname,
    @required String anther_address,
  }) async {
    Set_user_data_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
      "phone": phone,
      "share_value": share_value,
      "city_id": city_id,
      "address": address,
      "anther_address": anther_address,
      "id_order": id_order,
      "fullname": fullname,
    });
    await dio
        .post(
      paseurl + '/store_api/set_user_data',
      data: formData,
    )
        .then((value) {
      data = Set_user_data_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<City_json> preperation_order_details({
    @required String lang,
    @required String token_id,
    @required int order_id,
  }) async {
    City_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "order_id": order_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/preperation_order_details',
      data: formData,
    )
        .then((value) {
      data = City_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_old_orders_json> get_old_orders({
    @required String lang,
    @required String token_id,
  }) async {
    Get_old_orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_old_orders',
      data: formData,
    )
        .then((value) {
      data = Get_old_orders_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Cancel_order_json> cancel_order({
    @required String lang,
    @required String token_id,
    @required int order_id,
  }) async {
    Cancel_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": order_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/cancel_order',
      data: formData,
    )
        .then((value) {
      data = Cancel_order_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Cancel_order_json> delete_order({
    @required String lang,
    @required String token_id,
    @required int order_id,
  }) async {
    Cancel_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": order_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/delete_order',
      data: formData,
    )
        .then((value) {
      data = Cancel_order_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Cancel_order_json> update_myfavorite({
    @required int id_product,
    @required int id_key,
    @required String token_id,
    @required String lang,
  }) async {
    Cancel_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "id_product": id_product,
      "id_key": id_key,
      "token_id": token_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/update_myfavorite',
      data: formData,
    )
        .then((value) {
          print(value);
      data = Cancel_order_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_all_myfavorite_json> get_all_myfavorite({
    @required String lang,
    @required int limit,
    @required int page_number,
    @required String token_id,
  }) async {
    Get_all_myfavorite_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "limit": limit,
      "page_number": page_number,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_all_myfavorite',
      data: formData,
    )
        .then((value) {
      data = Get_all_myfavorite_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_order_details_json> get_order_details({
    @required int id_order,
    @required String lang,
    @required String token_id,
  }) async {
    Get_order_details_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "id_order": id_order,
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_order_details',
      data: formData,
    )
        .then((value) {
      data = Get_order_details_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Add_review_json> add_review({
    @required int product_id,
    @required int rating,
    @required String token_id,
    @required String lang,
  }) async {
    Add_review_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "product_id": product_id,
      "rating": rating,
      "token_id": token_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/store_api/add_review',
      data: formData,
    )
        .then((value) {
      data = Add_review_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }








  Future<Preparation_profile_json> preparation_profile({
    @required String lang,
    @required String token_id,
  }) async {
    Preparation_profile_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/preparation_profile',
      data: formData,
    )
        .then((value) {
      data = Preparation_profile_json.fromJson(value.data);
    });

    return data;
  }





  Future<Get_cities_json> get_cities({
    @required String lang,
    @required String token_id,
  }) async {
    Get_cities_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_cities',
      data: formData,
    )
        .then((value) {
      data = Get_cities_json.fromJson(value.data);
  print(data.result);  });

    return data;
  }






  Future<Edit_profile_json> edit_profile({
    @required String phone,
    @required String token_id,
    @required String lang,

    @required int city_id,
    @required String address,

    @required String fullname,  @required String email,  @required String password,
     @required String sex,
  }) async {
    Edit_profile_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
      "phone": phone,

      "city_id": city_id,
      "address": address,
      "email": email,

      "name": fullname, "password": password,"sex": sex,
    });
    await dio
        .post(
      paseurl + '/store_api/edit_profile',
      data: formData,
    )
        .then((value) {
      data = Edit_profile_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future  logout({
    @required String lang,
    @required String token_id,
  }) async {

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/logout',
      data: formData,
    )
        .then((value) {

      print(value.data);  });


  }









  Future<Get_search_name_json> get_search_name({
    @required String name,
    @required String lang,
    @required String token_id,
  }) async {
    Get_search_name_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "name": name,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_search_name',
      data: formData,
    )
        .then((value) {
          print(value.data);
      data = Get_search_name_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }





  Future<Get_all_products_category_json> get_all_products_category({
    @required String lang,
    @required int limit,
    @required int page_number,
    @required String dep_id,
    @required String token_id,
  }) async {
    Get_all_products_category_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "lang": lang,
      "limit": limit,
      "page_number": page_number,
      "cat_id": dep_id,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/store_api/get_all_products_category',
      data: formData,
    )
        .then((value) {
          print(value.data);
      data = Get_all_products_category_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_list_notifications_JSON> get_list_notifications({
    @required String phone,
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_list_notifications_JSON data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/store_api/get_list_notifications',
      data: formData,
    )
        .then((value) {
      data = Get_list_notifications_JSON.fromJson(value.data);
    });

    return data;
  }


  Future<Get_notification_details_json>  get_notification_details({
    @required String token_id,@required int id_notify,
  }) async {
    Get_notification_details_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,"id_notify": id_notify,
    });

    await dio
        .post(
      paseurl + '/store_api/get_notification_details',
      data: formData,
    )
        .then((value) {
      data = Get_notification_details_json.fromJson(value.data);
    });

    return data;
  }
  Future<Response> delete_notification({
    @required String token_id,
    @required int id_notify,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_notify": id_notify,
    });
    response = await dio.post(
      paseurl + '/store_api/delete_notification',
      data: formData,
    );

    return response;
  }
}
