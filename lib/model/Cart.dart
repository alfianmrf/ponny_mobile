import 'package:flutter/material.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/Product.dart';

class CartModel with ChangeNotifier{
  List<Cart> listCardOfitem=[];
  bool loadingCard = false;
  CartModel();

 Future<void> addProductToCart(Product product) async
 {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    print( product.id);
    print(index);
    if(index < 0){
      listCardOfitem.add(Cart(1, product));
    }else{
      listCardOfitem.elementAt(index).quantity++;
    }
    notifyListeners();
 }

  Future<void> RemoveProductToCart(Product product) async
  {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    print(index);
    if(listCardOfitem.elementAt(index).quantity > 1){
      listCardOfitem.elementAt(index).quantity--;
      notifyListeners();
    }

  }

  Future<void> DeleteProductToCart(Product product) async
  {
    int index = listCardOfitem.indexWhere((element) => element.product.id == product.id);
    listCardOfitem.removeAt(index);
    notifyListeners();


  }

 int getCountOfquantity(){
   int jml=0;
   for(Cart item in listCardOfitem){
     jml+=item.quantity;
   }
   return jml;
 }

 int getSubtotal(){
   int subtotal=0;
   for(Cart item in listCardOfitem){
     subtotal+=item.quantity*item.product.base_discounted_price;
   }
   return subtotal;
 }
}
class Cart{
  int quantity;
  Product product;
  Cart(this.quantity, this.product);

}