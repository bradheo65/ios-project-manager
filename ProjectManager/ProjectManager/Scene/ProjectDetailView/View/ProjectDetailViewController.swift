//
//  ProjectDetailViewController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import UIKit

final class ProjectDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let toDoComponentsView = ToDoComponentsView()
    private let projectDetailViewModel = ProjectDetailViewModel()
    private let tableView: UITableView
    
    private var selectedIndex: Int?
    private var selectedProjectType: ProjectType?
    private var isEditable: Bool = false
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Initializers
    
    init(with tableView: UITableView) {
        self.tableView = tableView
        
        super.init(nibName: nil, bundle: nil)
        guard let tableView = tableView as? ProjectTableView else { return }
        navigationItem.title = tableView.getTitle()
    }
    
    required init?(coder: NSCoder) {
        tableView = UITableView()
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
    func loadData(of item: ToDoItem) {
        toDoComponentsView.configure(of: item)
    }
    
    func sendData(of project: ProjectType, in row: Int) {
        selectedProjectType = project
        selectedIndex = row
    }
    
    private func setupUI() {
        setupNavigationController()
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        view.addSubview(toDoComponentsView)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Design.navigationTitleFontSize, weight: .bold)
        ]
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9488992095, green: 0.9492433667, blue: 0.9632378221, alpha: 1)
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                 target: self,
                                                 action: #selector(didDoneButtonTapped))
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                target: self,
                                                action: #selector(didEditButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            toDoComponentsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toDoComponentsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toDoComponentsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toDoComponentsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func dismissViewController() {
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - objc Functions
    
    @objc private func didEditButtonTapped() {
        if isEditable == false {
            toDoComponentsView.setupEditable(is: true)
            isEditable = true
        } else {
            toDoComponentsView.setupEditable(is: false)
            isEditable = false
        }
    }
    
    @objc private func didDoneButtonTapped() {
        projectDetailViewModel.update(item: toDoComponentsView.fetchItem(),
                                      from: selectedIndex ?? .zero,
                                      of: selectedProjectType ?? .todo)
        dismissViewController()
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let navigationTitleFontSize: CGFloat = 20
    }
}
