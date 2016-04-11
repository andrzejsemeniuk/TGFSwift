//
//  GenericControllerOfColor
//  productGroceries
//
//  Created by Andrzej Semeniuk on 3/25/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit

class GenericControllerOfPickerOfColor : UITableViewController
{
    var colors:[UIColor]  = []
    
    var selected:UIColor = UIColor.blackColor()
    
    
    
    override func viewDidLoad()
    {
        tableView.dataSource    = self
        
        tableView.delegate      = self
        
        tableView.separatorStyle = .None
        
        if true
        {
            colors = [
                UIColor.GRAY(1.00,1),
                UIColor.GRAY(0.90,1),
                UIColor.GRAY(0.80,1),
                UIColor.GRAY(0.70,1),
                UIColor.GRAY(0.60,1),
                UIColor.GRAY(0.50,1),
                UIColor.GRAY(0.40,1),
                UIColor.GRAY(0.30,1),
                UIColor.GRAY(0.20,1),
                UIColor.GRAY(0.10,1),
                UIColor.GRAY(0.00,1),
            ]
            
            let hues:[Float]        = [0,0.06,0.1,0.14,0.2,0.3,0.4,0.53,0.6,0.7,0.8,0.9]
            let saturations:[Float] = [0.4,0.6,0.8,1]
            let values:[Float]      = [1]
            
            for h in hues {
                for v in values {
                    for s in saturations {
                        colors.append(UIColor.HSBA(h,s,v,1))
                    }
                }
            }
        }
        
        
        reload()
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // TODO clear data and reload table
    }
    
    
    
    
    
    override func numberOfSectionsInTableView   (tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView                     (tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return colors.count
    }
    
    override func tableView                     (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let color = colors[indexPath.row]
        
        let cell = UITableViewCell(style:.Default,reuseIdentifier:nil)
        
        cell.backgroundColor = color
        
        cell.selectionStyle = .Default
        
        if color.components_RGBA_UInt8_equals(selected) {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    
    
    
    func reload()
    {
        tableView.reloadData()
    }
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        reload()
        
        for (row,color) in colors.enumerate() {
            
            if color.components_RGBA_UInt8_equals(selected) {
                
                let path = NSIndexPath(forRow:row,inSection:0)
                
                tableView.scrollToRowAtIndexPath(path,atScrollPosition:.Middle,animated:true)
                
                break
            }
        }
        
        super.viewWillAppear(animated)
    }
    
    
    
    var update: (() -> ()) = {}
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selected = colors[indexPath.row]
        
        reload()
        
        update()
    }
    
}
