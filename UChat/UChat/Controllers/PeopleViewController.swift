//
//  PeopleViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 3.09.21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import SDWebImage

class PeopleViewController: UIViewController {

    var users = [MUser]()
    private var usersListener: ListenerRegistration?

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<PeopleSection, MUser>?
    let searchController = UISearchController()
    
    let personButton: UIButton = {
        let button = UIButton(type: .system)
        let personImage = UIImage(systemName: "person.circle.fill")
        button.setImage(personImage, for: .normal)
        button.tintColor = UIColor(named: "projectColor")
        return button
    }()

    private let currentUser: MUser

    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        title = currentUser.username
    }

    deinit {
        usersListener?.remove()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar(searchController)
        setupCollectionView()
        createDataSource()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(signOut))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: personButton)
        personButton.addTarget(self, action: #selector(personButtonTapped), for: .touchUpInside)

        usersListener = ListenerService.shared.userObserver(users: users, completion: { result in
            switch result {
            case .success(let users):
                self.users = users
                self.reloadData(with: nil)
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        })
    }
    
    @objc private func personButtonTapped() {
        present(SettingsViewController(currentUser: currentUser), animated: true, completion: nil)
    }

    @objc private func signOut() {
        let ac = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = AuthViewController()
            } catch {
                print("Error signing out: \(error.localizedDescription) ")
            }
        }))
        present(ac, animated: true, completion: nil)
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        view.addSubview(collectionView)

        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)

        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)

        collectionView.delegate = self
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

// MARK: - UISearchBarDelegate

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
    }
}

// MARK: - UICollectionViewDelegate

extension PeopleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        let profileVC = ProfileViewController(user: user)
        present(profileVC, animated: true, completion: nil)
    }
}

