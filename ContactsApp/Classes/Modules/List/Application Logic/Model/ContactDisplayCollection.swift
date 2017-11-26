//
//  ContactDisplayCollection.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

struct ContactDisplayCollection {
    var sections = [String]()
    var contactsSections = [String:[ContactEntity]]()
}

extension ContactDisplayCollection {
    mutating func prepareContactsSections(contacts:[ContactEntity]){
        sections.removeAll()
        contactsSections.removeAll()
        for contact in contacts{
            do {
                let regex = try NSRegularExpression(pattern: "[a-zA-Z]")
                let key=String(contact.firstName.characters.first!)
                let result = regex.matches(in: contact.firstName, range: NSRange(location: 0, length: 1))
                if result.count == 1 {
                    if contactsSections[key.uppercased()] == nil {
                        contactsSections[key.uppercased()]=[ContactEntity]()
                        sections.append(key.uppercased())
                    }
                    contactsSections[key.uppercased()]?.append(contact)
                }else{
                    if contactsSections["#"]==nil {
                        contactsSections["#"]=[ContactEntity]()
                        sections.append("#")
                    }
                    contactsSections["#"]?.append(contact)
                }
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
            }
        }
        sections.sort()
        if let first=sections.first,first=="#" {
            sections.remove(at: 0)
            sections.append("#")
        }
    }
}

