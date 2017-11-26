//
//  ContactCell.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactImage.createCircularImageView(width: 1.0, radius: contactImage.frame.size.width/2, color: UIColor.lightGray.cgColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureContact(contact:ContactEntity){
        firstName.text=contact.firstName;
        lastName.text=contact.lastName;
        if contact.favorite {
            favoriteImage.isHidden=false
        }else{
            favoriteImage.isHidden=true
        }
        if let imageUrl=URL(string:"http://gojek-contacts-app.herokuapp.com"+contact.profilePic){
            ImageRepository.sharedInstance.fetchImageFromServer(imageUrl: imageUrl){[weak self] (image,url,error)->() in
                DispatchQueue.main.async {
                    if imageUrl.absoluteString == url.absoluteString, let img=image{
                        self?.contactImage.image=img
                    }else{
                        self?.contactImage.image=nil
                    }
                }
            }
        }
    }
}
