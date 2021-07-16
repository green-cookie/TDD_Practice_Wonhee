//
//  RandomNumberGenerator.swift
//  TDDPractice
//
//  Created by USER on 2021/07/16.
//

import Foundation

struct RandomNumberGenerator {
    private static let randomNumberRange = 1...100
    
    static func generateRandomNumber() -> Int {
        return Int.random(in: randomNumberRange)
    }
}
