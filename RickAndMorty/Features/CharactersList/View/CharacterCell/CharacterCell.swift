//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import UIKit
import SwiftUI


// will make a generic view that can take view
class CharacterCell: UITableViewCell {
    static let reuseIdentifier = "CharacterCell"
    
    private var hostingController: UIHostingController<CustomCharacterView>?
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(with character: CharacterPresentationModel) {
        // Remove existing hosting controller if any
        hostingController?.view.removeFromSuperview()
        
        let characterView = CustomCharacterView(character: character)
        let hostingController = UIHostingController(rootView: characterView)
        self.hostingController = hostingController
        
        // Add to contentView
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
