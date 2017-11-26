//
//  AddEditInteractor.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

let AddContactEndPoint="http://gojek-contacts-app.herokuapp.com/contacts.json"

class AddEditInteractor: NSObject,AddEditInteractorInput {
    var output:AddEditInteractorOutput?
    
    func addContact(conatctInfo: [String : AnyObject]) {
        var headerParams=[String:AnyObject]()
        headerParams["Content-Type"]="application/json" as AnyObject
        NetworkManager.makeANetworkCall(endpoint: AddContactEndPoint, headerParams: headerParams, bodyParams: conatctInfo, requestMethod: HttpRequestMethod.Post){[weak self](data,response,error) in
            let unknownError="unable to add contact right now. please try again later"
            if let e=error{
                self?.output?.addedContact(error: e)
            }else if let responseData=data{
                do{
                    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String:AnyObject]
                    if responseJson["id"] != nil{
                        self?.output?.addedContact(error: nil)
                    }else{
                        let errorMessage=responseJson["errors"] as! [String]
                        self?.output?.addedContact(error: ContactAppError.ErrorWithInfo(errorMessage[0]))
                    }
                    NotificationCenter.default.post(name: AddUpdateDeleteNotificationName, object: nil)
                }catch{
                    print("Exception while parsing the data \(error)")
                    self?.output?.addedContact(error: ContactAppError.ErrorWithInfo(unknownError))
                }
            }else{
                self?.output?.addedContact(error: ContactAppError.ErrorWithInfo(unknownError))
            }
        }
    }
    
    func updateContact(contact: ContactEntity, updatedInfo: [String : AnyObject]) {
        var headerParams=[String:AnyObject]()
        headerParams["Content-Type"]="application/json" as AnyObject
        NetworkManager.makeANetworkCall(endpoint: contact.url, headerParams: headerParams, bodyParams: updatedInfo, requestMethod: HttpRequestMethod.Put){[weak self](data,response,error) in
            let unknownError="unable to update contact right now. please try again later."
            if let e=error{
                self?.output?.updatedContact(error: e)
            }else if let responseData=data{
                do{
                    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String:AnyObject]
                    print(responseJson)
                    self?.output?.updatedContact(error: nil)
                    NotificationCenter.default.post(name: AddUpdateDeleteNotificationName, object: nil)
                }catch{
                    self?.output?.updatedContact(error: ContactAppError.ErrorWithInfo(unknownError))
                }
            }else{
                self?.output?.updatedContact(error: ContactAppError.ErrorWithInfo(unknownError))
            }
        }
    }
}
