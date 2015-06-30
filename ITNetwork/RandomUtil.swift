//
//  RandomUtil.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

import Foundation

public class RandomUtil {
    
    static func randIntRange(from: Int, to: Int) -> Int {
        let randInt:UInt32 = arc4random()
        let randFloat:Float32 = Float32(randInt) / Float32(UINT32_MAX)
        let dist:Int = to - from
        let rand:Int = Int(floor(randFloat * Float32(dist)))
        return rand + from
    }
    
}
