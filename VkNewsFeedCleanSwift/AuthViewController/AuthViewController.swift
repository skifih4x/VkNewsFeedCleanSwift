//
//  AuthViewController.swift
//  VkNewsFeedCleanSwift
//
//  Created by Артем Орлов on 21.11.2022.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()

        authService = SceneDelegate.shared().authService
        view.backgroundColor = .green
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

