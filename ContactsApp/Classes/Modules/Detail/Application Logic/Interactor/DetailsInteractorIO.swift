//
//  DetailsInteractorIO.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol DetailInteractorInput:class {
    func getContactDetails(contactId:Int)
    func deleteContact(contactUrl:String)
    func updateContactDetail(contact:ContactEntity,updatedInfo:[String:AnyObject])
}

protocol DetailsInteractorOutput:class {
    func updatedContactDetail(contactDetail:ContactDetail?,error:ContactAppError?)
    func postContactDetails(contactDetail:ContactDetail?,error:ContactAppError?)
    func deletedContact(error:ContactAppError?)
}
