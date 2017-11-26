//
//  AddEditViewInterface.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
 
protocol AddEditViewInterface {
    func addedContact()
    func updatedContact()
    func unableToAddContact(error:ContactAppError?)
    func unableToUpdateContact(error:ContactAppError?)
}
