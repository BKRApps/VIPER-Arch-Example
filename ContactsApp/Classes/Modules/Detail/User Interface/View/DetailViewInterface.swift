//
//  DetailViewInterface.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol DetailViewInterface:class {
    func showContactDetails(contactDetail:ContactDetail?)
    func unableToFetchContactDetails(error:ContactAppError?)
    func deletedContact()
    func unableToDeleteContact(error:ContactAppError)
}
