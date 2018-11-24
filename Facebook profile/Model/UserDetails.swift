//
//  UserDetails.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/13/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol UserDetailsProtocol: class {
    func userDetailsHasChanged(userInfo: Person)
}

class UserDetailsHandler {
    private var userInfo = Person()
    weak var delegate: UserDetailsProtocol?
    
    func getUserDetails() {
        if self.userInfo.name != "" || self.userInfo.surname != "" {
            self.delegate?.userDetailsHasChanged(userInfo: self.userInfo)
        } else {
            self.updateUserDetails(id: "me");
        }
    }
    
    func getUserDetails(id: String) {
        self.updateUserDetails(id: id)
    }
    
    func updateUserDetails(id: String) {
        
    }
}
