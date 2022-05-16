//
//  Extension + NavigationBar.swift
//  ToDo Grad
//
//  Created by Konstantin on 16.05.2022.
//

import UIKit

extension UINavigationBar {
    
    public func setupNavigationBar() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .systemBlue
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.standardAppearance = coloredAppearance
        self.scrollEdgeAppearance = coloredAppearance

        self.tintColor = UIColor.white
        
    }
}
