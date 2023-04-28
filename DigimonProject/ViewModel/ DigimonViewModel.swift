//
//   DigimonViewModel.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/15/23.
//

import Foundation
import UIKit

//To create a delegate you need to create a protocol
protocol DigimonViewModelProtocol {
    func didFinish()
    func didFail(error: Error)
}


//Using Swift Concurrency in UIKit

class DigimonViewModel {
    
    // MARK: - Properties
    var characters =  [Digimon]()
    
    var filteredDigimon = [Digimon]()
    
    //Declare delegate property in view model
    var delegate: DigimonViewModelProtocol?
    
    @MainActor //MainActor Any UI updates gets placed on the main thread. But any processing such as fetching data is still on the background thread.
    func getDigimonData() {
        
        
        //Need to use Task since there isn't a modifier in UIKit
        Task { [weak self] in
            
            
            guard let url = URL(string: "https://digimon-api.vercel.app/api/digimon") else { fatalError("Bad URL")}
            
            let urlRequest = URLRequest(url: url)
            
            //Do-Catch block
            //Do: Is where code that might throw an error
            //Catch: Execution from the DO block if an error is thrown
            do {
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                guard(response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
                
                
                let decoder = JSONDecoder()
                self?.characters = try decoder.decode([Digimon].self, from: data)
                self?.delegate?.didFinish()
            } catch {
                self?.delegate?.didFail(error: error)
            }
        }
        
        self.delegate?.didFinish()
    }
    
}



// MARK: - Extension for Search functions
extension DigimonViewModel {
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        //isEmpty returns true if there is nothing. The ! reverses the condition
        return isActive && !searchText.isEmpty
        
    }
    
    
    //The parameter is search bar text and will be passed into the scope of the function
    public func updateSearchController(searchBarText: String?) {
        self.filteredDigimon = characters
        
        //Filtering the Filtered Digimon characters
        
        if let searchBarText = searchBarText?.lowercased() {
            guard !searchBarText.isEmpty else { return }
            
            
            self.filteredDigimon = self.filteredDigimon.filter({$0.name.localizedCaseInsensitiveContains(searchBarText)})
        }
        
        
        
    }
    
}
