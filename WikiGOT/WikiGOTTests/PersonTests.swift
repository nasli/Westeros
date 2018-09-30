//
//  PersonTests.swift
//  WikiGOTTests
//
//  Created by Noelia Alvarez on 28/09/2018.
//  Copyright © 2018 Noelia Alvarez. All rights reserved.
//

import XCTest
@testable import WikiGOT

class PersonTests: XCTestCase {

    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    var arya: Person!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterExistence() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
    }


    func testCreatePersonIncrementMembersInHouse() {

        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "Leon rampante")
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterURL )

        XCTAssertEqual(lannisterHouse.count, 0)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        XCTAssertEqual(cersei.house.count, 1)

        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        XCTAssertEqual(jaime.house.count, 2)

    }



}
