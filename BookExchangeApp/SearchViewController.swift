//
//  SearchViewController.swift
//  BookExchangeApp
//
//  Created by Adler Faulkner on 2/26/15.
//  Copyright (c) 2015 Adler Faulkner. All rights reserved.
//

import UIKit

let reuseTableViewCellIdentifier = "TableViewCell"
let reuseCollectionViewCellIdentifier = "CollectionViewCell"

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    // popular and recents controls
    @IBOutlet weak var tableView: UITableView!
    
    var popJson: JSON = []
    var recBoJson: JSON = []
    var recPoJson: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (getSession() != nil) {
            var parameters = ["api_key": getSession()]
            DataManager.sharedInstance.call( "/book/popular", parameters: parameters,
                completion: { (error, result) -> Void in
                    if error != nil {
                        println("error!")
                        println(error)
                    } else {
                        println(result)
                        self.popJson = result!
                    }
            })
            DataManager.sharedInstance.call( "/book/recently_bought", parameters: parameters,
                completion: { (error, result) -> Void in
                    if error != nil {
                        println("error!")
                        println(error)
                    } else {
                        println(result)
                        self.recBoJson = result!
                    }
            })
        }
        else {
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        if (indexPath.row == 0) {
            
        }
            
        else if (indexPath.row == 1) {
            
        }
            
        else {
            
        }
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        //cell.textLabel!.text = people[indexPath.row].fname + " is " + people[indexPath.row].age + " years old"
        
        return cell
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

