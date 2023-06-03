//
//  LevelType.swift
//  Practice
//
//  Created by Kevin Mattocks on 5/19/23.
//

import Foundation

//Using CaseIterable to access the values as an array via .allCases
enum LevelType: String, Identifiable, CaseIterable {
    case all
    case inTraining
    case rookie
    case champion
    case ultimate
    case mega
    case fresh
    case armor
    
    
    //Make it identifiable to use it in a ForEach for the picker. Need to make an id property then
    //Make a computed property using the raw values
    var id: String {
        self.rawValue
    }
    
    
    var levelName: String {
        switch self {
        case .all:
            return "All"
        case .inTraining:
            return "In Training"
        case .rookie:
            return "Rookie"
        case .champion:
            return "Champion"
        case .ultimate:
            return "Ultimate"
        case .mega:
            return "Mega"
        case .fresh:
            return "Fresh"
        case .armor:
            return "Armor"
        }
    }
}
