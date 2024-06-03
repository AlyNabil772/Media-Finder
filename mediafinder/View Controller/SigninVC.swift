

import UIKit

class SigninVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    
    //MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(false, forKey: "UDKIslogedIn") // This code means the user make Logout (UDKIsLognin ) = false
        navigationItem.setHidesBackButton(true, animated: true) // to Hide Back button in Navigation Bar

    }
    
    //MARK: - Actions.
    @IBAction func goToThirdScreenBtnTapped(_ sender: UIButton) {
        getData()
    }
}

//MARK: - Private Methods 
extension SigninVC {
    private func getData() { // this func to get and decode data in one object
        if let saveData = UserDefaultManager.shared.loadUserData() {
            checkIfUserIsValid(email: saveData.email, password: saveData.password)
        }
    }
    private func checkIfUserIsValid(email: String, password: String) { // this func to check if email and passowrd are invalid or not
        if email == enterEmailTextField.text && password == enterPasswordTextField.text {
            goToMediaVC()
        } else {
//            print("invalid email or password")
            self.showaAlert(title: "Error", massage: "Invalid Email or Password")

        }
    }
    private func goToMediaVC() { // This func to go to prifileVc
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: MediaVC = storyboard.instantiateViewController(withIdentifier: "MediaVC") as! MediaVC
        navigationController?.pushViewController(viewController, animated: true)
    }
}

