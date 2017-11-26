//
//  ListPresenter.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

class ListPresenter:NSObject,ListModuleInterface,ListInteractorOutput {
    var userInterface:ListVIewInterface?
    var listInteractor:ListInteractorInput?
    var listWireframe:ListWireframe?
    var contactDisplayCollection:ContactDisplayCollection?
    
    func getListOfContacts() {
        DispatchQueue.global().async {
            self.listInteractor?.getListOfContacts()
        }
    }
    
    func getContactDetail(contact: ContactEntity) {
        listWireframe?.showContactDetailInterface(contact: contact)
    }
    
    func generateIndexSearch(){
        var search=IndexSearch()
        search.prepareIndexSearchData()
        self.userInterface?.generatedIndexSearch(indexSearch: search)
    }
    
    func clickedOnIndexSearch(key: String) {
        userInterface?.scrollContactListToSpecifiedSection(section: key)
    }
    
    func postContactList(contacts: [ContactEntity]?,error:ContactAppError?){
        if let e=error{
            self.userInterface?.unableToFetchContacts(error: e)
        }else if let c=contacts{
            var contactDisplayCollection=ContactDisplayCollection()
            contactDisplayCollection.prepareContactsSections(contacts: c)
            self.contactDisplayCollection=contactDisplayCollection
            self.userInterface?.showContactList(contactCollection: contactDisplayCollection)
        }
    }
    
    func addNewContact() {
        listWireframe?.presentAddConatctInterface()
    }
}
