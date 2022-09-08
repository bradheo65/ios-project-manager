//
//  ToDoListViewController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/06.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    // MARK: - Properties
        
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "TODO"
        uiLabel.font = .preferredFont(forTextStyle: .title1)
        
        return uiLabel
    }()
    
    private let indexLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "0"
        uiLabel.textAlignment = .center
        uiLabel.textColor = .white
        uiLabel.font = .preferredFont(forTextStyle: .title3)
        uiLabel.backgroundColor = .black
        
        return uiLabel
    }()
    
    private let todoItemTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: ToDoListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItemTableView.delegate = self
        setupSubviews()
        setupListTableViewLayout()
        indexLabel.layoutIfNeeded()
        indexLabel.drawCircle()
    }
    
    // MARK: - Functions

    private func setupSubviews() {
        view.addSubview(verticalStackView)
        
        [titleLabel, indexLabel]
            .forEach { horizontalView.addSubview($0) }
        
        [horizontalView, todoItemTableView]
            .forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    private func setupListTableViewLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: horizontalView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            indexLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            indexLabel.widthAnchor.constraint(equalTo: indexLabel.heightAnchor)
        ])
    }
}

// MARK: - Extentions

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.identifier, for: indexPath) as? ToDoListTableViewCell
        else { return UITableViewCell() }
                
        return cell
    }
}

extension UILabel {
    func drawCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        print("drawCicle: \(self.frame.width)")
    }
}
