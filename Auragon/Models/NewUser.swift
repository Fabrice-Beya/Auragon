//
//  NewUser.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import Foundation

struct NewUser: Codable {
    var credentials: Credentials = Credentials()
    var username: String = ""
}
