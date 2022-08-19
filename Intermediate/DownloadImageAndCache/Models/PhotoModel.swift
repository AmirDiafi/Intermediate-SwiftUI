//
//  PhotoModel.swift
//  Intermediate
//
//  Created by AmirDiafi on 8/14/22.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
