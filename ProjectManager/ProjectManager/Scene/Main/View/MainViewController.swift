//
//  ProjectManager - ViewController.swift
//  Created by brad, bard.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    private let mainViewModel = MainViewModel()

    private lazy var toDoListTableView = ProjectTableView(for: .todo)
    private lazy var doingListTableView = ProjectTableView(for: .doing)
    private lazy var doneListTableView = ProjectTableView(for: .done)
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Design.horizontalStackViewSpacing
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    
    // MARK: - Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupUI()
        binding()
        mainViewModel.binding()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        setupSubviews()
        setupVerticalStackViewLayout()
        setupView()
    }

    private func binding() {
        mainViewModel.todoSubscripting { [weak self] _ in
            self?.toDoListTableView.fetch()
            self?.toDoListTableView.reloadData()
            self?.toDoListTableView.setupIndexLabel()
        }
        
        mainViewModel.doingSubscripting { [weak self] _ in
            self?.doingListTableView.fetch()
            self?.doingListTableView.reloadData()
            self?.doingListTableView.setupIndexLabel()
        }
        
        mainViewModel.doneSubscripting { [weak self] _ in
            self?.doneListTableView.fetch()
            self?.doneListTableView.reloadData()
            self?.doneListTableView.setupIndexLabel()
        }
    }
    
    private func setupDelegates() {
        [toDoListTableView, doingListTableView, doneListTableView]
            .forEach { $0.presetDelegate = self }
    }
    
    private func setupSubviews() {
        view.addSubview(horizontalStackView)
        
        [toDoListTableView, doingListTableView, doneListTableView]
            .forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    private func setupVerticalStackViewLayout() {
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height
        else { return }
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -navigationBarHeight),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9490192533, green: 0.9490200877, blue: 0.9662286639, alpha: 1)
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.title = Design.navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Design.navigationTitleFontSize, weight: .bold)
        ]
        
        let leftBarButton = UIBarButtonItem(title: "history",
                                            style: .plain,
                                            target: self,
                                            action: #selector(didHistoryButtonTapped))
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: Design.plusImage),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didPlusButtonTapped))
  
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }

    // MARK: - objc Functions
    
    @objc private func didPlusButtonTapped() {

        let registrationViewController = RegistrationViewController()
        let navigationController = UINavigationController(rootViewController: registrationViewController)
        
        registrationViewController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
        
    @objc private func didHistoryButtonTapped() {
        
//        let tableViewController = HistoryViewController()
//        tableViewController.modalPresentationStyle = UIModalPresentationStyle.popover
//        // tableViewController.preferredContentSize = CGSize(width: 400, height: 400)
//        
//        tableViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
//        tableViewController.popoverPresentationController?.delegate = self
//        tableViewController.popoverPresentationController?.sourceView = self.view // button
//        tableViewController.popoverPresentationController?.sourceRect = self.view.bounds
//        
//        // present the popover
//        self.present(tableViewController, animated: true, completion: nil)
    }
    // MARK: - Name Space
    
    private enum Design {
        static let horizontalStackViewSpacing: CGFloat = 8
        static let navigationTitle = "Project Manager"
        static let navigationTitleFontSize: CGFloat = 20
        static let plusImage = "plus"
        static let longTapDuration: TimeInterval = 1.5
        static let todoAlertActionTitle = "Move to TODO"
        static let doingAlertActionTitle = "Move to DOING"
        static let doneAlertActionTitle = "Move to DONE"
        static let defaultRect = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
}

extension MainViewController: Presentable {
    func presentAlert(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func presentDetail(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
        
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.popover
    }
    
}
