//
//  ContactEntity.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

struct ContactEntity {
    let id:Int
    let firstName:String
    let lastName:String
    let profilePic:String
    var favorite:Bool
    let url:String
    var emailId:String?
    var phoneNumber:String?
    
    init(id:Int,fName:String,lName:String,pic:String,favorite:Bool,url:String) {
        self.id=id
        self.firstName=fName
        self.lastName=lName
        self.profilePic=pic
        self.favorite=favorite
        self.url=url
    }
}
