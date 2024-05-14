

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showEmailLabel: UILabel!
    @IBOutlet weak var showPhoneLabel: UILabel!
    @IBOutlet weak var showAddressLabel: UILabel!
    
    //MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutBtn()
        getDataFromUserdefaults() // calling this func to in viewDidload load to shows user data
        UserDefaults.standard.setValue(true, forKey: "UDKIslogedIn") // set bool value and  string key to check the user make login befor or not then calling this code in didFinishLaunchingWithOptions func in AppDelegate
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
    
    
    @IBAction func testNotificationBtnTapped(_ sender: UIButton) {
//        sendNotification()
    }
}

//MARK: - Private Methods 
extension ProfileVC {
    // This func to get and showing the data in profile
    private func getDataFromUserdefaults() { // this func to get and showing the data in profile
        if let saveData = UserDefaults.standard.data(forKey: "userData") {
            do {
                let decoder = JSONDecoder()
                let decodedUserData = try decoder.decode(User.self,from: saveData)
                let name = decodedUserData.name
                let email = decodedUserData.email
                let phone = decodedUserData.phone
                let address = decodedUserData.address
                showNameLabel.text = name
                showEmailLabel.text = email
                showPhoneLabel.text = phone
                showAddressLabel.text = address
            } catch {
                print("Error decoding user data: /(error.localizedDescription)")
            }
        }
    }
    private func logOutBtn() { // func to create logOutBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutTapped)) // Create Logout Button In Navigation Bar
        navigationItem.setHidesBackButton(true, animated: true) // Hide Back button in Navigation Bar
    }
}



//private func sendNotification() { // craete notification to sent data to SignUpVc
//    let notification = Notification.Name("color")
//    NotificationCenter.default.post(name: notification, object: nil)
//}
