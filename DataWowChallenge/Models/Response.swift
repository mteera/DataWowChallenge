//
//  Response.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let status: String
    let data: T
}
