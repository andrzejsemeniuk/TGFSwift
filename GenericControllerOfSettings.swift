//
//  GenericControllerOfSettings.swift
//  productGroceries
//
//  Created by Andrzej Semeniuk on 3/25/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit


class GenericControllerOfSettings : UITableViewController
{
    var rows:[[Any]] = []
    
    static var lastOffsetY:[String:CGPoint] = [:]
    
    
    
    
    override func numberOfSectionsInTableView   (tableView: UITableView) -> Int
    {
        return rows.count
    }
    
    override func tableView                     (tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return section < rows.count ? rows[section].count-2 : 0
    }
    
    override func tableView                     (tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if 0 < rows.count {
            if let text = rows[section].first as? String {
                return 0 < text.length ? text : nil
            }
        }
        return nil
    }
    
    override func tableView                     (tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        if 0 < rows.count {
            if let text = rows[section].last as? String {
                return 0 < text.length ? text : nil
            }
        }
        return nil
    }
    
    override func tableView                     (tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int
    {
        if 0 < indexPath.row {
            //            return 1
        }
        return 0
    }
    
    override func tableView                     (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style:.Value1,reuseIdentifier:nil)
        
        cell.selectionStyle = .None
        
        if let HSBA = cell.backgroundColor?.HSBA() {
            if 1 <= HSBA.alpha {
                cell.backgroundColor = cell.backgroundColor!.colorWithAlphaComponent(0.50)
            }
        }
        else {
            cell.backgroundColor = UIColor(white:1,alpha:0.7)
        }
        
        if 0 < rows.count {
            if let f = rows[indexPath.section][indexPath.row+1] as? FunctionOnCell {
                f(cell:cell,indexPath:indexPath)
            }
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    typealias Action = () -> ()
    
    var actions:[NSIndexPath : Action] = [:]
    
    func addAction(indexPath:NSIndexPath, action:Action) {
        actions[indexPath] = action
    }
    
    func registerCellSelection(indexPath:NSIndexPath, action:Action) {
        addAction(indexPath,action:action)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let action = actions[indexPath]
        {
            action()
        }
    }
    
    
    
    
    typealias Update = Action
    
    var updates:[Update] = []
    
    func addUpdate(update:Update) {
        updates.append(update)
    }
    
    
    
    typealias FunctionUpdateOnSwitch = (UISwitch) -> ()
    
    var registeredSwitches:[UISwitch:FunctionUpdateOnSwitch] = [:]
    
    func registerSwitch(on:Bool, animated:Bool = true, update:FunctionUpdateOnSwitch) -> UISwitch {
        let view = UISwitch()
        view.setOn(on, animated:animated)
        registeredSwitches[view] = update
        view.addTarget(self,action:#selector(GenericControllerOfSettings.handleSwitch(_:)),forControlEvents:.ValueChanged)
        return view
    }
    
    func handleSwitch(control:UISwitch?) {
        if let myswitch = control, let update = registeredSwitches[myswitch] {
            update(myswitch)
        }
    }
    
    
    
    
    
    
    typealias FunctionUpdateOnSlider = (UISlider) -> ()
    
    var registeredSliders:[UISlider:FunctionUpdateOnSlider] = [:]
    
    func registerSlider(value:Float, minimum:Float = 0, maximum:Float = 1, continuous:Bool = false, animated:Bool = true, update:FunctionUpdateOnSlider) -> UISlider {
        let view = UISlider()
        view.minimumValue = minimum
        view.maximumValue = maximum
        view.continuous = continuous
        view.value = value
        registeredSliders[view] = update
        view.addTarget(self,action:#selector(GenericControllerOfSettings.handleSlider(_:)),forControlEvents:.ValueChanged)
        return view
    }
    
    func handleSlider(control:UISlider?) {
        if let myslider = control, let update = registeredSliders[myslider] {
            update(myslider)
        }
    }
    
    
    
    
    typealias FunctionOnCell = (cell:UITableViewCell, indexPath:NSIndexPath) -> ()
    
    func createCellForFont(font0:UIFont, name:String = "Font", title:String, key:Data.Manager.Key, action:Action! = nil) -> FunctionOnCell
    {
        return
            { (cell:UITableViewCell, indexPath:NSIndexPath) in
                if let label = cell.textLabel {
                    
                    label.text          = name
                    if let detail = cell.detailTextLabel {
                        detail.text = font0.fontName
                    }
                    cell.selectionStyle = .Default
                    cell.accessoryType  = .DisclosureIndicator
                    self.addAction(indexPath) {
                        
                        let fonts       = GenericControllerOfPickerOfFont()
                        
                        fonts.title     = title+" Font"
                        
                        fonts.selected  = font0.fontName
                        
                        fonts.update    = {
                            Data.Manager.settingsSetString(fonts.selected, forKey:key)
                            if action != nil {
                                action()
                            }
                        }
                        
                        self.navigationController?.pushViewController(fonts, animated:true)
                    }
                }
        }
    }
    
    
    func createCellForColor(color0:UIColor, postProcess:((UITableViewCell) -> Void)! = nil, name:String = "Color", title:String, key:Data.Manager.Key, action:Action! = nil) -> FunctionOnCell
    {
        return
            { (cell:UITableViewCell, indexPath:NSIndexPath) in
                if let label = cell.textLabel {
                    
                    label.text          = name
                    if let detail = cell.detailTextLabel {
                        detail.text = "  "
                        let view = UIView()
                        
                        view.frame              = CGRectMake(-16,-2,24,24)
                        view.backgroundColor    = color0
                        
                        detail.addSubview(view)
                    }
                    cell.selectionStyle = .Default
                    cell.accessoryType  = .DisclosureIndicator
                    
                    if postProcess != nil {
                        postProcess(cell)
                    }
                    
                    self.addAction(indexPath) {
                        
                        let colors      = GenericControllerOfPickerOfColor()
                        
                        colors.title    = title+" Color"
                        
                        colors.selected = color0
                        
                        colors.update   = {
                            Data.Manager.settingsSetColor(colors.selected, forKey:key)

                            if action != nil {
                                action()
                            }
                        }
                        
                        self.navigationController?.pushViewController(colors, animated:true)
                    }
                }
        }
    }
    
    
    
    func reload()
    {
        tableView.reloadData()
    }
    
    
    func createRows() -> [[Any]]
    {
        return [[Any]]()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        registeredSliders.removeAll()
        registeredSwitches.removeAll()
        
        updates.removeAll()
        
        actions.removeAll()
        
        rows = createRows()
        
        reload()
        
        if let title = super.title {
            if let point = GenericControllerOfSettings.lastOffsetY[title] {
                tableView.setContentOffset(point,animated:true)
            }
        }
        
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewWillDisappear(animated: Bool)
    {
        if let title = super.title {
            GenericControllerOfSettings.lastOffsetY[title] = tableView.contentOffset
        }
        
        registeredSliders.removeAll()
        registeredSwitches.removeAll()
        
        for update in updates {
            update()
        }
        
        updates.removeAll()
        
        rows.removeAll()
        
        actions.removeAll()
        
        super.viewWillDisappear(animated)
    }
    
    
    
    
    
    
    
}