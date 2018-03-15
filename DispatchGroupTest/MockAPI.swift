//
//  MockAPI.swift
//  DispatchGroupTest
//
//  Created by Trent Guillory on 3/15/18.
//  Copyright © 2018 Trent Guillory. All rights reserved.
//

import Foundation

struct MockAPI {
    func getDollars() -> Int {
        return Int(arc4random_uniform(100))
    }
    
    func getCents() -> Int {
        return Int(arc4random_uniform(100))
    }
}
