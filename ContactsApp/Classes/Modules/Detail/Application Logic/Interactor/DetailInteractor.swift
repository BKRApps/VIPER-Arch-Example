//
//  DetailInteractor.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

class DetailInteractor: NSObject,DetailInteractorInput {
    weak var output:DetailsInteractorOutput?
    
    func getContactDetails(contactId: Int) {
        let contactDetailEndpoint="http://gojek-contacts-app.herokuapp.com/contacts/\(contactId).json"
        var headerParams=[String:AnyObject]()
        headerParams["Content-Type"]="application/json" as AnyObject
        NetworkManager.makeANetworkCall(endpoint: contactDetailEndpoint, headerParams: headerParams, bodyParams: nil, requestMethod: nil){[weak self](data,response,error) in
            let unknownError="unable to fetch contact details right now. please try again later"
            if let e=error{
                self?.output?.postContactDetails(contactDetail: nil, error: e)
            }else if let responseData=data{
                do{
                    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String:AnyObject]
                    if let id=responseJson["id"], let cId=id as? Int{
                        var contactDetail=ContactDetail(id: cId)
                        contactDetail.fillDataFromJson(responseJson: responseJson)
                        self?.output?.postContactDetails(contactDetail: contactDetail,error: nil)
                    }else{
                        self?.output?.postContactDetails(contactDetail: nil,error: ContactAppError.ErrorWithInfo(unknownError))
                    }
                }catch{
                    self?.output?.postContactDetails(contactDetail: nil,error: ContactAppError.ErrorWithInfo(unknownError))
                }
            }else{
                self?.output?.postContactDetails(contactDetail: nil,error: ContactAppError.ErrorWithInfo(unknownError))
            }
        }
    }
    
    func deleteContact(contactUrl: String) {
        NetworkManager.makeANetworkCall(endpoint: contactUrl,headerParams: nil, bodyParams: nil, requestMethod: HttpRequestMethod.Delete){[weak self](data,response,error) in
            let unknownError="unable to delete the contact right now. please try again later"
            if let e=error{
                self?.output?.deletedContact(error: e)
            }else if let _=data{
                    self?.output?.deletedContact(error:nil)
                    NotificationCenter.default.post(name: AddUpdateDeleteNotificationName, object: nil)
            }else{
                self?.output?.deletedContact(error: ContactAppError.ErrorWithInfo(unknownError))
            }
        }
    }
    
    func updateContactDetail(contact: ContactEntity, updatedInfo: [String : AnyObject]) {
        var headerParams=[String:AnyObject]()
        headerParams["Content-Type"]="application/json" as AnyObject
        NetworkManager.makeANetworkCall(endpoint: contact.url, headerParams: headerParams, bodyParams: updatedInfo, requestMethod: HttpRequestMethod.Put){[weak self](data,response,error) in
            let unknownError="unable to update contact right now. please try again later."
            if let e=error{
                self?.output?.updatedContactDetail(contactDetail: nil, error: e)
            }else if let responseData=data{
                do{
                    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String:AnyObject]
                    if let id=responseJson["id"], let cId=id as? Int{
                        var contactDetail=ContactDetail(id: cId)
                        contactDetail.fillDataFromJson(responseJson: responseJson)
                        self?.output?.postContactDetails(contactDetail: contactDetail,error: nil)
                        self?.output?.updatedContactDetail(contactDetail: contactDetail, error: nil)
                    }
                    NotificationCenter.default.post(name: AddUpdateDeleteNotificationName, object: nil)
                }catch{
                    self?.output?.updatedContactDetail(contactDetail: nil, error: ContactAppError.ErrorWithInfo(unknownError))
                }
            }else{
                self?.output?.updatedContactDetail(contactDetail: nil, error: ContactAppError.ErrorWithInfo(unknownError))
            }
        }
    }
}
