//
//  Helper.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import UIKit

struct Helper {
// MARK: - PresentModal
    static func presentFavoriteModal(vc: UIViewController, name: String, completationOk : (() -> Void)? = nil, completationCancel : (() -> Void)? = nil){

        let storyboard = UIStoryboard(name: "ZAModal", bundle: nil)
        if let modal = storyboard.instantiateViewController(withIdentifier: "ZAModalViewController") as? ZAModalViewController {
            
            modal.modalPresentationStyle   = .overCurrentContext
            modal.nameText                 = name
            modal.completationOk           = completationOk
            modal.completationCancel       = completationCancel

            vc.present(modal, animated: false, completion: nil)
        }
    }
}
