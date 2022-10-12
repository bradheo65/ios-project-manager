//
//  ProjectTableHeaderView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/13.
//

import UIKit

final class ProjectTableHeaderView: UIView {
   
    // MARK: - Properties
    private let projectTableHearderViewModel = ProjectTableHeaderViewModel()
    private var projectType: ProjectType = .todo
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title3)
        label.backgroundColor = .black
        
        return label
    }()
    
    // MARK: - Initializers
    
    init(with project: ProjectType) {
        super.init(frame: .zero)
        projectType = project
        titleLabel.text = projectType.titleLabel
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViewComponents()
        setupSubviews()
        setupConstraints()
        setupDrawIndexLabel()
    }
    
    // MARK: - Functions
    
    func setupIndexLabel() {
        projectTableHearderViewModel.fetch()
        indexLabel.text = projectTableHearderViewModel.count(of: projectType).description
    }
    
    private func setupViewComponents() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
    }
    
    private func setupSubviews() {
        [titleLabel, indexLabel]
            .forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            indexLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            indexLabel.widthAnchor.constraint(equalTo: indexLabel.heightAnchor)
        ])
    }
    
    private func setupDrawIndexLabel() {
        indexLabel.layoutIfNeeded()
        indexLabel.drawCircle()
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let verticalStackViewSpacing: CGFloat = 2
        static let todotitleLabelText = "TODO"
        static let doingtitleLabelText = "DOING"
        static let donetitleLabelText = "DONE"
    }
}
