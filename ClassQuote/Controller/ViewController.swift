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
        toggleActivityIndicator(shown: true)
        QuoteService.shared.getQuote { (success, quote) in
            if success, let quote = quote {
                self.update(quote)
            } else {
                self.presentAlert()
            }
            self.toggleActivityIndicator(shown: false)
        }
    }
    
    private func update(_ quote: Quote) {
        quoteLabel.text = quote.text
        authorLabel.text = quote.author
        imageView.image = UIImage(data: quote.imageData)
    }
    
    private func toggleActivityIndicator(shown: Bool){
        newQuoteButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Erreur requête", message: "Une erreur s'est produite", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let retry = UIAlertAction(title: "Réessayer", style: .default, handler: { (action) in
            self.tappedNewQuoteButton()
        })
        alertVC.addAction(ok)
        alertVC.addAction(retry)
        present(alertVC, animated: true, completion: nil)
    }
}

