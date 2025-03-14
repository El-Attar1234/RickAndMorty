//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import SwiftUI

class CharacterCell: UITableViewCell {
    
    private var hostingController: UIHostingController<CustomCharacterView>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(with view: CustomCharacterView) {
        // Remove existing hosting controller if any
        hostingController?.view.removeFromSuperview()
        
        let hostingController = UIHostingController(rootView: view)
        self.hostingController = hostingController
        
        if let hostingView = hostingController.view {
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(hostingView)
            
            // Set up constraints
            NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
