//
//  AddEditInteractorIO.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol AddEditInteractorInput: NSObjectProtocol {
    func addContact(conatctInfo:[String:AnyObject])
    func updateContact(contact:ContactEntity,updatedInfo:[String:AnyObject])
}

protocol AddEditInteractorOutput {
    func addedContact(error:ContactAppError?)
    func updatedContact(error:ContactAppError?)
}
