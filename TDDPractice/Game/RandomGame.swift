//
//  RandomGame.swift
//  TDDPractice
//
//  Created by USER on 2021/07/16.
//

import Foundation

class RandomGame {
    
    // MARK: - PlayMode enum
    
    enum PlayMode {
        case single
        case multiple(names: [String])
        
        var playerCount: Int {
            switch self {
            case .single:
                return 1
            case .multiple(let names):
                return names.count
            }
        }
    }
    
    enum GameResult: Int {
        case high = 1
        case equal = 0
        case low = -1
    }
    
    enum RandomGameError: Error {
        case wrongPlayerCount
    }
    
    // MARK: - properties
    
    let playMode: PlayMode
    private var targetNumber: Int
    
    init(playMode: PlayMode, targetNumber: Int) {
        self.playMode = playMode
        self.targetNumber = targetNumber
    }
    
    
    // MARK: - Method
    
    private func judgeGameResult(_ number: Int) -> GameResult {
        let numberGap = number - targetNumber
        switch numberGap.signum() {
        case 1:
            return .high
        case -1:
            return .low
        default:
            return .equal
        }
    }
    
    func play(_ number: Int) -> GameResult {
        return judgeGameResult(number)
    }
    
    func play(_ numbers: [Int]) throws -> [GameResult] {
        guard numbers.count == playMode.playerCount else {
            throw RandomGameError.wrongPlayerCount
        }
        return numbers.map { number -> GameResult in
            return judgeGameResult(number)
        }
    }
}
