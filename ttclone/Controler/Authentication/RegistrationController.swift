//
//  RegistrationController.swift
//  ttclone
//
//  Created by toscano on 7/29/20.
//  Copyright © 2020 Marcelo Toscano. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegistrationController: UIViewController{
    
    // MARK:  - properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have ab account? ", "- Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()

    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()

    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full Name")
        tf.isSecureTextEntry = false
        return tf
    }()

    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        tf.isSecureTextEntry = false
        return tf
    }()

    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField )
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()

    private lazy var fullNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextField)
        return view
    }()

    private lazy var userNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: userNameTextField)
        return view
    }()

    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        //button.anchor(top: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        return button
    }()

    // MARK: - Selector
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func handleSignUp(){
        // TODO: implementar
        guard let profileImage = profileImage else {
            print("DEBUG : Profile Image is required!")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let userName = userNameTextField.text else { return }
        
        print("DEBUG : email is \(email)")
        print("DEBUG : password is \(password)")
        print("DEBUG : fullname is \(fullName)")
        print("DEBUG : username is \(userName)")
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (result,error ) in
            if let error = error {
                print("DEBUG : error is \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = ["email":email,"password":password,"userName":userName,"fullName":fullName]
            let ref = Database.database().reference().child("users").child(uid)
            ref.updateChildValues(values) {(error, ref) in
                print("DEBUG: deu certo!")
                return
            }
        }
        
        
        print("handle sing up here ")
    }
    
    @objc func handleAddProfilePhoto(){
        present(imagePicker, animated: true, completion: nil)
        // TODO: implementar
        print("adiconando photo")
    }
    
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }

    func configureUI(){
        // FIXME: - corrigir
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //adicionar todo novo elemento ao stack view
        let stack = UIStackView(arrangedSubviews: [plusPhotoButton,
                                                   emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   userNameContainerView,
                                                   signupButton])

        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0 )
        plusPhotoButton.setDimensions(width: 150, height: 150)

        
        view.addSubview(stack)
        //stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        stack.anchor( top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)

        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingRight: 40
        )

    }
}

 // MARK: uiImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                                info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 75
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
