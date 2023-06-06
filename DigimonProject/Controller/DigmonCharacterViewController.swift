//
//  ViewController.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/15/23.
//

import UIKit

//UIViewController contains a content view

class DigmonCharacterViewController: UIViewController {

    
    // MARK: - Properties
    //Create table view.
    //tableView is in no man's land until we add it to a subview.
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(DigimonCell.self, forCellReuseIdentifier: DigimonCell.identifier)
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    //Create DigimonViewModel object/instance and assign it to the variable viewModel
    var viewModel = DigimonViewModel()

    var currentCharacters: [Digimon] {
        let isInSearchMode = viewModel.inSearchMode(searchController)
        if isInSearchMode {
            return viewModel.filteredDigimon
        } else {
            if selectedLevel == .all {
                return viewModel.characters
            } else {
                return viewModel.characters.filter({ $0.level == selectedLevel.levelName })
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //Need to explicitly tell the view to update when this fetching of data is finished. To do this we can use a delegate. Deletgates allows us to communicate between objects and delegate tasks. In this case from from our ViewModel to the view controller.
        //Setting the delegate property of the view model to the ViewController
        viewModel.delegate = self
        //Get the data from the view model
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
        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Setting up the constraints for the tableview in the View
        NSLayoutConstraint.activate([
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
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: nil, image: UIImage(systemName: "line.3.horizontal.decrease.circle"), target: self, action: nil, menu: filterLevel())

    }
    
  
    var selectedLevel: LevelType = .all
    @objc func filterLevel() -> UIMenu {
        //
        let digiLevel = LevelType.allCases
        let children = digiLevel.map { level in
            UIAction(title: level.levelName, state: level == selectedLevel ? .on : .off , handler: { [self]  _ in
                print("\(level.levelName) selected")
                selectedLevel = level
                print("\(level.levelName)")
                self.tableView.reloadData()
                //BUG ISSUE: TableView is not reloading after switching options
            })
        }
        
        let addMenuItem = UIMenu(title: "", options: .singleSelection, children: children)
        
        return addMenuItem
    }
    
    
    func configSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        //This is what will be displayed in the search bar
        self.searchController.searchBar.placeholder = "Search Digimon"
        //The color of the background of the textfield
        self.searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    
    
    // MARK: - Selectors
    
    
    @objc func favoriteButtonTapped(sender: UIButton) {
        
        //Can use the tag to store the index path on each favorites button
        let row = sender.tag
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? DigimonCell else {
            return
        }
        
        let inSearchMode = viewModel.inSearchMode(searchController)
        let digimon = inSearchMode ? viewModel.filteredDigimon[indexPath.row] : viewModel.characters[indexPath.row]
   
        let saveError = PersistenceManager.updateWith(favorite: digimon, actionType: .add)
        switch saveError {
        case .none:
            presentAlertOnMainThread(title: "Digimon Added", message: "You favorited \(digimon.name)👍", buttonTitle: "Done")
            //Add alert to notify user that they favorited the digimon
        case .some(let error):
            presentAlertOnMainThread(title: "Digimon in favorites", message: "You already favorited \(digimon.name)", buttonTitle: "Done")
            //Add alert if there was an error
        }
    }
    

}






// MARK: - Extension for TableView delegate and data source

extension DigmonCharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCharacters.count
    }
    
    
    //for cellForRowAt is where we choose which class we want to use. Set up configuration like images, etc
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DigimonCell.identifier, for: indexPath) as? DigimonCell else { fatalError("tableview could not dequeue digimoncell in viewcontroller")}
        let digimon = currentCharacters[indexPath.row]
        cell.set(digimon: digimon)

        
        //Making a button to favorite a Digimon. Can be placed in cellForRowAt or in the Cell
        let favoriteAddButton = UIButton(type: .custom)
        favoriteAddButton.tag = indexPath.row
        favoriteAddButton.setImage(UIImage(systemName: "plus"), for: .normal)
        favoriteAddButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        favoriteAddButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        cell.accessoryView = favoriteAddButton
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}




// MARK: - Extension for ViewController to conform to DigimonViewModelProtocol
extension DigmonCharacterViewController: DigimonViewModelProtocol {
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
//UISearchResults updates the search results based on the input into the search bar
extension DigmonCharacterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
        
        //Refreshing the view with the updated search text
        tableView.reloadData()
    }
}
