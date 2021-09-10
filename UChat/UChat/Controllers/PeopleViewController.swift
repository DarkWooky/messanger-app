//
//  PeopleViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit

class PeopleViewController: UIViewController {

    let users = Bundle.main.decode([User].self, from: "users.json")

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<PeopleSection, User>?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        reloadData()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.7450980392, green: 0.2196078431, blue: 0.9529411765, alpha: 1), endColor: #colorLiteral(red: 0.1137254902, green: 0, blue: 0.862745098, alpha: 1))

        view.addSubview(collectionView)

        //collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
    }

    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainColor")
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<PeopleSection, User>()
        snapshot.appendSections([.users])
        snapshot.appendItems(users, toSection: .users)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension PeopleViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<PeopleSection, User>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            guard let section = PeopleSection(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .users:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
                cell.backgroundColor = .yellow
                return cell
            }
        })
    }
}

extension PeopleViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let section = PeopleSection(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .users:
                return self.createUsersSection()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createUsersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 15, bottom: 0, trailing: 15)
        
//        let sectionHeader = createSectionHeader()
//        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}



extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

import SwiftUI

// MARK: - AuthVCProvider

struct PeopleVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let tabBarVC = MainTabBarController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }

        func updateUIViewController(_ uiViewController: PeopleVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PeopleVCProvider.ContainerView>) { }
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
