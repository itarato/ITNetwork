//
//  ArrayExtra.swift
//  ITNetwork
//
//  Created by Peter Arato on 01/07/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import Foundation

extension Array {
    
    // [1, 2, 3] -> [2, 3, 1]
    mutating func rotateLeft() {
        let first = self.first
        self.removeAtIndex(0)
        self = self + [first!]
    }
    
    // [1, 2, 3] -> [3, 1, 2]
    mutating func rotateRight() {
        let last = self.last
        self.removeAtIndex(self.count - 1)
        self = [last!] + self
    }
    
}
