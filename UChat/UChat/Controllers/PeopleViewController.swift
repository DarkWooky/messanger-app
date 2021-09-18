//
//  PeopleViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit

class PeopleViewController: UIViewController {

    let users = Bundle.main.decode([MUser].self, from: "users.json")

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<PeopleSection, MUser>?
    let searchController = UISearchController()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar(searchController)
        setupCollectionView()
        createDataSource()
        reloadData(with: nil)
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        view.addSubview(collectionView)

        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)

        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
    }

    private func reloadData(with searchText: String?) {
        let filtered = users.filter { (user) -> Bool in
            user.contains(filter: searchText)
        }
        searchController.searchBar.delegate = self

        var snapshot = NSDiffableDataSourceSnapshot<PeopleSection, MUser>()
        snapshot.appendSections([.users])
        snapshot.appendItems(filtered, toSection: .users)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Create DataSource

extension PeopleViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<PeopleSection, MUser>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            guard let section = PeopleSection(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .users:
                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: user, for: indexPath)
            }
        })

        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Cannot create new section header") }
            guard let section = PeopleSection(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            let items = self.dataSource?.snapshot().itemIdentifiers(inSection: .users)
            sectionHeader.configure(text: section.description(userCount: items!.count),
                font: .systemFont(ofSize: 36, weight: .light),
                textColor: .label)
            return sectionHeader
        }
    }
}

// MARK: - Create Compositional Layout
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

        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return sectionHeader
    }
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
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
