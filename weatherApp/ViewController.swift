//
//  ViewController.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UITableViewController {
    
    //MARK : variables
    fileprivate let refreshItemsControl = UIRefreshControl()
    fileprivate let tableInsets = UIEdgeInsets(top: 4, left: 24, bottom: 0, right: 24)
    fileprivate let dataSource = WeatherItemsListDataSource()
    fileprivate let hud = JGProgressHUD(style: .dark)
    fileprivate var isInternetAvailable = true {
        didSet {
            updateErrorAlert()
        }
    }
    
    lazy var viewModel : WeatherItemsListViewModel = {
        let viewModel = WeatherItemsListViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    //MARK : Outlets
    @IBOutlet weak var alertView: UIView! {
        didSet {
            alertView.backgroundColor = UIColor.errorView
        }
    }
    
    @IBOutlet weak var offlineMsg: UILabel! {
        didSet {
            offlineMsg.style = LabelStyle.subtitle.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Current weather"
        
        hud.textLabel.text = "Loading"
        
        setupNavigationBar()
        
        setupTableView()
        
        setupAlertView()
        
        dataSource.data.addAndNotify(observer: self) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.refreshItemsControl.endRefreshing()
            
            // 1
            self.tableView.reloadData()
            
        }
        
        hud.show(in: self.view)
        refreshItemsData()
        
    }
    
    fileprivate func updateErrorAlert() {
        // called by some of your observer, which checks for changes in internet connection
    
        if !isInternetAvailable {
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveLinear, animations: {
        
                self.alertView.alpha = 0.5
                self.alertView.transform = .identity
                
            }, completion: { [weak self] (isCompleted) in
                
                guard let self = self else {
                    return
                }
                
                self.tableView.reloadData()
                
            })
        } else {
            setupAlertView()
        }
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "ic_restart"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(refreshItemsData))
    }
    
    fileprivate func setupAlertView() {
        let transform = CGAffineTransform(translationX: 0, y: -alertView.frame.height)
        alertView.alpha = 0
        alertView.transform = transform
    }
    
    fileprivate func setupTableView() {
        
        // Add Refresh Control to Table View
        
        tableView.separatorInset = tableInsets
        tableView.backgroundColor = UIColor.mainBg
        //setting up the flexible cell height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        //removing empty cells
        tableView.tableFooterView = UIView.init()
        tableView.layoutMargins = .zero
        tableView.register(WeatherItemTableViewCell.nibCell, forCellReuseIdentifier: WeatherItemTableViewCell.identifierCell)
        
        tableView.dataSource = dataSource
        tableView.refreshControl = refreshItemsControl
        
        // Configure Refresh Control
        refreshItemsControl.addTarget(self, action: #selector(refreshItemsData), for: .valueChanged)
        
    }
    
    @objc private func refreshItemsData() {
        //
        
        hud.show(in: self.view)
        viewModel.fetchItems { [weak self] (result) in
            
            guard let self = self else {
                return
            }
            
            self.hud.dismiss(afterDelay: 3.0)
            
            switch result {
            case .success( _) :
                self.isInternetAvailable = true
                break
            case .failure(let error) :
                
                switch error {
                    case .offline(let errorMsg):
                        self.offlineMsg.text = errorMsg
                        self.isInternetAvailable = false
                    case .network(let errorMsg):
                        self.offlineMsg.text = errorMsg
                        self.isInternetAvailable = false
                    default:
                        self.isInternetAvailable = true
                    break
                }
            }
        }
    }

}

