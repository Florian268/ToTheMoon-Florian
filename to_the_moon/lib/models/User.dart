import 'dart:ffi';
import 'package:flutter/material.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:collection';
import 'package:to_the_moon/models/stock.dart';


import 'package:flutter/services.dart';

class UserModel {

  int userId = 0;
  int balance = 1000;
  int cash = 1000;
  int gains = 0;
  int loss = 0;
  bool acceptAgreement = false;
  HashMap<String, int> stocksOwned = HashMap<String, int>();
  List<StockModel> stocks = [];

  UserModel(this.userId, this.cash, this.acceptAgreement, this.stocksOwned); //  this.ownedStock

  /*
  HashMap<String, int> getStock(){
    return ownedStock;
  }
   */

  void setAgreement(){
    acceptAgreement = true;
  }

  dynamic getStockAmount(String name){
    if(!stocksOwned.containsKey(name)){
      return 0;
    }
    return stocksOwned[name];
  }

  
  getStocksOwned(){
    return stocksOwned;
  }
  
  getStocks(){
    return stocks;
  }

  void addStock(String name, int amount, StockModel s) {
    // attempts to add stock if key doesn't exist adds new entry
    // ! in !+ is a null check
    if(!stocks.contains(s)){
      stocks.add(s);
    }
    stocksOwned.update(name, (e) => (stocksOwned[name]! + amount), ifAbsent: () => amount);
   
  }

  void removeStock(String name, int amount, StockModel s){
    // attempts to add stock if key doesn't exist adds new entry
    // ! in !- is a null check
    stocksOwned.update(name, (e) => (stocksOwned[name]!-amount));
    if(s.getNumOwned() <= 0) stocks.remove(s);
  }

  void addCash(int amount){
    cash = cash+amount;
  }

  //called when market updates stocks
  void updateBalance(int amount){
    balance += amount;
    if(amount < 0){
      loss += (-amount);
      gains += amount;
    }else{
      loss -= amount;
      gains += amount;
    }
  }

  void addBalance(int amount){
    balance += amount;
  }

  void removeCash(int amount){
    cash = cash-amount;
  }

  int getCash(){
    return cash;
  }
  int getBalance(){
    return balance;
  }

  int getLoss(){
    return loss;
  }

  int getGain(){
    return gains;
  }

  

  UserModel.fromJson(Map<String, dynamic> json){
    userId = json["userId"];
    cash = json['cash'];
    acceptAgreement = json["acceptAgreement"];
    stocksOwned = HashMap<String, int>.from(jsonDecode(json['stocksOwned']));
  }

  UserModel.fromMap(Map<String, dynamic> json){
    userId = json["userId"];

    if(json["acceptAgreement"] == "1"){
      acceptAgreement = true;
    }else{
      acceptAgreement = false;
    }
    cash = json["cash"];
    stocksOwned = HashMap<String, int>.from(jsonDecode(json['stocksOwned']));
  }

  Map<String, dynamic> toMap() =>{
    'userId': userId,
    'cash' : cash,
    'stocksOwned' : stocksOwned,
    'acceptAgreement': acceptAgreement,
  };
}

