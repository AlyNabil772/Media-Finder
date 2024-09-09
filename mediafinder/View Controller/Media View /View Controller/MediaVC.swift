//
//  MoviesVC.swift
//  mediafinder
//
//  Created by ALY NABIL on 31/05/2024.
//

import UIKit
import AVFoundation
import AVKit



class MediaVC: UIViewController {
  
    //MARK: - Outlets
    @IBOutlet weak var mediaTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedIndex: UISegmentedControl!
    
    
    //MARK: - Propreties
//    private var data: [MediaModel] = MediaModel.generateData() // fake data
    private var mediaData: [Result] = []
    let playerViewController = AVPlayerViewController()
    var player: AVPlayer?
    var mediaType: MediaType = .all
    
    
    //MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        profileBtn()
        self.title = "Media List"
        searchBar.delegate = self
        mediaTableView.delegate = self // conform delegate protocol
        mediaTableView.dataSource = self // conform dataSource
        mediaTableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
//        UserDefaults.standard.setValue(true, forKey: "UDKIslogedIn") // set bool value and  string key to check the user make login befor or not then calling this code in didFinishLaunchingWithOptions func in AppDelegate
        
//        check the user make login befor or not then calling this code in didFinishLaunchingWithOptions func in AppDelegate
        UserDefaultManager.shared.isLogedIn = true
    }
    
   //MARK: - Private Func
   private func privewURL(_stringUrl: String) {
        guard let url = URL(string: _stringUrl) else{return}
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc,animated: true) {
            vc.player?.play()
        }
    }
    private func profileBtn() { // func to create profileBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileTapped)) // Create profileBtn In Navigation Bar
        navigationItem.setHidesBackButton(true, animated: true) // Hide Back button in Navigation Bar
    }
 
    //MARK: - Public Func
    func HandleTermAndMedia(term: String, media: String) {
        APIManager.getMediaData(term: term, media: media) { error, mediaArry in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = mediaArry {
                self.mediaData = data
                self.mediaTableView.reloadData()
            }
        }
    }
   
    //MARK: - Actions
    @IBAction func segmentedIndexChanged(_ sender: UISegmentedControl) {
        //let index = sender.selectedSegmentIndex
        guard let searchTerm = searchBar.text else {return}
        switch segmentedIndex.selectedSegmentIndex {
        case 1:
            mediaType = .tvShow
        case 2:
            mediaType = .music
        case 3:
            mediaType = .movie
        default:
            mediaType = .all
        }
        HandleTermAndMedia(term: searchTerm, media: mediaType.rawValue)
    }
}



//MARK: - Extension UISearchBarDelegate
extension MediaVC: UISearchBarDelegate {
    // this func to make search whene user tapped enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        var mediaType: String
        switch segmentedIndex.selectedSegmentIndex {
        case 1:
            mediaType = "tvShow"
        case 2:
            mediaType = "music"
        case 3:
            mediaType = "movie"
        default:
            mediaType = "all"
        }
        HandleTermAndMedia(term: searchTerm, media: mediaType)
    }
}

//MARK: - ProfileBtn
extension MediaVC {
    @objc func profileTapped() { // action to move to ProfileVC when tapped on logout button
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - UITableViewDataSource.
extension MediaVC: UITableViewDataSource {
    // this func related to number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else {return UITableViewCell()}
        let item = mediaData[indexPath.row]
        cell.configurCell(item, type: mediaType)
        cell.tag = indexPath.item
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

//MARK: - UITableViewDelegate 
extension MediaVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = mediaData[indexPath.row]
        print("invalid URL")
        privewURL(_stringUrl: item.previewUrl ?? "nil")
        
        // elshaer solution
//        let previewUrl = data[indexPath.row].previewUrl ?? ""
//        print("invalid URL")
//        privewURL(_stringUrl: previewUrl)
    }
}



