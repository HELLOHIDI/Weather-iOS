//
//  MainViewController.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/23.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

import SnapKit
import Then

public final class MainViewController : UIViewController {
    
    //MARK: - Properties
    
    let rootView = MainView()
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    public override func loadView() {
        self.view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Custom Method
    
    
    
    //MARK: - Action Method
    
}
