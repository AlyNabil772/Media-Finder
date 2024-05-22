

import UIKit

class SignupVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userGender: UISwitch!
    
    //MARK: - Propreties
    private var SelectedGender: Gender = .male // var type of Genger enum  ( default value is mail )
    private let imagePiker = UIImagePickerController() // UIImagePickerController() is responsible for images
    
    //MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "sign Up"
        userImageView.image = UIImage(named: "user") // this code to set image manually to be able to make below condetion in isUserDataValid() func
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.height / 2 // this code to change the image shape to be circylar insted of square
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2 // this code to make cornerRadius to signUpButton
    }
    
    //MARK: - Actions
    @IBAction func goToSecondScreenBtnTapped(_ sender: UIButton) {
        if isUserDataValid() { // called here to check if the user data is valed make that saveData() then goToSigninVc()
            saveData() // Called here to save user data after that go to second screen
            goToSigninVc() // Called here to go to signInVC
        }
    }
    @IBAction func addressBtnTapped(_ sender: UIButton) {
        goToMapVC()
    }
    @IBAction func imageBtnTapped(_ sender: UIButton) {
        imagePiker.delegate = self // imagePiker confrim deledate to send the image to signup screen
        imagePiker.allowsEditing = true // for make editing
        imagePiker.sourceType = .photoLibrary // for chose the photo from library
        present(imagePiker, animated: true, completion: nil)
    }
    @IBAction func genderSwitchDidChanged(_ sender: UISwitch) {
        SelectedGender = sender.isOn ? .femail : .male // use ternery operator to ask if the sender is on take femail else take mail
    }
}

//MARK: - Image Piker
extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate { // SignupVC should be confirm UIImagePickerControllerDelegate and UINavigationControllerDelegate protocols ( are related to image )
    // this func related to selected image - info it's means that the selected image - noting that UIImagePickerController.InfoKey type of dictionary it's means that it has key and value the value is info and the key is InfoKey
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // use if let because the user maybe select an image or not
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userImageView.image = selectedImage // shwoing the selected image in userImageView.image
        }
        dismiss(animated: true, completion: nil) // after select the image make a dismiss to back to SignupVc
    }
    // this func means if the user didn't select image or the viewcontrollers is close return directly to SignupVc
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Private Methods
extension SignupVC {
    // it's validation func
    private func isUserDataValid() -> Bool {
        guard let image = userImageView.image, image != UIImage(named: "user") else {
            self.showaAlert(title: "Error", massage: "Pleae select your image")
            return false
        }
        guard let name = nameTextFiled.text, !name.isEmpty else {
            self.showaAlert(title: "Error", massage: "Pleae enter your name")
            return false
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            self.showaAlert(title: "Error", massage: "Pleae enter your email")
            return false
        }
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            self.showaAlert(title: "Error", massage: "Pleae enter your phone")
            return false
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.showaAlert(title: "Error", massage: "Pleae enter your password")
            return false
        }
        guard let address = addressTextField.text, !address.isEmpty else {
            self.showaAlert(title: "Error", massage: "Pleae enter your address")
            return false
        }
        guard ValidationManager.shared().validationOn(email: email) else {
            self.showaAlert(title: "Error", massage: "Pleae enter your email. Example: mediaFinder@example.com")
            return false
        }
        guard ValidationManager.shared().validationOn(password: password) else {
            self.showaAlert(title: "Error", massage: "Pleae enter your password. Example: Abc@1234")
            return false
        }
        guard ValidationManager.shared().validationOn(phone: phone) else {
            self.showaAlert(title: "Error", massage: "Pleae enter your phone. Example: 01111111111")
            return false
        }
        return true
    }
    private func saveData() {
        // this func to save and encode data in one object
        
        let name = nameTextFiled.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let address = addressTextField.text ?? ""
        
        if let userImage = userImageView.image?.pngData() { // this code to convert the image to be data
            let userData = User(name: name, email: email, password: password, phone: phone, address: address, userImage: userImage, gender: SelectedGender)
            
            UserDefaultManager.shared.saveUserData(userData: userData)
            print("user data saved")
            print(UserDefaultManager.shared.loadUserData()?.name, "ddddddddd")
//            do {
//                let encoder = JSONEncoder()
//                let encoderData = try encoder.encode(userData)
//                UserDefaults.standard.set(encoderData, forKey: "userData")
//            } catch {
//                print("Error encoding user data: \(error.localizedDescription)")
//            }
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

//MARK: - SendLocation
extension SignupVC: SendLocation {
    func didSelectedLocation(_ data: String) {
        addressTextField.text = data
    }
}



