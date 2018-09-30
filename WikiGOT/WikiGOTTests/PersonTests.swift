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
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
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

}
