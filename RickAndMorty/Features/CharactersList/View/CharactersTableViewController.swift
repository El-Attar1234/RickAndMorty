//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import UIKit
import SwiftUI

struct CharactersTableViewRepresentable<ViewModel: CharactersViewModel>: UIViewControllerRepresentable {
    @ObservedObject var viewModel: ViewModel
    
    func makeUIViewController(context: Context) -> CharactersTableViewController<ViewModel> {
        let controller = CharactersTableViewController(viewModel: viewModel)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CharactersTableViewController<ViewModel>, context: Context) {
        uiViewController.update(with: viewModel)
    }
}

// UITableViewController
class CharactersTableViewController<ViewModel: CharactersViewModel>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private let viewModel: ViewModel
    private var characters: [CharacterPresentationModel] = []
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureLayout()
    }
    //TODO: - use my old extensions
    private func setupTableView() {
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        // ali
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func configureLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func update(with viewModel: ViewModel) {
        characters = viewModel.characters
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
        

        
        // Load more when reaching the last 5 items
        if indexPath.row == characters.count - 5 {
            viewModel.loadMoreCharacters()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Will navigate to character details")
    }
}

//extension CharactersTableViewController: UITableViewDataSource {
//   
//}
////
//extension CharactersTableViewController: UITableViewDelegate {
//    
//}





//
//// Custom Cell
//class CharacterCell: UITableViewCell {
//    static let reuseIdentifier = "CharacterCell"
//    
//    private let nameLabel = UILabel()
//    private let speciesLabel = UILabel()
//    private let characterImageView = UIImageView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        characterImageView.contentMode = .scaleAspectFit
//        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
//        speciesLabel.font = .systemFont(ofSize: 14)
//        
//        let stackView = UIStackView(arrangedSubviews: [nameLabel, speciesLabel])
//        stackView.axis = .vertical
//        stackView.spacing = 4
//        
//        [characterImageView, stackView].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview($0)
//        }
//        
//        NSLayoutConstraint.activate([
//            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            characterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            characterImageView.widthAnchor.constraint(equalToConstant: 60),
//            characterImageView.heightAnchor.constraint(equalToConstant: 60),
//            
//            stackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ])
//    }
//    
//    func configure(with character: CharacterPresentationModel) {
//        nameLabel.text = character.name
//        speciesLabel.text = character.species
//        // Note: You'll need to add image loading logic here
//        // For example, using your network layer to fetch the image from character.image URL
//    }
//}
