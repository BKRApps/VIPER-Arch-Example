//
//  ListViewInterface.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

protocol ListVIewInterface {
    func showContactList(contactCollection:ContactDisplayCollection)
    func unableToFetchContacts(error:ContactAppError?)
    func generatedIndexSearch(indexSearch:IndexSearch)
    func scrollContactListToSpecifiedSection(section:String)
}
