//
//  AddEditViewController.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import UIKit

enum AddEditVCType {
    case add
    case edit
}

class AddEditViewController: UIViewController,AddEditViewInterface {
    var contact:ContactEntity?
    var addEditType=AddEditVCType.add
    var eventHandler:AddEditModuleInterface?
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var profileVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ct=contact {
            firstNameTF.text=ct.firstName
            lastNameTF.text=ct.lastName
            emailTF.text=ct.emailId
            mobileTF.text=ct.phoneNumber
        }
        profileVIew.addGradientLayer(colors: nil, startPoint: CGPoint(x:0.5,y:1), endPoint: CGPoint(x:0.5,y:0))
    }
    
    func clickedOnCancel(sender:UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    func clickedOnDone(sender:UIBarButtonItem){
        let contactData=getContactData()
        if contactData.0 {
            switch addEditType {
            case AddEditVCType.add:
                eventHandler?.addContact(conatctInfo: contactData.1!)
            case AddEditVCType.edit:
                eventHandler?.updateContact(contact: contact!, updatedInfo: contactData.1!)
            }
        }else{
            showErrorDismissAlert(title: "Invalid Input", message: "please fill all the fileds.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AddEditViewController{
    
    func getContactData()->(Bool,[String:AnyObject]?){
        var contactDict=[String:AnyObject]()
        if let fName=firstNameTF.text,let lName=lastNameTF.text,let email=emailTF.text,let phNumber=mobileTF.text{
            if fName.characters.count>0 && lName.characters.count>0 && email.characters.count>0 && phNumber.characters.count>0 {
                contactDict["first_name"]=fName as AnyObject
                contactDict["last_name"]=lName as AnyObject
                contactDict["email"]=email as AnyObject
                contactDict["phone_number"]=phNumber as AnyObject
                return (true,contactDict)
            }
        }
        return (false,nil)
    }
    
    func addedContact() {
        print("sucessfully added the contact")
        dismiss(animated: true, completion: nil)
    }
    
    func unableToAddContact(error: ContactAppError?) {
        showErrorDismissAlert(title: "Invalid Input", message: error?.getErrorMessage())
    }
    
    func updatedContact() {
        print("sucessfully updated the contact")
        dismiss(animated: true, completion: nil)
    }
    
    func unableToUpdateContact(error: ContactAppError?) {
        showErrorDismissAlert(title: "Invalid Input", message: error?.getErrorMessage())
    }
}
