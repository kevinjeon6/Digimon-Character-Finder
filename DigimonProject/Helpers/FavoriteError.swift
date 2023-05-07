//
//  FavoriteError.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 5/6/23.
//

import Foundation

enum FavoriteError: String, Error {
    case alreadyInFavorites = "You've already favorited this Digimon character"
    case unableToFavorite = "Unable to favorite"
}
