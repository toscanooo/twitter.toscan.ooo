//
//  FeedController.swift
//  ttclone
//
//  Created by toscano on 7/1/20.
//  Copyright © 2020 Marcelo Toscano. All rights reserved.
//

import UIKit

class FeedController: UIViewController{
    override func viewDidLoad() {
        super .viewDidLoad()
        //view.backgroundColor = .systemFill
        
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        let ttimage = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        ttimage.contentMode = .scaleAspectFit
        navigationItem.titleView = ttimage
    }
}
