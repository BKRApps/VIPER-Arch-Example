//
//  DetailPresenter.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

class DetailPresenter: NSObject,DetailModuleInterface,DetailsInteractorOutput {
    weak var userInterface:DetailViewInterface?
    var interactor:DetailInteractorInput?
    var detailWireframe:DetailWireframe?
    
    func getFullContactDetails(contactId: Int) {
        interactor?.getContactDetails(contactId: contactId)
    }
    
    func deleteContact(contactUrl: String) {
        interactor?.deleteContact(contactUrl: contactUrl)
    }
    
    func editContact(contact: ContactEntity) {
        detailWireframe?.presentAddEditInterface(contact: contact)
    }
    
    func updateContactDetails(contact: ContactEntity, updatedInfo: [String : AnyObject]) {
        interactor?.updateContactDetail(contact: contact, updatedInfo: updatedInfo)
    }
}

extension DetailPresenter{
    
    func postContactDetails(contactDetail: ContactDetail?,error:ContactAppError?) {
        DispatchQueue.main.async {
            if let e=error{
                self.userInterface?.unableToFetchContactDetails(error: e)
            }else{
                self.userInterface?.showContactDetails(contactDetail: contactDetail)
            }
        }
    }

    func deletedContact(error: ContactAppError?) {
        DispatchQueue.main.async {
            if let e=error{
                self.userInterface?.unableToDeleteContact(error: e)
            }else{
                self.userInterface?.deletedContact()
            }
        }
    }
    
    func updatedContactDetail(contactDetail: ContactDetail?, error: ContactAppError?) {
        DispatchQueue.main.async {
            self.userInterface?.showContactDetails(contactDetail: contactDetail)
        }
    }
}
