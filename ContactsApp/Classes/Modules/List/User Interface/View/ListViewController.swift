//
//  ListViewController.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import UIKit

let ContactCellIdetenifier="contactIdentifier"
let IndexCellIdetenifier="indexSearchIdentifier"
let AddUpdateDeleteNotificationName = Notification.Name("ContactsAddedOrUpdatedNotification")

class ListViewController: UIViewController,ListVIewInterface {
    var eventHandler:ListModuleInterface?
    var contactDisplayCollection:ContactDisplayCollection?
    var indexSearch:IndexSearch?
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var contactsAI: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reloadContacts: UIButton!
    @IBOutlet weak var contactsTV: UITableView!
    @IBOutlet weak var indexSearchTV: UITableView!
    @IBOutlet weak var indexSearchTVTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var indexSearchTVBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTV.estimatedRowHeight=50
        contactsTV.rowHeight=UITableViewAutomaticDimension
        indexSearchTV.estimatedRowHeight=25
        indexSearchTV.rowHeight=UITableViewAutomaticDimension
        addContactObservers()
        getContactList()
    }
    
    func getContactList(notification:Notification?=nil){
        loadingView.isHidden=false
        contactsAI.startAnimating()
        statusLabel.text="loading contacts...please wait"
        eventHandler?.getListOfContacts()
    }
    
    @IBAction func reloadContacts(_ sender: Any) {
        reloadContacts.isHidden=true
        getContactList()
    }
    
    func clickedOnAdd(sender:UIBarButtonItem){
        eventHandler?.addNewContact()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: AddUpdateDeleteNotificationName, object: nil)
    }
}

extension ListViewController {
    func showContactList(contactCollection: ContactDisplayCollection) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2){
                self.loadingView.isHidden=true
                self.contactsAI.stopAnimating()
                self.contactDisplayCollection=contactCollection
                if self.indexSearch == nil {
                    self.eventHandler?.generateIndexSearch()
                }
                self.contactsTV.reloadData()
            }
        }
    }
    
    func unableToFetchContacts(error: ContactAppError?) {
        DispatchQueue.main.async {
            self.contactsAI.stopAnimating()
            self.loadingView.isHidden=false
            self.reloadContacts.isHidden=false
            self.statusLabel.text=error?.getErrorMessage()
        }
    }
    
    func generatedIndexSearch(indexSearch: IndexSearch) {
        self.indexSearch=indexSearch
        indexSearchTV.reloadData()
    }
    
    func scrollContactListToSpecifiedSection(section: String) {
        guard let index=contactDisplayCollection?.sections.index(of: section) else {
            return
        }
        contactsTV.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableViewScrollPosition.top, animated: true)
    }
}

extension ListViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == contactsTV {
            guard let count=self.contactDisplayCollection?.sections.count else {
                return 0
            }
            return count
        }else if tableView == indexSearchTV{
            guard (indexSearch?.sections.count) != nil else {
                return 0
            }
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == contactsTV {
            let key=self.contactDisplayCollection?.sections[section]
            guard let contactsList=self.contactDisplayCollection?.contactsSections[key!] else{
                return 0
            }
            return contactsList.count;
        }else if tableView == indexSearchTV {
            guard let count=indexSearch?.sections.count else {
                return 0
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == contactsTV {
            let key=self.contactDisplayCollection?.sections[indexPath.section]
            let contactsList=self.contactDisplayCollection?.contactsSections[key!]
            let cell=tableView.dequeueReusableCell(withIdentifier: ContactCellIdetenifier, for: indexPath) as! ContactCell
            guard let contact=contactsList?[indexPath.row] else {
                return cell
            }
            cell.configureContact(contact: contact)
            return cell
        }else if tableView == indexSearchTV {
            let key=self.indexSearch?.sections[indexPath.row]
            let cell=tableView.dequeueReusableCell(withIdentifier: IndexCellIdetenifier, for: indexPath) as! IndexSearchCell
            guard let index=key else {
                return cell
            }
            cell.configureIndexSeacrchCell(indexName: index)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == contactsTV {
            let key=self.contactDisplayCollection?.sections[section]
            return key
        }else if tableView == indexSearchTV {
            return nil
        }
        return nil
    }
}

extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == contactsTV {
            let key=self.contactDisplayCollection?.sections[indexPath.section]
            let contactsList=self.contactDisplayCollection?.contactsSections[key!]
            eventHandler?.getContactDetail(contact: contactsList![indexPath.row])
        }else if tableView == indexSearchTV {
            let key=indexSearch?.sections[indexPath.row]
            eventHandler?.clickedOnIndexSearch(key: key!)
        }
    }
}

extension ListViewController{
    override func viewWillLayoutSubviews() {
        let indexTVHeight=indexSearchTV.contentSize.height
        let remainingSpace=view.frame.height - indexTVHeight - 64
        if remainingSpace > 0 && indexTVHeight > 0 {
            indexSearchTVTopConstraint.constant=remainingSpace/2
            indexSearchTVBottomConstraint.constant=remainingSpace/2
            view.layoutIfNeeded()
        }
    }
}

extension ListViewController{
    func addContactObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(ListViewController.getContactList), name: AddUpdateDeleteNotificationName, object: nil)
    }
}
