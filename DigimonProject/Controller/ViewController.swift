//
//  ViewController.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/15/23.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - Properties
    //Create table view.
    //tableView is in no man's land until we add it to a subview.
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(DigimonCell.self, forCellReuseIdentifier: DigimonCell.identifier)
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
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
        configureTableView()
        setTableViewDelegates()
        configNavBar()
        configSearchBar()


    }
    
    
    
    // MARK: - SetupUI
    
    
    func configureTableView() {
        //View is the main view of the view controller
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Setting up the constraints for the tableview in the View
        NSLayoutConstraint.activate([
            //
            tableView.topAnchor.constraint(equalTo: view.topAnchor), //A layout anchor representing the top edge of the view’s frame.
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor), //A layout anchor representing the bottom edge of the view’s frame.
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor), //A layout anchor representing the leading edge of the view’s frame.
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor) //A layout anchor representing the trailing edge of the view’s frame.
        
        ])
    }
    
    func setTableViewDelegates() {
        //Signing up this view controller to be the delegate and dataSouce of the table view
        //Self is the ViewController. Therefore, saying this that this ViewController is going to implement the delegate and datasource functions of tableview
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    func configNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mainOrange()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black //bar style gives us the white status bar/white text look
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = "Digimon"
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        

        
        //The array for rightBarButtonItems reads from outside to middle. Meaning the add is the closest to the edge of the phone
        navigationItem.rightBarButtonItems = [add, search]
      
       
    }
    
    
    func configSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        //This is what will be displayed in the search bar
        self.searchController.searchBar.placeholder = "Search Digimon"
        self.searchController.searchBar.searchTextField.backgroundColor = .white
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    
    
    // MARK: - Selectors
    
    @objc func showSearch() {
        //Do stuff for search bar
        print("searching for characters")
    }
    
    @objc func addTapped() {
        //Do stuff to add to favorites
        print("Add to favorites")
    }
    
}






// MARK: - Extension for TableView delegate and data source

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //How many rows do I want to show
        return viewModel.characters.count
        
    }
    
    
    //for cellForRowAt is where we choose which class we want to use. Set up configuration like images, etc
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DigimonCell.identifier, for: indexPath) as? DigimonCell else { fatalError("tableview could not dequeue digimoncell in viewcontroller")}
        let digimon = viewModel.characters[indexPath.row]
        cell.set(imageUrlString: digimon.img, label: digimon.name, level: digimon.level)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}




// MARK: - Extension for ViewController to conform to DigimonViewModelProtocol
extension ViewController: DigimonViewModelProtocol {
    // MARK: - Digimon View Model Protocol Methods
    func didFinish() {
        print("Digimon data is returned from view model")
        //We want to refresh our view
        tableView.reloadData()
   
    }
    
    func didFail(error: Error) {
        print(error)
    }
}



// MARK: - Extension for Search Controller Functions
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
