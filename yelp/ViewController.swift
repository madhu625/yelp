//
//  ViewController.swift
//  yelp
//
//  Created by Deepti Chinta on 9/19/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

private let CELL_NAME="com.deeptichinta.yelp.customcell"


class ViewController: UIViewController,UITableViewDataSource {
    var rests:NSArray?

    @IBOutlet weak var restsTableView: UITableView!
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (rests?.count ?? 0)
        return rests?.count ?? 0
    }

   
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexpath:NSIndexPath) -> UITableViewCell {
        let restDictionary = rests![indexpath.row] as! NSDictionary
        let restTitle = restDictionary["title"] as! String

        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! YelpCell
        cell.nameLabel.text = restTitle
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // API Async call
        // Method 1
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=f2fk8pundhpxf77fscxvkupy"
        let request = NSMutableURLRequest(URL: NSURL(string: RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                self.rests = responseDictionary["movies"] as? NSArray
                self.restsTableView!.reloadData()
        }
        // Method 1 end
    }

}


class YelpCell:UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    
}
