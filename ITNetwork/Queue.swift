//
//  Queue.swift
//  ITNetwork
//
//  Created by Peter Arato on 29/06/2015.
//  Copyright © 2015 Peter Arato. All rights reserved.
//

class Queue<T> {
    
    var queue:[T] = [T]()
    var first:Int = -1
    
    func add(elem: T) {
        self.queue.append(elem)
    }
    
    func get() -> T? {
        if self.isEmpty() {
            return nil
        }
        
        self.first++
        return self.queue[self.first]
    }
    
    func isEmpty() -> Bool {
        return self.first + 1 >= self.queue.count
    }
    
}
