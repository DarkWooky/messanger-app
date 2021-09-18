//
//  ListViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit

// MARK: - ListViewController

class ListViewController: UIViewController {
    // MARK: Internal

    let activeChats = Bundle.main.decode([MChat].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([MChat].self, from: "waitingChats.json")

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<ListSection, MChat>?
    var searchBarDelegate: UISearchBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        //setupSearchBar(searchBarDelegate)
        setupCollectionView()
        createDataSource()
        reloadData()
    }

    // MARK: Private

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        view.addSubview(collectionView)

        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)

        collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
        collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.reuseId)
    }

    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, MChat>()
        snapshot.appendSections([.waitingChats, .activeChats])

        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Data Source

extension ListViewController {

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ListSection, MChat>(collectionView: collectionView, cellProvider: { collectionView, indexPath, chat in
            guard let section = ListSection(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .activeChats:
                return self.configure(collectionView: collectionView, cellType: ActiveChatCell.self, with: chat, for: indexPath)
            case .waitingChats:
                return self.configure(collectionView: collectionView, cellType: WaitingChatCell.self, with: chat, for: indexPath)
            }
        })

        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
                fatalError("Can not create new section header") }
            guard let section = ListSection(rawValue: indexPath.section) else {
                fatalError("Unknown section kind") }
            sectionHeader.configure(text: section.description(),
                font: .helvetica20(),
                textColor: #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1))
            return sectionHeader
        }
    }
}

// MARK: - Setup layout

extension ListViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let section = ListSection(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .activeChats:
                return self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    private func createWaitingChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80),
            heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 32)
        section.orthogonalScrollingBehavior = .continuous

        let sectionHeader = createSectionHeader()
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(95))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let sectionHeader = createSectionHeader()
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
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


// MARK: UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ListVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {

        let tabBarVC = MainTabBarController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }

        func updateUIViewController(_ uiViewController: ListVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListVCProvider.ContainerView>) {

        }
    }
}
