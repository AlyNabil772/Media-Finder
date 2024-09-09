//
//  AppDelegate.swift
//  mediafinder
//
//  Created by ALY NABIL on 26/09/2023.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        SqlManager.shared.setupDatabase()
        handleRoot()
        return true
    }
    //MARK: - Public methods.
    func swichToSignInVc() { // This func to make swich to SignInVc when the user Clicks on logout button in profileVC
        let viewController: SigninVC = storyboard.instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
}

//MARK: - Private methods.
extension AppDelegate {
    // this func to check if the user make login befor or not if yes go to MediaVC screen if not go to login screen
    private func handleRoot() {
        if UserDefaultManager.shared.isOpenedBefore { // check is isOpenedBefore if yes check below condetion
            if UserDefaultManager.shared.isLogedIn { // check if isLogedIn swichToMediaVC() if not swichToSignInVc()
                swichToMediaVC()
            } else {
                swichToSignInVc()
            }
        }
    }
    private func swichToProfileVc() { // This func to make swich to ProfileVC when the user make login 
        let viewController: ProfileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
    private func swichToMediaVC() { // This func to make swich to MediaVC when the user make login
        let viewController: MediaVC = storyboard.instantiateViewController(withIdentifier: "MediaVC") as! MediaVC
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
}


