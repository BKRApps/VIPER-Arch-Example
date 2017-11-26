//
//  ImageRepository.swift
//  GoJekContactsApp
//
//  Created by Kumar Birapuram on 30/05/17.
//  Copyright © 2017 KRiOSApps. All rights reserved.
//

import Foundation
import UIKit

class ImageRepository: NSObject {
    static let sharedInstance=ImageRepository()
    // for now, i will use dictionary to cache the images, but it is ideal to use LRU Data strcutre to cache the images
    var imageCache=[String:Data]()
    
    private override init() {
        
    }
    
    func fetchImageFromServer(imageUrl:URL,completion:@escaping (UIImage?,URL,ContactAppError?)->()){
        DispatchQueue.global().async {
            do{
                if self.imageCache[imageUrl.absoluteString] == nil {
                    let data=try Data.init(contentsOf: imageUrl, options: Data.ReadingOptions.mappedIfSafe)
                    self.imageCache[imageUrl.absoluteString]=data
                }
                if let data=self.imageCache[imageUrl.absoluteString],let img=UIImage(data:data){
                    completion(img,imageUrl,nil)
                }else{
                    completion(nil,imageUrl,ContactAppError.ErrorWithInfo("unable to fetch image right now."))
                }
            }catch{
                completion(nil,imageUrl,ContactAppError.ErrorWithInfo(error.localizedDescription))
            }
        }
    }
    
}
