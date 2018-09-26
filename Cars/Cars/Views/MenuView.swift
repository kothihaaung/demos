//
//  MenuView.swift
//  Cars
//
//  Created by Thiha Aung on 1/31/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

public class MenuCell: UITableViewCell {
    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var menuTitle: UILabel!
}

protocol MenuViewDelegate: class {
    func menuDidSelect(viewControllerId: String)
}

public class MenuView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var menuView  : UIView?
    var parentView: UIView?
    var tableView: UITableView?
    
    var dataSource: [(String, String)]?
    
    weak var delegate:MenuViewDelegate?
    
    static let shared = MenuView()
    
    override init() {
        super.init()
        
        menuView = Bundle.main.loadNibNamed("Menu", owner: self, options: nil)?.first as? UIView
        for view in (menuView?.subviews)! {
            if view.tag == 2 {
                self.tableView = view as? UITableView
            }
        }
        
        self.tableView?.delegate   = self
        self.tableView?.dataSource = self
        
        // register menu cell nib
        let menuCellNib = UINib(nibName: "MenuCellNib", bundle: nil)
        self.tableView?.register(menuCellNib, forCellReuseIdentifier: "menuCell")
        
        // setup datasource
        dataSource = [(String, String)]()
        dataSource?.append(("Cars", "menuCars"))
        dataSource?.append(("Other", "menuOther"))
    }
    
    func showMenu(parentView: UIView) {
        self.parentView      = parentView
        let parentViewFrame = parentView.frame
        self.menuView?.frame = CGRect(x: parentViewFrame.origin.x, y: parentViewFrame.origin.y, width: parentViewFrame.size.width * 0.86, height: parentViewFrame.size.height)
        self.parentView?.addSubview(self.menuView!)
        
    }
    
    func closeMenu() {
        self.menuView?.removeFromSuperview()
        self.parentView = nil
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource?.count)!;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.menuDidSelect(viewControllerId: (self.dataSource?[indexPath.row].0)!)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        cell.menuTitle.text = self.dataSource![indexPath.row].0
        cell.imageView?.image = UIImage(named: self.dataSource![indexPath.row].1)
        cell.selectionStyle = .none
        
        return cell
    }
}
