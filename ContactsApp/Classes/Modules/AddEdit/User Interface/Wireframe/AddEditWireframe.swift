//
//  AddEditWireframe.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 29/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
import UIKit

let AddEditViewControllerIdentifier="addEditVC"

class AddEditWireframe: NSObject {
    var presenter:AddEditPresenter?
    var addEditVC:AddEditViewController?
    var addEditNavController:UINavigationController?
    
    func showAddEditViewController(navController:UINavigationController,with contact:ContactEntity?,type:AddEditVCType){
        addEditVC=addEditVCFromStoryboard()
        addEditVC?.contact=contact
        addEditVC?.addEditType=type
        presenter?.userInterface=addEditVC
        addEditVC?.eventHandler=presenter
        navController.pushViewController(addEditVC!, animated: true)
    }
    
    func presentAddEditViewController(viewController:UIViewController,contact:ContactEntity?,type:AddEditVCType) {
        addEditVC=addEditVCFromStoryboard()
        addEditVC?.addEditType = type
        addEditVC?.contact=contact
        addEditVC?.eventHandler=presenter
        presenter?.userInterface=addEditVC
        addEditNavController=UINavigationController(rootViewController: addEditVC!)
        let navigationItem=addEditVC?.navigationItem
        let leftBarButtonItem=UIBarButtonItem(barButtonSystemItem: .cancel, target: addEditVC!, action: #selector(AddEditViewController.clickedOnCancel(sender:)))
        let rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .done, target: addEditVC!, action: #selector(AddEditViewController.clickedOnDone(sender:)))
        navigationItem?.leftBarButtonItem=leftBarButtonItem
        navigationItem?.rightBarButtonItem=rightBarButtonItem
        viewController.present(addEditNavController!, animated: true, completion: nil)
    }
    
    func addEditVCFromStoryboard()->AddEditViewController{
        let storyboard=UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: AddEditViewControllerIdentifier) as! AddEditViewController
    }

}
