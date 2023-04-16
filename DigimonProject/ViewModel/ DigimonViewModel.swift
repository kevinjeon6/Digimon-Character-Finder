//
//   DigimonViewModel.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/15/23.
//

import Foundation

//To create a delegate you need to create a protocol
protocol DigimonViewModelProtocol {
    func didFinish()
    func didFail(error: Error)
}


//Using Swift Concurrency in UIKit
@MainActor //MainActor Any UI updates gets placed on the main thread. But any processing such as fetching data is still on the background thread.
class DigimonViewModel {
    
    // MARK: - Properties
    var characters: Digimon?
    
    //Declare delegate property in view model
    var delegate: DigimonViewModelProtocol?
    
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
                self?.characters = try decoder.decode(Digimon.self, from: data)
                self?.delegate?.didFinish()
            } catch {
                self?.delegate?.didFail(error: error)
            }
        }
        
        self.delegate?.didFinish()
    }
    
}
