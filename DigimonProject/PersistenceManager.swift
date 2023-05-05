//
//  PersistanceManager.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 5/3/23.
//

import Foundation




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
    static func retrieveFavorites(completed: @escaping (Result<[Digimon], Error>) -> Void) {
        //When saving to defaults. Need to give it a key name
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else { return
            //First time use when there are no favorites added. We don't want an error to display. Just an empty array
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Digimon].self, from: favoritesData)
            completed(.success(favorites))
        
        } catch {
            fatalError("Unable to favorite")
        }
    }
    
    // MARK: - Save Favorites
    
    //Returning an optional error. Returning nil if it's successful
    static func saveFavorites(favorites: [Digimon]) -> Error? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            
            //Saving to user defaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil //Returning nil because there is no Error
            
        }catch {
            fatalError("Unable to favorite")
        }
    }
    
    
}
