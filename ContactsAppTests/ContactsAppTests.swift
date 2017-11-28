//
//  ContactsAppTests.swift
//  ContactsAppTests
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactsAppTests: XCTestCase {
    
    var contactsJsonPath:String!
    var contactsJsonData:Data?
    
    override func setUp() {
        super.setUp()
        let testBundle = Bundle(for: type(of: self))
        contactsJsonPath = testBundle.path(forResource: "Contacts", ofType: "json")
        contactsJsonData = try? Data(contentsOf: URL(fileURLWithPath: contactsJsonPath), options: .alwaysMapped)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testModelContactsFromJson(){
        let dataManager=ListDataManager()
        if let data=contactsJsonData{
            do{
                let jsonData=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Any]
                let contacts=dataManager.contactsFromJson(responseJson: jsonData)
                XCTAssertEqual(contacts.count,6)
            }catch{
                
            }
        }
    }
    
    func testModelContactSectionFromContacts(){
        let dataManager=ListDataManager()
        var contactDisplayCollection=ContactDisplayCollection()
        if let data=contactsJsonData{
            do{
                let jsonData=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Any]
                let contacts=dataManager.contactsFromJson(responseJson: jsonData)
                contactDisplayCollection.prepareContactsSections(contacts: contacts)
                XCTAssertEqual(contactDisplayCollection.sections.count,5)
            }catch{
                
            }
        }
    }
    
    func testGenerationIndexSearch(){
        var indexSearch=IndexSearch()
        indexSearch.prepareIndexSearchData()
        XCTAssertEqual(indexSearch.sections.count, 27)
    }
    
    func testContactDetailFullName(){
        var contactDetail=ContactDetail(id: 10)
        contactDetail.firstName="kumar"
        contactDetail.lastName="reddy"
        XCTAssertEqual(contactDetail.fullName,"kumar reddy")
    }
    
    func testContactAppError(){
        let contactAppError=ContactAppError.ErrorWithInfo("testing the error message")
        XCTAssertEqual(contactAppError.getErrorMessage(), "testing the error message")
    }
    
    func testContactListApi(){
        let headerParams=["Content-Type":"application/json"] as [String:AnyObject]
        let semaphore=DispatchSemaphore(value: 0)
        NetworkManager.makeANetworkCall(endpoint: "http://gojek-contacts-app.herokuapp.com/contacts.json", headerParams: headerParams, bodyParams: nil, requestMethod: HttpRequestMethod.Get){ (data,response,error) in
            if let e=error{
                XCTFail("Error: \(e.getErrorMessage())")
            }else if let statusCode=(response as? HTTPURLResponse)?.statusCode{
                if statusCode==200{
                    semaphore.signal()
                }else{
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        if semaphore.wait(timeout: DispatchTime.now()+5)==DispatchTimeoutResult.timedOut{
            XCTFail("Failed to execute within time")
        }
    }
    
    func testContactDetailApi(){
        let headerParams=["Content-Type":"application/json"] as [String:AnyObject]
        let semaphore=DispatchSemaphore(value: 0)
        NetworkManager.makeANetworkCall(endpoint: "http://gojek-contacts-app.herokuapp.com/contacts/72.json", headerParams: headerParams, bodyParams: nil, requestMethod: HttpRequestMethod.Get){ (data,response,error) in
            if let e=error{
                XCTFail("Error: \(e.getErrorMessage())")
            }else if let statusCode=(response as? HTTPURLResponse)?.statusCode{
                if statusCode==200{
                    semaphore.signal()
                }else{
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        if semaphore.wait(timeout: DispatchTime.now()+5)==DispatchTimeoutResult.timedOut{
            XCTFail("Failed to execute within time")
        }
    }
    
    func testAddNewContactApi(){
        let headerParams=["Content-Type":"application/json"] as [String:AnyObject]
        var bodyParams=[String:AnyObject]()
        bodyParams["first_name"]="kumar" as AnyObject
        bodyParams["last_name"]="kumar" as AnyObject
        bodyParams["email"]="a@gmail.com" as AnyObject
        bodyParams["phone_number"]="9908123456" as AnyObject
        let semaphore=DispatchSemaphore(value: 0)
        NetworkManager.makeANetworkCall(endpoint: "http://gojek-contacts-app.herokuapp.com/contacts.json", headerParams: headerParams, bodyParams: bodyParams, requestMethod: HttpRequestMethod.Post){ (data,response,error) in
            if let e=error{
                XCTFail("Error: \(e.getErrorMessage())")
            }else if let statusCode=(response as? HTTPURLResponse)?.statusCode{
                if statusCode==201{
                    semaphore.signal()
                }else{
                    do{
                        let responseJson=try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                        XCTFail("Status code: \(statusCode) Response:\(responseJson)")
                    }catch{
                        XCTFail("Parse error\(error.localizedDescription)")
                    }
                }
            }
        }
        if semaphore.wait(timeout: DispatchTime.now()+5)==DispatchTimeoutResult.timedOut{
            XCTFail("Failed to execute within time")
        }
    }
    
    func testMockingContactList(){
        let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock=URLSessionMock(data: contactsJsonData!, resposne: urlResponse, error: nil)
        
        let listWireframe=ListWireframe()
        let presenter=ListPresenter()
        let interactor=ListInteractor()
        let dataManager=ListDataManager()

        listWireframe.listPresenter=presenter
        presenter.listInteractor=interactor
        interactor.output=presenter
        interactor.listDataManager=dataManager
        GJURLSessionHelper.sharedSession.urlSession=sessionMock
        presenter.getListOfContacts()
    }

    func testPresenter() {
        let listPresenter = ListPresenter()
        let listInteractor = ListInteractor()
        let listDataManager=ListDataManager()
        let dummyUserInterface = DummyUserInterface()
        listPresenter.listInteractor = listInteractor
        listPresenter.userInterface = dummyUserInterface
        listInteractor.output = listPresenter
        listInteractor.listDataManager = listDataManager
        let semaphore = DispatchSemaphore(value: 0)
        dummyUserInterface.semaphore = semaphore
        listPresenter.getListOfContacts()
        if semaphore.wait(timeout: DispatchTime.now()+5)==DispatchTimeoutResult.timedOut{
            XCTFail("Failed to execute within time")
        }
    }
}

class DummyUserInterface : ListVIewInterface {
    var semaphore : DispatchSemaphore!
    func showContactList(contactCollection:ContactDisplayCollection){
        print(contactCollection)
        semaphore.signal()
    }
    func unableToFetchContacts(error:ContactAppError?){
        print(error)
        semaphore.signal()
    }
    func generatedIndexSearch(indexSearch:IndexSearch){

    }
    func scrollContactListToSpecifiedSection(section:String){
        
    }
}
