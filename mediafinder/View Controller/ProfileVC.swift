

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showEmailLabel: UILabel!
    @IBOutlet weak var showPhoneLabel: UILabel!
    @IBOutlet weak var showAddressLabel: UILabel!
    @IBOutlet weak var showUserImage: UIImageView!
    @IBOutlet weak var showGenderLable: UILabel!
    
    //MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutBtn()
        getDataFromUserdefaults() // calling this func to in viewDidload load to shows user data
//        UserDefaults.standard.setValue(true, forKey: "UDKIslogedIn") // set bool value and  string key to check the user make login befor or not then calling this code in didFinishLaunchingWithOptions func in AppDelegate
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showUserImage.layer.cornerRadius = showUserImage.frame.height / 2 // this code to change the image shape to be circylar insted of square
        getDataFromUserdefaults()
    }
    
    //MARK: - Actions
    @objc func logoutTapped() { // action to move to SigninVc when tapped on logout button
        //Method 1 :  i cane use this method or below method both are best solution
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "SigninVC")
        navigationController?.viewControllers = [viewController, self] // the purpose of this code to use pop by navigationController to back to SignInVc whene the user clicks on Logout Button
        navigationController?.popViewController(animated: true)
//        Method 2 : i cane use this method or above method both are best solution
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//        appDelegate.swichToSignInVc()
    }
}

//MARK: - Private Methods 
extension ProfileVC {
    // This func to get and showing the data in profile
    private func getDataFromUserdefaults() { 
        let userDefaults = UserDefaults.standard
        guard let email = userDefaults.string(forKey: "UDKEmail") else {return}
        if let saveData = SqlManager.shared.fetchData(email: email) {
            showNameLabel.text = saveData.name
            showEmailLabel.text = saveData.email
            showPhoneLabel.text = saveData.phone
            showAddressLabel.text = saveData.address
            showUserImage.image = UIImage(data: saveData.userImage) // to retrive the image as a data
            showGenderLable.text = saveData.gender.rawValue
            
        }
    }
    private func logOutBtn() { // func to create logOutBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutTapped)) // Create Logout Button In Navigation Bar
    }
}




