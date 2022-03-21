//
//  BaseViewController.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit
import SwiftUI

class BaseViewController: UIViewController {
    
    var loadingVC: LoadingIndicatorViewController?
    var userButton = BadgedButtonItem(with: UIImage(named: "reload")?.withRenderingMode(.alwaysOriginal))

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupBackButton() {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(self.backButtonClickedDismiss(sender:)))
        
        self.navigationItem.leftBarButtonItem  = backButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func settingsNavBar(image: String) {
        let titleScreen = UILabel()
        let titleScreenView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        userButton = BadgedButtonItem(with: UIImage(named: image))
        
        navigationController?.clearBackground()
        navigationController?.setBackground()
        
        titleScreen.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        titleScreen.text = "POST"
        titleScreen.font = UIFont(name: "Roboto-Bold", size: 18)
        titleScreen.numberOfLines = 1
        titleScreen.textAlignment = .center
        titleScreen.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        titleScreenView.addSubview(titleScreen)
        titleScreenView.backgroundColor = .clear
        
        self.navigationItem.titleView = titleScreenView
        self.navigationItem.rightBarButtonItems = [userButton]
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
}

// MARK: - Loading View
extension BaseViewController {
    func showLoading() {
        loadingVC = LoadingIndicatorViewController()
        add(loadingVC!)
        loadingVC?.view.frame = view.bounds
    }

    func showLoading(inside wiew: UIView) {
        loadingVC = LoadingIndicatorViewController()
        add(child: loadingVC!, container: wiew)
        loadingVC?.view.frame = wiew.bounds
    }

    func hideLoading() {
        loadingVC?.remove()
        loadingVC = nil
    }
}


// MARK: - Alert
extension BaseViewController {
    func displaySimpleAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

