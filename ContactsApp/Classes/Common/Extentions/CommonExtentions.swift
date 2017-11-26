
//
//  File.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 30/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
import UIKit

// just added comments to test git reset

extension UIImageView {
    func createCircularImageView(width:CGFloat,radius:CGFloat,color:CGColor){
        layer.borderWidth = width
        layer.masksToBounds = false
        layer.borderColor = color
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

extension UIView{
    func addGradientLayer(colors:[CGColor]?,startPoint:CGPoint,endPoint:CGPoint){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        if let clrs=colors{
            gradientLayer.colors = clrs
        }else{
            let firstColor=UIColor.init(red: 80/255.0, green: 227/255.0, blue: 194/255.0, alpha: 0.3).cgColor
            let secondColor=UIColor.white.cgColor
            gradientLayer.colors = [firstColor,secondColor]
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.addSublayer(gradientLayer)
    }
}

extension UIViewController{
    func showErrorDismissAlert(title:String,message:String?){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
