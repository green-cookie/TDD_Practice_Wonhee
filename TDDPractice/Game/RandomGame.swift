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
        case judge
        case wrongPlayerCount
    }
    
    // MARK: - properties
    
    let playMode: PlayMode
    private var targetNumber: Int
    
    init(playMode: PlayMode) {
        self.playMode = playMode
        self.targetNumber = RandomNumberGenerator.generateRandomNumber()
    }
    
    
    // MARK: - Method
    
    func setTargetNumber(_ targetNumber: Int) {
        self.targetNumber = targetNumber
    }
    
    func judgeGameResult(_ number: Int) throws -> GameResult {
        let numberGap = number - targetNumber
        if numberGap == GameResult.equal.rawValue {
            return .equal
        } else if numberGap >= GameResult.high.rawValue {
            return .high
        } else if numberGap <= GameResult.low.rawValue{
            return .low
        }
        
        throw RandomGameError.judge
    }
    
    func play(_ number: Int) throws -> GameResult {
        do {
            return try judgeGameResult(number)
        } catch {
            throw error
        }
    }
    
    func play(_ numbers: [Int]) throws -> [GameResult] {
        guard numbers.count == playMode.playerCount else {
            throw RandomGameError.wrongPlayerCount
        }
        
        do {
            let results = try numbers.map { number -> GameResult in
                return try judgeGameResult(number)
            }
    
            return results
        } catch {
            throw error
        }
    }
}
