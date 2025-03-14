//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Mahmoud Elattar on 13/03/2025.
//
import UIKit

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
    
    private func setupTableView() {
        tableView.register(cellType: CharacterCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
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
        let cell = tableView.dequeueReusableCell(with: CharacterCell.self, for: indexPath)
        let character = characters[indexPath.row]
        let view = CustomCharacterView(character: character)
        cell.configure(with: view)
         // pagination
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
