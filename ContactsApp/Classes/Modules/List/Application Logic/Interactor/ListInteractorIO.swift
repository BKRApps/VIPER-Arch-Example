//
//  ListInteractorIO.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol ListInteractorInput {
    func getListOfContacts()
}

protocol ListInteractorOutput {
    func postContactList(contacts:[ContactEntity]?,error:ContactAppError?)
}
