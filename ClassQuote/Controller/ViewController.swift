//
//  ViewController.swift
//  ClassQuote
//
//  Created by Alex on 01/03/2019.
//  Copyright © 2019 Alexandre Holet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var tg: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToQuoteLabel()
    }

    private func addShadowToQuoteLabel() {
        quoteLabel.layer.shadowColor = UIColor.black.cgColor
        quoteLabel.layer.shadowOpacity = 0.9
        quoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    @IBAction func tappedNewQuoteButton() {
    }
    
}

