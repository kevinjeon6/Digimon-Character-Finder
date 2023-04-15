//
//  ViewController.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/15/23.
//

import UIKit

class ViewController: UIViewController {
    
    //Create DigimonViewModel object/instance and assign it to the variable viewModel
    var viewModel = DigimonViewModel()

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Need to explicitly tell the view to update when this fetching of data is finished. To do this we can use a delegate. Deletgates allows us to communicate between objects and delegate tasks. In this case from from our ViewModel to the view controller.
        //Setting the delegate property of the view model to the ViewController
        viewModel.delegate = self
        //Get the articles from the view model
        viewModel.getDigimonData()
    }
    
    
    



}


// MARK: - Extension for ViewController to conform to DigimonViewModelProtocol
extension ViewController: DigimonViewModelProtocol {
    // MARK: - Digimon View Model Protocol Methods
    func didFinish() {
        print("Digimon data is returned from view model")
    }
    
    func didFail(error: Error) {
        print(error)
    }
}

