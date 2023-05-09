//
//  FavoritesListViewController.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/28/23.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
    // MARK: - Properties
    var favorites: [Digimon] = []
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //In a total different Navigation controller since tab bar has different navigation controllers for each tab. Need to customize the nav bar UI
        configFavoritesTableView()
        configNavBar()

    }
    
    
    //ViewDidLoad only gets called once. But if the user sees they have no favorites and then adds favorites and goes back to favorites list will get called then. Always refreshing favorites
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    // MARK: - Set up UI
    func configFavoritesTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds //telling how big the table view should be. View.bounds takes up the whole view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
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
        navigationItem.title = "Favorites"
    }
    
    
    
    
    func getFavorites() {
        let results = PersistenceManager.retrieveFavorites()
        
        switch results {
        case .success(let favorites):
            if favorites.isEmpty {
                showEmptyView(with: "You do not have any favorite Digimon added yet.\nFind your favorite Digimon!", in: view)
            } else {
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            }
        case .failure(let error):
            print("❌ getFavorites failed, error: \(error)")
        }
    }
}


// MARK: - Extension for the TableView
extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as?
                FavoriteCell else {
            fatalError("Could not dequeue favoritecell")
        }
        
        //Get favorites
        let favorite = favorites[indexPath.row]//IndexPath.row is grabbing the index from the array for that row
        cell.setFave(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return }
        let deleteFavorite = favorites[indexPath.row]
        let savingError = PersistenceManager.updateWith(favorite: deleteFavorite, actionType: .remove)
        if let savingError {
            //Add an alert here. Unable to remove
            return
        } else {
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            
            if favorites.isEmpty {
                showEmptyView(with: "No favorite digimon added yet", in: self.view)
            }
        }
    }
}
