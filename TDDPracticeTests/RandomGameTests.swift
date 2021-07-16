//
//  RandomGameTests.swift
//  TDDPracticeTests
//
//  Created by USER on 2021/07/16.
//

import XCTest
@testable import TDDPractice

/**
 1-1. 싱글
    1. 숫자 입력
    2. 랜덤값과 비교
    3. 결과 업데이트
 1-2. 멀티
    1. 이름 입력
    2. 숫자 입력
    3. 값 비교
    4. 결과 업데이트
 */
struct ForRandomGameTest {
    static let multiPlayerNames = ["wonhee", "jonghoon", "hyeona"]
    static let targetRandomNumber = RandomNumberGenerator.generateRandomNumber()
}

// TODO: value를 직접적으로 넣는 것인지 알아보고 해당 수정 방향으로 수정
// TODO: error에 대한 테스트 진행
class RandomGameTests: XCTestCase {
    
    private var sutSingleMode: RandomGame = RandomGame(playMode: .single, targetNumber: ForRandomGameTest.targetRandomNumber)
    private var sutMultiMode: RandomGame = RandomGame(playMode: .multiple(names: ForRandomGameTest.multiPlayerNames), targetNumber: ForRandomGameTest.targetRandomNumber)
    
    func testSinglePlayer_플레이어_숫자가_맞는_경우() {
        let singlePlayerCount = 1
        let result = sutSingleMode.playMode.playerCount
        XCTAssertEqual(singlePlayerCount, result, "single player mode: incorrect player count")
    }
    
    func testMultiPlayer_플레이어_숫자가_맞는_경우() {
        let multiPlayerCount = ForRandomGameTest.multiPlayerNames.count
        let result = sutMultiMode.playMode.playerCount
        XCTAssertEqual(multiPlayerCount, result, "multi player mode: incorrect player count")
    }
    
    func testPlay_singleMode_targetNumber를_맞춘_경우() {
        let inputNumber = ForRandomGameTest.targetRandomNumber
        let result = sutSingleMode.play(inputNumber)
        XCTAssertEqual(result, .equal, "single player mode: This result is equal")
    }
    
    func testPlay_singleMode_targetNumber보다_작은_수를_입력한_경우(){
        let inputNumber = ForRandomGameTest.targetRandomNumber - 1
        let result = sutSingleMode.play(inputNumber)
        XCTAssertEqual(result, .low, "single player mode: This result is low")
    }
    
    func testPlay_singleMode_targetNumber보다_큰_수를_입력한_경우() {
        let inputNumber = ForRandomGameTest.targetRandomNumber + 1
        let result = sutSingleMode.play(inputNumber)
        XCTAssertEqual(result, .high, "single player mode: This result is high")
    }
    
    func testPlay_multiMode_targetNumber를_맞춘_경우() {
        let inputNumbers = [ForRandomGameTest.targetRandomNumber, ForRandomGameTest.targetRandomNumber + 1, ForRandomGameTest.targetRandomNumber - 1]
        let result = try? sutMultiMode.play(inputNumbers)
        XCTAssertEqual(result, [.equal, .high, .low], "multi player mode: This result is incorrect")
    }
    
    func testPlay_multiMode_플레이어수와_inputNumber수가_안_맞는_경우() {
        let inputNumbers = [ForRandomGameTest.targetRandomNumber, ForRandomGameTest.targetRandomNumber + 1]
        let result = try? sutMultiMode.play(inputNumbers)
        XCTAssertNil(result, "multi player count, input number count is not same")
    }
}
