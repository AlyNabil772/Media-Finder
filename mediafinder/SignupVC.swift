

import UIKit
import CoreLocation

class SignupVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    
    //MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func goToSecondScreenBtnTapped(_ sender: UIButton) {
        saveData() // Called here to save user data after that go to second screen
        goToSigninVc() // Called here to go to signInVC
    }
    @IBAction func addressBtnTapped(_ sender: UIButton) {
        goToMapVC()
    }
}

//MARK: - Private Methods
extension SignupVC {
    private func saveData() {
        // this func to save and encode data in one object
        let name = nameTextFiled.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let address = addressTextField.text ?? ""
        
        let userData = User(name: name, email: email, password: password, phone: phone, address: address)
        
        do {
            let encoder = JSONEncoder()
            let encoderData = try encoder.encode(userData)
            UserDefaults.standard.set(encoderData, forKey: "userData")
            
        } catch {
            print("Error encoding user data: \(error.localizedDescription)")
        }
    }
    
    private func goToSigninVc() { // This func to go to signInVC
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: SigninVC = storyboard.instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
        navigationController?.pushViewController(viewController, animated: true)
    }
    private func goToMapVC() { // This func to go to prifileVc
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: MapVC = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        viewController.delegat = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SignupVC: sendLocation {
    func didSelectedLocation(_ data: String) {
        addressTextField.text = data
    }
    
    
}



