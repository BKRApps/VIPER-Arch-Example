//
//  ListInteractor.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

let ContactListEndpoint="http://gojek-contacts-app.herokuapp.com/contacts.json"
class ListInteractor:ListInteractorInput {
    var output:ListInteractorOutput?
    var listDataManager:ListDataManager?
    
    func getListOfContacts() {
        var headerParams=[String:AnyObject]()
        headerParams["Content-Type"]="application/json" as AnyObject
        NetworkManager.makeANetworkCall(endpoint: ContactListEndpoint, headerParams: headerParams, bodyParams: nil, requestMethod: nil){[weak self](data,response,error) in
            let unknownError="unable to retrive contacts right now. please try again later."
            if let e=error{
                self?.output?.postContactList(contacts: nil, error: e)
            }else if let responseData=data{
                do{
                    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [Any]
                    let contactList=self?.listDataManager?.contactsFromJson(responseJson: responseJson)
                    if let cList=contactList{
                        self?.output?.postContactList(contacts: cList,error: nil)
                    }else{
                        self?.output?.postContactList(contacts: nil,error: ContactAppError.ErrorWithInfo(unknownError))
                    }
                }catch{
                    self?.output?.postContactList(contacts: nil,error: ContactAppError.ErrorWithInfo(unknownError))
                }
            }else{
                self?.output?.postContactList(contacts: nil,error: ContactAppError.ErrorWithInfo(unknownError))
            }
        }
    }
}
