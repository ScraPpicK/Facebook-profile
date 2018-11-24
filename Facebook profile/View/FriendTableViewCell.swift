//
//  FriendTableViewCell.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func nibName() -> String {
        return self.description()
    }
    
    static func reuseIdentifier() -> String {
        return self.description()
    }
}

class FriendTableViewCell: UITableViewCell {
    
}
