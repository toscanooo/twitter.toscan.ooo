//
//  NotificationController.swift
//  ttclone
//
//  Created by toscano on 7/1/20.
//  Copyright © 2020 Marcelo Toscano. All rights reserved.
//

import UIKit

class NotificationController: UIViewController{
    override func viewDidLoad() {
        super .viewDidLoad()
            configureUI()
        }
        func configureUI(){
            view.backgroundColor = .white
            navigationItem.title = "Notification"
        }
}
