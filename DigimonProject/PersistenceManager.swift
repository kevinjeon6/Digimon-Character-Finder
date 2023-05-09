//
//  PersistanceManager.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 5/3/23.
//

import Foundation


enum PersistenceActionType {
    case add
    case remove
}


enum Keys {
    static let favorites = "favorites"
}

//Using an enum. Cannot initialize an empty enum. Small safety to prevent errors since you can initialize an empty struct
enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    // MARK: - Retreive Favorites
    //Retreive the user defaults.
    //Result in completion handler = A value that represents either a success or a failure, including an associated value in each case.
    //If successful then we'll get the array of Favorite Digimon. If fail then an error
    //The as Data is casting as Data because it doesn't the object
    static func retrieveFavorites() -> Result<[Digimon], FavoriteError> {
        //When saving to defaults. Need to give it a key name
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            //First time use when there are no favorites added. We don't want an error to display. Just an empty array
            return .success([])
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Digimon].self, from: favoritesData)
            return .success(favorites)
            
        } catch {
            return .failure(.unableToFavorite)
        }
    }
    
    // MARK: - Save Favorites
    
    //Returning an optional error. Returning nil if it's successful
    static func saveFavorites(favorites: [Digimon]) -> FavoriteError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            
            //Saving to user defaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil //Returning nil because there is no Error
            
        }catch {
            return .unableToFavorite
        }
    }
    
    static func updateWith(favorite: Digimon, actionType: PersistenceActionType) -> FavoriteError? {
        let retrieved = retrieveFavorites()
        
        switch retrieved {
            //Success on adding a favorite
        case .success(var favorites):
            switch actionType {
            case .add:
                //Don't add a favorite if it already exsists
                //!favorites means that the retreivedFavorites does not contain
                guard !favorites.contains(favorite) else {
                    return .alreadyInFavorites
                }
                
                favorites.append(favorite)
            case .remove:
                favorites.removeAll { $0.name == favorite.name && $0.img == favorite.img && $0.level == favorite.level} //Shorthand syntax $0 is each item as it iterates through
            }
            return saveFavorites(favorites: favorites)
            
        case .failure(let error):
            return error
        }
    }
}



        

   

