//
//  runOnMainAvoidDeadlock.swift
//  Facebook profile
//
//  Created by Vadym Patalakh on 11/22/18.
//  Copyright © 2018 Vadym Patalakh. All rights reserved.
//

import Foundation

func runOnMainAvoidDeadlock(completion : @escaping ()->()) {
    if Thread.isMainThread {
        completion()
    } else {
        DispatchQueue.main.async {
            completion()
        }
    }
}
