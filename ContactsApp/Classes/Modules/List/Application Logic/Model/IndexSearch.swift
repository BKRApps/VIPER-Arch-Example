//
//  IndexSearch.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 28/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation

struct IndexSearch {
    var sections=[String]()
}

extension IndexSearch{
    mutating func prepareIndexSearchData(){
        var startIndex=65
        while startIndex<=90 {
            let letter=String(describing: UnicodeScalar(UInt8(startIndex)))
            sections.append(letter)
            startIndex=startIndex+1
        }
        sections.append("#")
    }
}
