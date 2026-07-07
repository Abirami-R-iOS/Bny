//
//  FavouritesEntity.swift
//  Bny
//
//  Created by Abirami on 04/07/26.
//

import Foundation
enum FavouriteTab {
    case categories
    case brands
}


struct FavouriteCategory {
    let image: String
    let title: String
    let count: Int
}

struct FavouriteBrand {
    let image: String
    let title: String
    let subtitle: String
    let distance: String
}
