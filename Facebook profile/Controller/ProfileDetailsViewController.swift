//
//  ProfileDetailsViewController.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import moa

fileprivate let apiCallString = "/%@?fields=first_name,last_name,email,picture"
fileprivate let controllerTitle = "Profile"

class ProfileDetailsViewController: UIViewController {

    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var surnameLabel: UILabel!
    
    private var userInfo: Person? {
        didSet {
            runOnMainAvoidDeadlock {
                self.updateUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = controllerTitle
        let request = FBSDKGraphRequest.init(graphPath: String(format: apiCallString, "me"), parameters: nil, httpMethod: "GET")
        request?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                // show alert here
                return
            }
            
            if let result = result as? Dictionary<String, Any> {
                let person = Person(result)
                self.userInfo = person
            }
        })
    }
    
    private func updateUI() {
        self.nameLabel.text = userInfo?.name
        self.surnameLabel.text = userInfo?.surname
        self.profileImageView.moa.url = userInfo?.profileImageUrlString
    }
}
