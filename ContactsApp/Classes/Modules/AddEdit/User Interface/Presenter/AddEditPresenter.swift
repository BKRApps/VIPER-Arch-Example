//
//  AddEditPresenter.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

class AddEditPresenter: NSObject,AddEditModuleInterface,AddEditInteractorOutput {
    var userInterface:AddEditViewInterface?
    var interactor:AddEditInteractorInput?
    
    func addContact(conatctInfo: [String : AnyObject]) {
        interactor?.addContact(conatctInfo: conatctInfo)
    }
    
    func updateContact(contact: ContactEntity, updatedInfo: [String : AnyObject]) {
        interactor?.updateContact(contact: contact, updatedInfo: updatedInfo)
    }
}

extension AddEditPresenter{
    func addedContact(error:ContactAppError?) {
        DispatchQueue.main.async {
            if let e=error {
                self.userInterface?.unableToAddContact(error: e)
            }else{
                self.userInterface?.addedContact()
            }
        }
    }
    
    func updatedContact(error:ContactAppError?) {
        DispatchQueue.main.async {
            if let e=error{
                self.userInterface?.unableToUpdateContact(error: e)
            }else{
                self.userInterface?.updatedContact()
            }
        }
    }
}
