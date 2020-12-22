//
//  MainTabController.swift
//  ttclone
//
//  Created by toscano on 7/1/20.
//  Copyright © 2020 Marcelo Toscano. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemFill
        configureViewControllers()
        configureUI()
    }

    func configureUI() {
        view.addSubview(actionButton)
        /*
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
         */
        actionButton.layer.cornerRadius = 56/2
        
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor,
                            paddingBottom: 64,
                            paddingRight: 16,
                            width: 56,
                            height: 56)
        
    }
    
    @objc func actionButtonTapped(){
        print("clicando no botao ")
    }
    
    func configureViewControllers(){
        
        let feed = FeedController()
        let feed_nav = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let explore_nav = UINavigationController(rootViewController: explore)
        explore_nav.tabBarItem.image = UIImage(named: "search_unselected")
                
        let notification = NotificationController()
        let notification_nav = UINavigationController(rootViewController: notification)
        notification_nav.tabBarItem.image = UIImage(named: "like_unselected")
        
        let conversation = ConversationController()
        let conversation_nav = UINavigationController(rootViewController: conversation)
        conversation_nav.tabBarItem.image = UIImage(named: "ic_mail_outline_white_2x-1")
        
        viewControllers = [feed_nav, explore_nav, notification_nav, conversation_nav]
    
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
