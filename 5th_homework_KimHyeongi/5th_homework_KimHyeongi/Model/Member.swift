//
//  User.swift
//  5th_homework_KimHyeongi
//
//  Created by 김현기 on 5/10/24.
//

import Foundation

struct Member: Decodable, Encodable {
    var id: Int?
    var name: String
    var part: String
    var age: Int

    init(id: Int? = nil, name: String, part: String, age: Int) {
        self.id = id
        self.name = name
        self.part = part
        self.age = age
    }
}
