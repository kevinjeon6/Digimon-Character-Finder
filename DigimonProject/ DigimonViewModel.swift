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


class DigimonViewModel {
    
    //Declare delegate property in view model
    var delegate: DigimonViewModelProtocol?
    
    func getDigimonData() {
        
        self.delegate?.didFinish()
    }
    
}
