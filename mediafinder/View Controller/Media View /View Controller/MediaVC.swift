//
//  MoviesVC.swift
//  mediafinder
//
//  Created by ALY NABIL on 31/05/2024.
//

import UIKit

class MediaVC: UIViewController {
  
    //MARK: - Outlets
    @IBOutlet weak var mediaTableView: UITableView!
    
    //MARK: - Propreties
    private var data: [MediaModel] = MediaModel.generateData()
    
    //MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        profileBtn()
        self.title = "Media List"
        mediaTableView.delegate = self // conform delegate protocol
        mediaTableView.dataSource = self // conform dataSource
        mediaTableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
        UserDefaults.standard.setValue(true, forKey: "UDKIslogedIn") // set bool value and  string key to check the user make login befor or not then calling this code in didFinishLaunchingWithOptions func in AppDelegate
    }
}

//MARK: - UITableViewDataSource.
extension MediaVC: UITableViewDataSource {
    // this func related to number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {return UITableViewCell()}
        let item = data[indexPath.row]
        cell.configurCell(item)
        return cell
    }
}

//MARK: - UITableViewDelegate 
extension MediaVC: UITableViewDelegate {
    // This func related to size of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - ProfileBtn
extension MediaVC {
    private func profileBtn() { // func to create profileBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileTapped)) // Create profileBtn In Navigation Bar
        navigationItem.setHidesBackButton(true, animated: true) // Hide Back button in Navigation Bar
    }
    @objc func profileTapped() { // action to move to ProfileVC when tapped on logout button
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        navigationController?.pushViewController(viewController, animated: true)
    }
}


