//
//  DetailWireframe.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
import UIKit

let DetailViewControllerIdentifier="detailVC"

class DetailWireframe: NSObject {
    weak var detailPresenter:DetailPresenter?
    weak var detailVC:DetailViewController!
    
    func showContactDetailViewController(navController:UINavigationController,with contact:ContactEntity){
        detailVC=contactDetailVCFromStoryboard()
        detailVC.contact=contact
        detailPresenter?.userInterface=detailVC
        detailVC.eventHandler=detailPresenter
        let navigationItem=detailVC?.navigationItem
        let rightbarButtonItem=UIBarButtonItem(title: "Edit", style: .plain, target: detailVC!, action: #selector (DetailViewController.clickedOnEdit(sender:)))
        navigationItem?.rightBarButtonItem=rightbarButtonItem
        navController.pushViewController(detailVC, animated: true)
    }
    
    func contactDetailVCFromStoryboard()->DetailViewController{
        let storyboard=UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: DetailViewControllerIdentifier) as! DetailViewController
    }
    
    func presentAddEditInterface(contact:ContactEntity){
        let wireframe=AddEditWireframe()
        let presenter=AddEditPresenter()
        let interactor=AddEditInteractor()
        
        presenter.interactor=interactor
        interactor.output=presenter
        wireframe.presenter=presenter
        
        wireframe.presentAddEditViewController(viewController: detailVC!,contact: contact,type:AddEditVCType.edit)
        
        /*guard let navC=detailVC.navigationController else {
            return
        }
        wireframe.showAddEditViewController(navController: navC, with: contact,type: AddEditVCType.edit)*/
    }
}
