//
//  ContactsAppUITests.swift
//  ContactsAppUITests
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import XCTest

class ContactsAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainHeaderName() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let header = app.navigationBars.containing(.staticText,identifier:"Contact").element
        XCTAssertTrue(header.exists)
    }
    
    func testDeleteButton(){
        let app = XCUIApplication()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            app.tables.staticTexts["kumar"].tap()
            app.buttons["Delete"].tap()
            let cancelButton = app.alerts["Warning"].buttons["Cancel"]
            let okButton = app.alerts["Warning"].buttons["Ok"]
            XCTAssertTrue(cancelButton.exists)
            XCTAssertTrue(cancelButton.isHittable)
            XCTAssertTrue(okButton.exists)
            XCTAssertTrue(okButton.isHittable)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                app.buttons["message button"].tap()
                XCUIDevice.shared().orientation = .portrait
                XCUIDevice.shared().orientation = .portrait
                app.statusBars.buttons["Return to GoJekContactsApp"].tap()
                XCUIDevice.shared().orientation = .portrait
                XCUIDevice.shared().orientation = .portrait
            })
        })
    }
    
    func testMessageButton(){
        let app = XCUIApplication()
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            app.tables.staticTexts["kumar"].tap()
            let messageButton =  app.buttons["message button"]
            XCTAssertTrue(messageButton.exists)
            XCTAssertTrue(messageButton.isHittable)
        }
    }
    
    func testEditButton(){
        let app = XCUIApplication()
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            app.tables.containing(.other, identifier:"K").children(matching: .cell).element(boundBy: 3).staticTexts["kumar"].tap()
            app.navigationBars["GoJekContactsApp.DetailView"].buttons["Edit"].tap()
            let editButton = app.navigationBars["GoJekContactsApp.AddEditView"].buttons["Done"]
            XCTAssertTrue(editButton.exists)
            XCTAssertTrue(editButton.isHittable)
        }
    }
    
    func testTextOfDetailScreen(){
        let app = XCUIApplication()
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            let contactName = app.staticTexts["kumar reddy"]
            XCTAssertTrue(contactName.exists)
            app.tables.containing(.other, identifier:"K").children(matching: .cell).element(boundBy: 3).staticTexts["kumar"].tap()
        }
    }
}
