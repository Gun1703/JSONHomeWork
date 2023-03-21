//
//  Person.swift
//  JSONHomeWork
//
//  Created by 1234 on 21.03.2023.
//

import Foundation

struct Person: Decodable {
    let name: [Name]
    let gender: String
    let location: [Location]
    let email: String
    let picture: [Picture]
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Location: Decodable {
    let country: String
    let state: String
    let city: String
}

struct Picture: Decodable {
    let large: URL
}
