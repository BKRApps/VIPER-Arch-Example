//
//  ListDataManager.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

class ListDataManager: NSObject {
    func contactsFromJson(responseJson:[Any]) -> [ContactEntity] {
        var contacts=[ContactEntity]()
        for contactDict in responseJson {
            let dict=contactDict as! [String:Any]
            let id=dict["id"] as! Int
            let fName=dict["first_name"] as! String
            let lName=dict["last_name"] as! String
            let pic=dict["profile_pic"] as! String
            let favorite=dict["favorite"] as! Bool
            let url=dict["url"] as! String
            contacts.append(ContactEntity(id: id, fName: fName, lName: lName, pic: pic, favorite: favorite, url: url))
        }
        return contacts
    }
}
