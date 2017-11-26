//
//  ListModuleInterface.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol ListModuleInterface {
    func getListOfContacts()
    func getContactDetail(contact:ContactEntity)
    func generateIndexSearch()
    func clickedOnIndexSearch(key:String)
    func addNewContact()
}
