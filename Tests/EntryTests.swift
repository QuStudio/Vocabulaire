//
//  EntryTests.swift
//  Vocabulaire
//
//  Created by Oleg Dreyman on 22.03.16.
//  Copyright © 2016 Oleg Dreyman. All rights reserved.
//

import XCTest
@testable import Vocabulaire

class EntryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func entry(forName name: Morpheme, permissibility: ForeignLexeme.Permissibility) -> Entry {
        let foreign = ForeignLexeme(lemma: name, forms: [], origin: name, meaning: "", permissibility: permissibility)
        return Entry(id: 1, foreign: foreign, natives: [])
    }

    func testSort() {
        let foreign = ForeignLexeme(lemma: GeneralMorpheme("Manager"),
                                    forms: [],
                                    origin: GeneralMorpheme("manager"),
                                    meaning: "A head of something",
                                    permissibility: .NotAllowed)
        let native1 = NativeLexeme(lemma: GeneralMorpheme("Управляющий"),
                                   meaning: "",
                                   usage: .General)
        let native2 = NativeLexeme(lemma: GeneralMorpheme("Главный"),
                                   meaning: "",
                                   usage: .Promising)
        let native3 = NativeLexeme(lemma: GeneralMorpheme("Заведующий"),
                                   meaning: "",
                                   usage: .Rare)
        let natives: Set = [native1, native2, native3]
        let entry = Entry(id: 1, foreign: foreign, natives: natives)
        let sortedNatives = entry.nativesByUsage
        XCTAssertEqual(sortedNatives, [native1, native2, native3])
    }
    
    func testWrongSort() {
        let foreign = ForeignLexeme(lemma: GeneralMorpheme("Manager"),
                                    forms: [],
                                    origin: GeneralMorpheme("manager"),
                                    meaning: "A head of something",
                                    permissibility: .NotAllowed)
        let native1 = NativeLexeme(lemma: GeneralMorpheme("Управляющий"),
                                   meaning: "",
                                   usage: .General)
        let native2 = NativeLexeme(lemma: GeneralMorpheme("Главный"),
                                   meaning: "",
                                   usage: .Promising)
        let native3 = NativeLexeme(lemma: GeneralMorpheme("Заведующий"),
                                   meaning: "",
                                   usage: .Rare)
        let natives: Set = [native1, native2, native3]
        let entry = Entry(id: 2, foreign: foreign, natives: natives)
        let sortedNatives = entry.nativesByUsage
        XCTAssertNotEqual(sortedNatives, [native3, native2, native1])
        XCTAssertNotEqual(sortedNatives, [native2, native1, native3])
    }
    
    func testAlphabeticalVocabulary() {
        let entry1 = entry(forName: GeneralMorpheme("менеджер"), permissibility: .NotAllowed)
        let entry2 = entry(forName: GeneralMorpheme("нонпрофит"), permissibility: .NotAllowed)
        let entry3 = entry(forName: GeneralMorpheme("баг"), permissibility: .Allowed)
        let entry4 = entry(forName: CaseSensitiveMorpheme("США"), permissibility: .NotAllowed)
        let vocabulary: Vocabulary = [entry1, entry2, entry3, entry4]
        let sorted = vocabulary.alphabetical
        XCTAssertEqual(sorted, [entry3, entry1, entry2, entry4] as Vocabulary)
    }

}
