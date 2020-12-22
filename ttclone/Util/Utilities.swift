//
//  Utilities.swift
//  ttclone
//
//  Created by toscano on 7/30/20.
//  Copyright © 2020 Marcelo Toscano. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {

        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        //view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)

        let myColor: UIColor = UIColor.white
        iv.layer.borderColor = myColor.cgColor
        iv.layer.borderWidth = 0.0

        
        //essa é a view que vamos adiconar os elementos
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor,bottom:iv.bottomAnchor,right:view.rightAnchor,paddingLeft: 8, paddingBottom: -3)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        //dividerView.widthAnchor
        //dividerView.widthAnchor.constraint(equalToConstant: 0.75).isActive = true
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor,
                           bottom:view.bottomAnchor,
                           right:view.rightAnchor,
                           paddingLeft: 8,
                           height: 0.75)
        
        return view

    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        
        tf.setDimensions(width: 24, height: 24)
        
        let myColor: UIColor = UIColor.white
        tf.layer.borderColor = myColor.cgColor
        tf.layer.borderWidth = 0.0
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }
    
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart,
                                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                      NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondPart,
                                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                      NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
 }
