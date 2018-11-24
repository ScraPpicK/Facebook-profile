//
//  UserFriendsList.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import FBSDKLoginKit

fileprivate let facebookGraphFriendsPath = "/me/friends"

protocol UserFriendsListProtocol: class {
    func friendsListHasChanged(_: [Person])
    func friendsListFailedUpdate(_: Error)
}

class UserFriendsList {
    private var friendsList = [Person]()
    weak var delegate: UserFriendsListProtocol?
    
    func getFriendsList() {
        if self.friendsList.count != 0 {
            self.delegate?.friendsListHasChanged(self.friendsList)
        } else {
            self.updateFriendsList()
        }
    }
    
    private func updateFriendsList() {
        let request = FBSDKGraphRequest.init(graphPath: facebookGraphFriendsPath, parameters: ["fields": "name,picture"], httpMethod: "GET")
        request?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                runOnMainAvoidDeadlock {
                    self.delegate?.friendsListFailedUpdate(error!)
                }
                return
            }
        
            self.friendsList = [Person]()
            if let result = result as? [String:Any], let friendsArray = result["data"] as? [[String:Any]] {
                self.friendsList = friendsArray.compactMap {
                    Person($0)
                }
                
                runOnMainAvoidDeadlock {
                    self.delegate?.friendsListHasChanged(self.friendsList)
                }
            }
        })
    }
}
