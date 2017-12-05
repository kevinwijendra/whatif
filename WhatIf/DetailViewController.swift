//
//  DetailViewController.swift
//  WhatIf
//
//  Created by Kevin Wijendra on 12/5/17.
//  Copyright © 2017 Kevin Wijendra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var stockSymbolLabel: UILabel!
    @IBOutlet weak var initialPriceLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var whatIfLabel: UILabel!
    
    var stockDetail = StockDetail()
    var activityIndicator = UIActivityIndicatorView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockSymbolLabel.text = stockDetail.stockSymbol
        UIApplication.shared.beginIgnoringInteractionEvents()
        setUpActivityIndicator()
        activityIndicator.startAnimating()
        stockDetail.getStockData {
            self.updateUserInterface()
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func updateUserInterface() {
        initialPriceLabel.text = "$" + String(format: "%.2f", stockDetail.initialPrice)
        currentPriceLabel.text = "$" + String(format: "%.2f", stockDetail.currentPrice)
        let shares = 1000/(stockDetail.initialPrice)
        let whatIf = shares * stockDetail.currentPrice
        whatIfLabel.text = "$" + String(format: "%.2f", whatIf)
    }
    
    func setUpActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .white
        activityIndicator.color = UIColor.blue
        view.addSubview(activityIndicator)
    }

}
