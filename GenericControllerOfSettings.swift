//
//  GenericControllerOfSettings.swift
//  productGroceries
//
//  Created by Andrzej Semeniuk on 3/25/16.
//  Copyright © 2016 Tiny Game Factory LLC. All rights reserved.
//

import Foundation
import UIKit
import TGF


class GenericControllerOfSettings : UITableViewController
{
    var rows:[[Any]] = []
    
    static var lastOffsetY:[String:CGPoint] = [:]
    
    
    
    
    override func numberOfSections              (in: UITableView) -> Int
    {
        return rows.count
    }
    
    override func tableView                     (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return section < rows.count ? rows[section].count-2 : 0
    }
    
    override func tableView                     (_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if 0 < rows.count {
            if let text = rows[section].first as? String {
                return 0 < text.length ? text : nil
            }
        }
        return nil
    }
    
    override func tableView                     (_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    {
        if 0 < rows.count {
            if let text = rows[section].last as? String {
                return 0 < text.length ? text : nil
            }
        }
        return nil
    }
    
    override func tableView                     (_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    {
        if 0 < indexPath.row {
            //            return 1
        }
        return 0
    }
    
    override func tableView                     (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style:.value1,reuseIdentifier:nil)
        
        cell.selectionStyle = .none
        
        if let HSBA = cell.backgroundColor?.HSBA() {
            if 1 <= HSBA.alpha {
                cell.backgroundColor = cell.backgroundColor!.withAlphaComponent(0.50)
            }
        }
        else {
            cell.backgroundColor = UIColor(white:1,alpha:0.7)
        }
        
        if 0 < rows.count {
            if let f = rows[indexPath.section][indexPath.row+1] as? FunctionOnCell {
                f(cell,indexPath)
            }
        }
        
        return cell
    }
    
    
    
    
    var colorForHeaderText:UIColor?
    var colorForFooterText:UIColor?
    
    
    
    override func tableView                     (_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            if let color = colorForHeaderText {
                view.textLabel?.textColor = color
            }
        }
        
    }
    

    override func tableView                     (_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            if let color = colorForFooterText {
                view.textLabel?.textColor = color
            }
        }
        
    }
    

    
    
    
    typealias Action = () -> ()
    
    var actions:[IndexPath : Action] = [:]
    
    func addAction(indexPath:IndexPath, action:@escaping Action) {
        actions[indexPath] = action
    }
    
    func registerCellSelection(indexPath:IndexPath, action:@escaping Action) {
        addAction(indexPath: indexPath,action:action)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let action = actions[indexPath]
        {
            action()
        }
    }
    
    
    
    
    typealias Update = Action
    
    var updates:[Update] = []
    
    func addUpdate(update:@escaping Update) {
        updates.append(update)
    }
    
    
    
    typealias FunctionUpdateOnSwitch = (UISwitch) -> ()
    
    var registeredSwitches:[UISwitch:FunctionUpdateOnSwitch] = [:]
    
    func registerSwitch(on:Bool, animated:Bool = true, update:@escaping FunctionUpdateOnSwitch) -> UISwitch {
        let view = UISwitch()
        view.setOn(on, animated:animated)
        registeredSwitches[view] = update
        view.addTarget(self,action:#selector(GenericControllerOfSettings.handleSwitch(control:)),for:.valueChanged)
        return view
    }
    
    func handleSwitch(control:UISwitch?) {
        if let myswitch = control, let update = registeredSwitches[myswitch] {
            update(myswitch)
        }
    }
    
    
    
    
    
    
    typealias FunctionUpdateOnSlider = (UISlider) -> ()
    
    var registeredSliders:[UISlider:FunctionUpdateOnSlider] = [:]
    
    func registerSlider(value:Float, minimum:Float = 0, maximum:Float = 1, continuous:Bool = false, animated:Bool = true, update:@escaping FunctionUpdateOnSlider) -> UISlider {
        let view = UISlider()
        view.minimumValue = minimum
        view.maximumValue = maximum
        view.isContinuous = continuous
        view.value = value
        registeredSliders[view] = update
        view.addTarget(self,action:#selector(GenericControllerOfSettings.handleSlider(control:)),for:.valueChanged)
        return view
    }
    
    func handleSlider(control:UISlider?) {
        if let myslider = control, let update = registeredSliders[myslider] {
            update(myslider)
        }
    }
    
    
    
    
    typealias FunctionOnCell = (_ cell:UITableViewCell, _ indexPath:IndexPath) -> ()
    
    func createCellForFont(font0:UIFont, name:String = "Font", title:String, key:Data.Manager.Key, action:Action! = nil) -> FunctionOnCell
    {
        return
            { (cell:UITableViewCell, indexPath:IndexPath) in
                if let label = cell.textLabel {
                    
                    label.text          = name
                    if let detail = cell.detailTextLabel {
                        detail.text = font0.fontName
                    }
                    cell.selectionStyle = .default
                    cell.accessoryType  = .disclosureIndicator
                    self.addAction(indexPath: indexPath) {
                        
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
            { (cell:UITableViewCell, indexPath:IndexPath) in
                if let label = cell.textLabel {
                    
                    label.text          = name
                    if let detail = cell.detailTextLabel {
                        detail.text = "  "
                        let view = UIView()
                        
                        view.frame              = CGRect(x:-16,y:-2,width:24,height:24)
                        view.backgroundColor    = color0
                        
                        detail.addSubview(view)
                    }
                    cell.selectionStyle = .default
                    cell.accessoryType  = .disclosureIndicator
                    
                    if postProcess != nil {
                        postProcess(cell)
                    }
                    
                    self.addAction(indexPath: indexPath) {
                        
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
    
    override func viewWillAppear(_ animated: Bool)
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
    
    
    override func viewWillDisappear(_ animated: Bool)
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
