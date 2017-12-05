//
//  StockListViewController.swift
//  WhatIf
//
//  Created by Kevin Wijendra on 12/5/17.
//  Copyright © 2017 Kevin Wijendra. All rights reserved.
//

import UIKit

class StockListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var aboutBarButton: UIBarButtonItem!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    var stocks = [String]()
    var defaultsData = UserDefaults.standard
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        stocks = defaultsData.stringArray(forKey: "stocks") ?? [String]()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                destination.stockDetail.stockSymbol = stocks[selectedRow]
            }
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    func saveDefaultsData() {
        defaultsData.set(stocks, forKey: "stocks")
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            aboutBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            aboutBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
    
    @IBAction func unwindFromAddStockViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! AddStockViewController
        let newIndexPath = IndexPath(row: stocks.count, section: 0)
        stocks.append(sourceViewController.stockSymbol)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        saveDefaultsData()
    }
    
}

extension StockListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        cell.textLabel?.text = stocks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stocks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveDefaultsData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = stocks[sourceIndexPath.row]
        stocks.remove(at: sourceIndexPath.row)
        stocks.insert(itemToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
    
}
