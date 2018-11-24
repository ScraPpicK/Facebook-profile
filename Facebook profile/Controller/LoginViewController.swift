//
//  ViewController.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

fileprivate let segueToDetailScreenName = "showSegueToProfileDetailsViewController"
fileprivate let controllerTitle = "Login"
fileprivate struct FacebookPermissionsKeys {
    static let profileKey = "public_profile"
    static let emailKey = "email"
    static let userFriendsKey = "user_friends"
}

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet fileprivate weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = controllerTitle
        
        self.facebookLoginButton.delegate = self
        self.facebookLoginButton.readPermissions = [FacebookPermissionsKeys.profileKey, FacebookPermissionsKeys.emailKey, FacebookPermissionsKeys.userFriendsKey]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if FBSDKAccessToken.current() == nil {
            self.setContinueButtonIsHidden(true)
        }
    }
    
    private func setContinueButtonIsHidden(_ isHidden: Bool) {
        self.continueButton.isUserInteractionEnabled = !isHidden
        UIView.animate(withDuration: 0.3) {
            self.continueButton.alpha = isHidden ? 0 : 1
        }
    }
    
    //MARK: Facebook login
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            self.setContinueButtonIsHidden(false)
            self.performSegue(withIdentifier: segueToDetailScreenName, sender: self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.setContinueButtonIsHidden(true)
    }
}

