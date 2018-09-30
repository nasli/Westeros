//
//  HouseTests.swift
//  WikiGOTTests
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import XCTest
@testable import WikiGOT

class HouseTests: XCTestCase {

    var starkSigil: Sigil!
    var lannisterSigil: Sigil!

    var starkURL: URL!
    var lannisterURL: URL!

    var starkHouse: House!
    var lannisterHouse: House!

    var robb: Person!
    var arya: Person!
    var tyrion: Person!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")

        starkURL = URL (string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        lannisterURL =  URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!

        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkURL )
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterURL )

        robb = Person(name: "Robb", alias: "El joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
    }

    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }

    func testHouse_AddPersons_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)

        XCTAssertEqual(starkHouse.count, 1)

        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)

        XCTAssertEqual(lannisterHouse.count, 0)
        lannisterHouse.add(person: tyrion)
        XCTAssertEqual(lannisterHouse.count, 1)

        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)

    }

    func testHouse_AddPersonsAtOnce_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(persons: robb, arya, tyrion)

        XCTAssertEqual(starkHouse.count, 2)
    }

    func testHouseEquality() {
        // 1. Identity
        XCTAssertEqual(starkHouse, starkHouse)

        //2. Equality
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkURL)
        XCTAssertEqual(jinxed, starkHouse)

        //3. Inequity
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }

    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }

    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }

}
