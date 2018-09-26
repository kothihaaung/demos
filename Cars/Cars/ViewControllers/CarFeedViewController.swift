//
//  ViewController.swift
//  Cars
//
//  Created by Thiha Aung on 1/30/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

class CarFeedViewController: UIViewController, CarFeedViewModelDelegate, MenuViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource: [CarFeed]?
    @IBOutlet var tableView        : UITableView!
    @IBOutlet var indicatorView    : UIView!
    @IBOutlet var overlayView      : UIView!
    @IBOutlet var overlayButton    : UIButton!
    @IBOutlet var indicatorControl : UIActivityIndicatorView!
    @IBOutlet var menuButton       : UIBarButtonItem!
    
    @IBOutlet var overlayViewWidth  : NSLayoutConstraint!
    @IBOutlet var indicatorViewWidth: NSLayoutConstraint!
    
    var viewModel: CarFeedListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Overlayview clear
        showOverlay(yes: false)
        
        // Show Indicator
        showIndicator(yes: true)
        
        // table view setup
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.addSubview(self.refreshControl)
        
        dataSource = [CarFeed]()
        
        // view model setup
        viewModel = CarFeedListViewModel()
        viewModel?.delegate = self
        
        // Network connection
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        updateUserInterface()
    }
    
    func overLayTap(sender: UITapGestureRecognizer? = nil) {
    }
    
    // tap on menu
    @IBAction func menuTapped(_ sender: Any) {
        MenuView.shared.delegate = self
        MenuView.shared.showMenu(parentView: self.view)
    
        self.navigationController?.navigationBar.layer.zPosition = -1;
        showOverlay(yes: true)
    }
    
    // tap on overlay
    @IBAction func tappedOnOverlay(_ sender: Any) {
        MenuView.shared.closeMenu()
        showOverlay(yes: false)
        self.navigationController?.navigationBar.layer.zPosition = 0;
    }
    
    func showOverlay(yes: Bool) {
        if yes {
            overlayViewWidth.constant = self.view.bounds.width
        }else {
            overlayViewWidth.constant = 0
        }
    }
    
    func showIndicator(yes: Bool) {
        if yes {
            indicatorViewWidth.constant = self.view.bounds.width
        }else {
            indicatorViewWidth.constant = 0
            indicatorControl.stopAnimating()
        }
    }
    
    func updateUserInterface() {
        
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
        // Simulator
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            viewModel?.loadCarFeedList(connection: true)
        #else
            viewModel?.loadCarFeedList(connection: false)
        #endif
        
        case .wifi:
            viewModel?.loadCarFeedList(connection: true)
        case .wwan:
            viewModel?.loadCarFeedList(connection: true)
        }
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    // pull to refresh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        updateUserInterface()
        refreshControl.endRefreshing()
    }

    // View Model Delegate
    // Success
    func dataSourceIsReady(dataSource: [CarFeed]) {
        self.dataSource = dataSource
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.showIndicator(yes: false)
        }
        
    }
    
    // Fail
    func dataSourceDidNotLoaded(message: String) {
    }
    
    // menu delegate
    func menuDidSelect(viewControllerId:String) {
        DispatchQueue.main.async {
            if viewControllerId == "Other" {
                // define child storyboards
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let otherViewController = storyboard.instantiateViewController(withIdentifier: "OtherViewController")
                
                self.present(otherViewController, animated: false, completion: nil)
            }else {
                MenuView.shared.closeMenu()
                self.navigationController?.navigationBar.layer.zPosition = 0;
            }
        }
    }
    
    // Table View Delegate Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "carFeedCell", for: indexPath) as! CarFeedCellTableViewCell
        
        cell.selectionStyle = .none
        
        cell.carImageView.image = UIImage(data: (self.dataSource?[indexPath.row].image)!)
        cell.titleLabel  .text  = self.dataSource?[indexPath.row].title
        cell.dateLabel   .text  = self.dataSource?[indexPath.row].dateTime
        cell.ingressLabel.text  = self.dataSource?[indexPath.row].ingress
        
        // Label heights calculation
        cell.titleLabelHeight.constant   = (self.dataSource?[indexPath.row].title?.height(withConstrainedWidth: cell.titleLabel.frame.width, font: UIFont(name: "SFUIDisplay-Medium", size: 24)!))!
        
        cell.ingressLabelHeight.constant = (self.dataSource?[indexPath.row].ingress?.height(withConstrainedWidth: cell.ingressLabel.frame.width, font: UIFont(name: "SFUIDisplay-Medium", size: 14)!))!
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "carDetails" {
            let detailViewController = segue.destination as! CarDetailsViewController
            let indexPath            = self.tableView.indexPathForSelectedRow
            let carFeed              = self.dataSource![(indexPath?.row)!]
            
            detailViewController.carFeed = carFeed
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

