//
//  Person.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

struct Person {
    var name: String = ""
    var surname: String = ""
    var profileImage: UIImage?
    var profileImageUrlString: String?
    
    init() {
        self.name = ""
        self.surname = ""
    }
    
    init(_ dictionary: [String:Any]) {
        self.name = dictionary["first_name"] as? String ?? ""
        self.surname = dictionary["last_name"] as? String ?? ""
        
        guard let pictureData = dictionary["picture"] as? Dictionary<String, Any>,
            let data = pictureData["data"] as? Dictionary<String, Any>,
            let urlString = data["url"] as? String
            else {
            return
        }
        
        self.profileImageUrlString = urlString
    }
}
