//
//  UserInfo.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/13/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import Foundation
import FBSDKLoginKit

protocol UserInfoHasChanged: class {
    
    func profileInfoHasChanged(name: String, surname: String, profileImage: UIImage?)
    func friendsListHasChanged(friendsList: Array<Any>)
}

extension UserInfoHasChanged {

    func profileInfoHasChanged(name: String, surname: String, profileImage: UIImage?) {

    }
    
    func friendsListHasChanged(friendsList: Array<Any>) {

    }
}

class UserInfo: NSObject {
    
    static let shared = UserInfo()
    
    fileprivate var name: String = ""
    fileprivate var surname: String = ""
    fileprivate var profileImage: UIImage?
    fileprivate var profileUrl: URL?
    fileprivate var friendsList: Array<Any>?
    
    weak var delegate: UserInfoHasChanged?
    
    fileprivate override init() {
        
    }
    
    func getInfoAboutUser() {
        let request = FBSDKGraphRequest.init(graphPath: "/me?fields=first_name,last_name,email,picture,friendlists", parameters: nil, httpMethod: "GET")
        request?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                // show alert here
                return
            }
            
            guard
                let profileDictionary = result as? Dictionary<String, Any>
                else {
                    return
            }
            
            if let name = profileDictionary["first_name"] as? String {
                self.name = name
            }
            
            if let surname = profileDictionary["last_name"] as? String {
                self.surname = surname
            }
            
            guard
                let pictureData = profileDictionary["picture"] as? Dictionary<String, Any>,
                let data = pictureData["data"] as? Dictionary<String, Any>,
                let urlString = data["url"] as? String,
                let url = URL.init(string: urlString)
                else {
                    self.delegate?.profileInfoHasChanged(name: self.name, surname: self.surname, profileImage: nil)
                    return
            }
            
            url.asyncDownload(completion: { (data, responce, error) in
                guard
                    let data = data,
                    let profileImage = UIImage.init(data: data)
                    else {
                        self.delegate?.profileInfoHasChanged(name: self.name, surname: self.surname, profileImage: nil)
                        return
                }
                self.profileImage = profileImage
                self.delegate?.profileInfoHasChanged(name: self.name, surname: self.surname, profileImage: profileImage)
            })
        })
    }
}
