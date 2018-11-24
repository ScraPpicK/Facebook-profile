//
//  FriendsListViewController.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import Foundation
import FBSDKLoginKit

fileprivate let controllerTitle = "Friends who use app"

class FriendsListViewController: UITableViewController, UserFriendsListProtocol {
    private var friendList = [Person]()
    private var userFriendList = UserFriendsList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = controllerTitle
        self.tableView.tableFooterView = UIView()
        self.userFriendList.getFriendsList()
        self.userFriendList.delegate = self
        self.tableView.register(NSClassFromString(FriendTableViewCell.nibName()), forCellReuseIdentifier: FriendTableViewCell.reuseIdentifier())
    }
    
    func friendsListHasChanged(_ friendList: [Person]) {
        self.friendList = friendList
        self.tableView.reloadData()
    }
    
    func friendsListFailedUpdate(_: Error) {
        // show alert here
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reuseIdentifier())!
        
        let friend = friendList[indexPath.item]
        if let imageView = cell.imageView {
            imageView.image = friend.profileImage
        }
        
        let fullName = String(format: "%@ %@", friend.name, friend.surname)
        if let label = cell.textLabel {
            label.text = fullName
        }
        
        return cell
    }
}
