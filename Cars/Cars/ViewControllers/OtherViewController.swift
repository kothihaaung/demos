//
//  OtherViewController.swift
//  Cars
//
//  Created by Thiha Aung on 1/31/18.
//  Copyright © 2018 Thiha Aung. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController, MenuViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedOnMenu(_ sender: Any) {
        MenuView.shared.delegate = self
        MenuView.shared.showMenu(parentView: self.view)
        self.navigationController?.navigationBar.layer.zPosition = -1;
    }
    
    @IBAction func tappedOnOverlay(_ sender: Any) {
        MenuView.shared.closeMenu()
        self.navigationController?.navigationBar.layer.zPosition = 0;
    
    }
    
    
    
    // menu delegate
    func menuDidSelect(viewControllerId:String) {
        DispatchQueue.main.async {
            if viewControllerId == "Cars" {
                // define child storyboards
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let carsViewController = storyboard.instantiateViewController(withIdentifier: "CarsViewController")
                
                self.present(carsViewController, animated: false, completion: nil)
            }else {
                MenuView.shared.closeMenu()
                self.navigationController?.navigationBar.layer.zPosition = 0;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
