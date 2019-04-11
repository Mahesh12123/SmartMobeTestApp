//
//  CustomTableview.swift
//  SmartMobeTestApp
//
//  Created by mahesh mahara on 4/11/19.
//  Copyright © 2019 mahesh mahara. All rights reserved.
//

import Foundation
import UIKit


enum Direction {
    case left,right,top,bottom,none
}


fileprivate func translate(_ sourceParent:UIView, animatingView view:UIView,toDirection from:Direction, isHalfWay:Bool = false) {
    
    let tableHeight: CGFloat =  sourceParent.bounds.size.height
    let tableWidth:CGFloat = sourceParent.bounds.size.width
    
    if isHalfWay {
        //tableHeight = tableHeight*0.7
        //tableWidth = tableHeight*0.7
    }
    
    switch from{
    case .left:
        view.transform = CGAffineTransform(translationX: -2*tableWidth, y: 0)//-2*tableHeight)
    case .right:
        view.transform = CGAffineTransform(translationX: 2*tableWidth, y: 0)//-2*tableHeight)
    case .top:
        //cell.alpha = 0
        view.backgroundColor = .white
        view.transform = CGAffineTransform(translationX: 0, y: -2*tableHeight)
    case .bottom:
        //cell.alpha = 0
        view.backgroundColor = .white
        view.transform = CGAffineTransform(translationX: 0, y: 2*tableHeight)
    case .none:
        //cell.alpha = 0
        view.backgroundColor = .white
    }
}





extension UITableView {
    
    func reload(_ from:Direction = .top, animationType:UIView.AnimationOptions = UIView.AnimationOptions.layoutSubviews,withTableViewHidden hidden:Bool = false ,then:(()->())? = nil){
        
        let tableView = self
        //let tableHeight: CGFloat = tableView.bounds.size.height
        //let tableWidth:CGFloat = tableView.bounds.size.width
        
        UIView.transition(with: self,
                          duration:0,
                          options:animationType,
                          animations:{() -> Void in
                            
                            if hidden {
                                //self.tableFooterView?.transform = CGAffineTransform(translationX: 0, y: -2*tableHeight)
                                self.tableFooterView?.isHidden = hidden
                                self.tableFooterView?.alpha = hidden ? 0 : 1
                            }
                            
                            self.reloadData()
                            //ProgressHud.hideProgressHUD()
                            
        })  { completed in
            
            let cells = tableView.visibleCells
            
            guard cells.count > 0 else  {
                return
            }
            
            var origionalBgColors:[UIColor] = [UIColor]()
            for cell in cells  {
                origionalBgColors.append(cell.backgroundColor!)
                translate(tableView, animatingView: cell, toDirection: from)
            }
            
            var index = 0
            for i in 0...cells.count-1 {
                
                //for a in cells {
                let cell: UITableViewCell = cells[i]
                UIView.animate(withDuration: 1, delay: 0.05 * Double(index), usingSpringWithDamping:0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                    
                    //cell.alpha = 1
                    self.alpha = 1
                    if i == cells.count-1 {
                        tableView.isHidden = false
                    }
                    
                    cell.transform = CGAffineTransform(translationX: 0, y: 0);
                    
                }){(check) in
                    // self.indicator.stopAnimating()
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.backgroundColor = origionalBgColors[i]
                        
                        if hidden {
                            self.tableFooterView?.alpha = 1
                            self.tableFooterView?.isHidden = false
                        }
                    })
                    if i == cells.count-1 {
                        if let then = then {
                            then()
                        }
                    }
                }
                
                index += 1
            }
        }
    }
    
}

extension UITableView {
    
    /// The table section headers that are visible in the table view. (read-only)
    ///
    /// The value of this property is an array containing UITableViewHeaderFooterView objects, each representing a visible cell in the table view.
    ///
    /// Derived From: [http://stackoverflow.com/a/31029960/5191100](http://stackoverflow.com/a/31029960/5191100)
    var visibleSectionHeaders: [UITableViewHeaderFooterView] {
        get {
            var visibleSects = [UITableViewHeaderFooterView]()
            
            for sectionIndex in indexesOfVisibleSections() {
                if let sectionHeader = self.headerView(forSection: sectionIndex) {
                    visibleSects.append(sectionHeader)
                }
            }
            
            return visibleSects
        }
    }
    
    private func indexesOfVisibleSections() -> Array<Int> {
        // Note: We can't just use indexPathsForVisibleRows, since it won't return index paths for empty sections.
        var visibleSectionIndexes = Array<Int>()
        
        for i in 0..<self.numberOfSections {
            var headerRect: CGRect?
            // In plain style, the section headers are floating on the top,
            // so the section header is visible if any part of the section's rect is still visible.
            // In grouped style, the section headers are not floating,
            // so the section header is only visible if it's actual rect is visible.
            if (self.style == .plain) {
                headerRect = self.rect(forSection: i)
            } else {
                headerRect = self.rectForHeader(inSection: i)
            }
            
            if headerRect != nil {
                // The "visible part" of the tableView is based on the content offset and the tableView's size.
                let visiblePartOfTableView: CGRect = CGRect(
                    x: self.contentOffset.x,
                    y: self.contentOffset.y,
                    width: self.bounds.size.width,
                    height: self.bounds.size.height
                )
                
                if (visiblePartOfTableView.intersects(headerRect!)) {
                    visibleSectionIndexes.append(i)
                }
            }
        }
        
        return visibleSectionIndexes
    }
}




