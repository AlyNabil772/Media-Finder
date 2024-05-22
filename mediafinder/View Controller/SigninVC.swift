

import UIKit

class SigninVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    
    //MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(false, forKey: "UDKIslogedIn") // This code means the user make Logout (UDKIsLognin ) = false
        navigationItem.setHidesBackButton(true, animated: true) // tHide Back button in Navigation Bar

    }
    
    //MARK: - Actions.
    @IBAction func goToThirdScreenBtnTapped(_ sender: UIButton) {
        getData()
    }
}

//MARK: - Private Methods 
extension SigninVC {
    private func getData() { // this func to get and decode data in one object
        if let saveData = UserDefaults.standard.data(forKey: "userData") {
            do {
                let decoder = JSONDecoder()
                let decodedUserData = try decoder.decode(User.self,from: saveData)
                let email = decodedUserData.email
                let password = decodedUserData.password
                checkIfUserIsValid(email: email, password: password) // it's related to below func 
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
            }
        }
    }
    private func checkIfUserIsValid(email: String, password: String) { // this func to check if email and passowrd are invalid or not
        if email == enterEmailTextField.text && password == enterPasswordTextField.text {
            goToProfileVC()
        } else {
            print("invalid email or password")

        }
    }
    private func goToProfileVC() { // This func to go to prifileVc
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: ProfileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        navigationController?.pushViewController(viewController, animated: true)
    }
}

