//
//  AppDependencies.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies{
    
    var listWireframe=ListWireframe()
    
    init() {
        configureDepencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        listWireframe.presentContactListFromWindow(window)
    }
    
    func configureDepencies(){
        let rootViewframe=RootWireframe()
        let listPresenter=ListPresenter()
        let listInteractor=ListInteractor()
        let listDataManager=ListDataManager()
        
        listWireframe.listPresenter=listPresenter
        listWireframe.rootWireframe=rootViewframe
        listPresenter.listInteractor=listInteractor
        listPresenter.listWireframe=listWireframe
        listInteractor.output=listPresenter
        listInteractor.listDataManager=listDataManager;
    }
}
