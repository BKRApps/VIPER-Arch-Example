//
//  DetailModuleInterface.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol DetailModuleInterface:class {
    func getFullContactDetails(contactId:Int)
    func deleteContact(contactUrl:String)
    func editContact(contact:ContactEntity)
    func updateContactDetails(contact:ContactEntity,updatedInfo:[String:AnyObject])
}
