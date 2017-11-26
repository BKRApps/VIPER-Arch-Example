//
//  ContactDetail.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

struct ContactDetail {
    let id:Int
    var firstName,lastName,email,phoneNumber,profilePic:String?
    var favorite:Bool?
    
    var fullName:String{
        var name:String=""
        if let f=firstName{
            name=name.appending(f)
        }
        if let l=lastName{
            name=name.appending(" ")
            name=name.appending(l)
        }
        return name
    }
    
    init(id:Int) {
        self.id=id
    }
    
    mutating func fillDataFromJson(responseJson:[String:AnyObject]) {
        firstName=responseJson["first_name"] as? String
        lastName=responseJson["last_name"] as? String
        email=responseJson["email"] as? String
        phoneNumber=responseJson["phone_number"] as? String
        profilePic=responseJson["profile_pic"] as? String
        favorite=responseJson["favorite"] as? Bool
    }
}
