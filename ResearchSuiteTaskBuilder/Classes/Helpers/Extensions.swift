//
//  Extensions.swift
//  Pods
//
//  Created by James Kizer on 1/9/17.
//
//

import Foundation

extension Array {
    
    func random() -> Element? {
        if self.count == 0 {
            return nil
        }
        else{
            let count: Int = self.count
            let index: Int = numericCast(arc4random_uniform(numericCast(count)))
            return self[index]
        }
    }
}


extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
    
    func shuffled(shouldShuffle: Bool = true) -> [Iterator.Element] {
        if shouldShuffle {
            var result = Array(self)
            result.shuffle()
            return result
        }
        else {
            return Array(self)
        }
        
    }
}
