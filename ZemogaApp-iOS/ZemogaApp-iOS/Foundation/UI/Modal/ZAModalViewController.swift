//
//  ZAModalViewController.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit

class ZAModalViewController: UIViewController {
    
    @IBOutlet weak var nameModalLabel: UILabel!
    @IBOutlet weak var messageModalLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameHeightConstraints: NSLayoutConstraint!
    
    var nameText : String?
    var messageText : String?
    
    var completationOk : (() -> Void)?
    var completationCancel : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.animation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: false)
    }
    
// MARK: - Methods
    func configUI() {
        let radius : CGFloat = 25.0
        self.containerView?.clipsToBounds = true
        self.containerView?.layer.cornerRadius = radius
        
        self.nameModalLabel?.text  = self.nameText
        
        if self.nameText == nil {
            self.nameModalLabel?.isHidden = true
            self.nameHeightConstraints?.constant = 0
        }
        
        self.nameModalLabel?.adjustsFontSizeToFitWidth = true
        self.messageModalLabel?.text  = self.messageText
        self.messageModalLabel?.textColor = .gray
        self.acceptButton?.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func animation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.messageModalLabel?.transform  = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.containerView?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
           completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.messageModalLabel?.transform  = CGAffineTransform.identity
                self.containerView?.transform = CGAffineTransform.identity
            }
        })
    }
    
// MARK: - Actions
    @IBAction func acceptOnClick(_ sender: Any) {
        self.dismiss(animated: false)
        self.completationOk?()
    }
    
    @IBAction func cancelOnClick(_ sender: Any) {
        self.dismiss(animated: false)
        self.completationCancel?()
    }
}
