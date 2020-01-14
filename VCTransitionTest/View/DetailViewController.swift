//
//  DetailViewController.swift
//  VCTransitionTest
//
//  Created by Dima Panchuk on 08.01.2020.
//  Copyright © 2020 dpanchuk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ViewTransitioning {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var transitioningView: UIView? {
        return imageView
    }
    
}
