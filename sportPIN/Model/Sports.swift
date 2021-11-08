//
//  Sports.swift
//  sportPIN
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import Foundation

struct Sports : Hashable {
    var name: String = ""
    var type: String = ""
    var photo: String = ""
    var image: String = ""
    var isFavorite: Bool = false
}

extension Sports {
    static func generateData( sourceArray: inout [Sports]) {
        sourceArray = [
            Sports(name: "baseball", type: "ball", photo: "baseball_photo", image: "baseball"),
            Sports(name: "basketball", type: "ball", photo: "basketball_photo", image: "basketball"),
            Sports(name: "football", type: "ball", photo: "football_photo", image: "football"),
            Sports(name: "other", type: "other", photo: "other_photo", image: "other")
        ]
    }
}
