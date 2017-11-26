//
//  DetailViewController.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,DetailViewInterface {

    var eventHandler:DetailModuleInterface?
    var contact:ContactEntity?
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.createCircularImageView(width: 1.0, radius: profilePic.frame.size.width/2, color: UIColor.lightGray.cgColor)
        addContactObservers()
        getContactDetails()
        profileView.addGradientLayer(colors: nil, startPoint: CGPoint(x:0.5,y:1), endPoint: CGPoint(x:0.5,y:0))
    }
    
    func getContactDetails(notification:Notification?=nil){
        if let ct=contact{
            eventHandler?.getFullContactDetails(contactId: ct.id)
        }
    }

    func clickedOnEdit(sender:UIBarButtonItem){
        if let ct=contact {
            eventHandler?.editContact(contact: ct)
        }
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        let alertController = UIAlertController(title: "Warning", message:"are you sure want to delete the contact ? ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ok", style: .default,handler: {[unowned self](action)->() in
            if let ct=self.contact{
                self.eventHandler?.deleteContact(contactUrl: ct.url)
                self.navigationController?.popViewController(animated: true)
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func clickedOnMessage(_ sender: Any) {
        if let smsURL=URL(string: "sms:") {
            UIApplication.shared.openURL(smsURL)
        }
    }
    
    @IBAction func clickedOnCall(_ sender: Any) {
        if let callURL=URL(string: "tel:") {
            UIApplication.shared.openURL(callURL)
        }
    }
    
    @IBAction func clickedOnEmail(_ sender: Any) {
        if let mailURL=URL(string: "mailto:") {
            UIApplication.shared.openURL(mailURL)
        }
    }
    
    @IBAction func clickedOnFav(_ sender: Any) {
        eventHandler?.updateContactDetails(contact: contact!, updatedInfo: ["favorite":!(contact?.favorite)! as AnyObject])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: AddUpdateDeleteNotificationName, object: nil)
    }
}

extension DetailViewController{
    
    func showContactDetails(contactDetail: ContactDetail?) {
        fullName.text=contactDetail?.fullName
        contact?.emailId=contactDetail?.email
        contact?.phoneNumber=contactDetail?.phoneNumber
        mobileNumber.text=contactDetail?.phoneNumber
        if let isFav=contactDetail?.favorite{
            contact?.favorite=isFav
            favButton.imageView?.image=isFav ? UIImage(named: "favourite_button_selected") : UIImage(named:"favourite_button")
        }
        email.text=contactDetail?.email
        if let pic=contactDetail?.profilePic,let imageUrl=URL(string:"http://gojek-contacts-app.herokuapp.com"+pic){
            ImageRepository.sharedInstance.fetchImageFromServer(imageUrl: imageUrl){[weak self] (image,url,error)->() in
                if imageUrl.absoluteString == url.absoluteString, let img=image{
                    DispatchQueue.main.async {
                        self?.profilePic.image=img
                    }
                }
            }
        }
    }
    
    func unableToFetchContactDetails(error: ContactAppError?) {
        let alertController = UIAlertController(title: "Error", message:"unable to fetch contact details. please try again", preferredStyle: UIAlertControllerStyle.alert)
        let action=UIAlertAction(title: "Dismiss", style: .default){ (action)->Void in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func deletedContact() {
        print("contact deleted successfully")
    }
    
    func unableToDeleteContact(error: ContactAppError) {
        showErrorDismissAlert(title: "Warning", message: "unable to delete the contact right now.")
    }
}

extension DetailViewController{
    func addContactObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.getContactDetails(notification:)), name: AddUpdateDeleteNotificationName, object: nil)
    }
}
