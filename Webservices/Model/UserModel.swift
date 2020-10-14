//
//  UserModel.swift
//  Webservices
//
//  Created by Ahmed Nasr on 10/13/20.
//

import Foundation

/*
 [
   {
     "id": 1,
     "name": "Leanne Graham",
     "username": "Bret",
     "email": "Sincere@april.biz",
     "address": {
       "street": "Kulas Light",
       "suite": "Apt. 556",
       "city": "Gwenborough",
       "zipcode": "92998-3874",
       "geo": {
         "lat": "-37.3159",
         "lng": "81.1496"
       }
     },
     "phone": "1-770-736-8031 x56442",
     "website": "hildegard.org",
     "company": {
       "name": "Romaguera-Crona",
       "catchPhrase": "Multi-layered client-server neural-net",
       "bs": "harness real-time e-markets"
     }
   },
 */


struct UserModel {
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?

    //Address Members
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?

    //Geo Members
    var lat: String?
    var lng: String?
    
    var phone: String?
    var website: String?
    
    //Company
    var companyName: String?
    var catchPhrase: String?
    var bs: String?
}
