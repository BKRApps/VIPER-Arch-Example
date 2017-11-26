//
//  ListWireframe.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
import UIKit

let ListViewControllerIdentifier="listVC"

class ListWireframe: NSObject {
    var listPresenter:ListPresenter?
    var rootWireframe:RootWireframe?
    var listViewController:ListViewController!
    
    func presentContactListFromWindow(_ window:UIWindow){
        listViewController=listViewControllerFromStoryboard()
        listViewController.eventHandler=listPresenter
        listPresenter?.userInterface=listViewController
        let navigationItem=listViewController.navigationItem
        navigationItem.title="Contact"
        let rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: listViewController!, action: #selector(ListViewController.clickedOnAdd(sender:)))
        navigationItem.rightBarButtonItem=rightBarButtonItem
        rootWireframe?.showRootViewController(listViewController, on: window)
    }
    
    func listViewControllerFromStoryboard()->ListViewController{
        let storyboard=UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: ListViewControllerIdentifier) as! ListViewController
    }
    
    func showContactDetailInterface(contact:ContactEntity){
        let wireframe=DetailWireframe()
        let presenter=DetailPresenter()
        let interactor=DetailInteractor()
        
        wireframe.detailPresenter=presenter
        presenter.detailWireframe=wireframe
        presenter.interactor=interactor
        interactor.output=presenter
        
        guard let navC=listViewController.navigationController else {
            return
        }
        wireframe.showContactDetailViewController(navController: navC, with: contact)
    }
    
    func presentAddConatctInterface(){
        let wireframe=AddEditWireframe()
        let presenter=AddEditPresenter()
        let interactor=AddEditInteractor()
        
        presenter.interactor=interactor
        interactor.output=presenter
        wireframe.presenter=presenter
        
        wireframe.presentAddEditViewController(viewController: listViewController!,contact:nil,type:AddEditVCType.add)
    }
}
