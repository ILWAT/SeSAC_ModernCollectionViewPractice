//
//  ViewController.swift
//  SeSAC_ModernCollectionViewPractice
//
//  Created by 문정호 on 2023/09/18.
//

import UIKit
import SnapKit

class SettingTableViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
//    let settingGeneral = ["공지사항", "실험실", "버전정보"]
//    let settingPersonal = ["개인/보안", "알림", "채팅", "멀티프로필"]
//    let settingEtc = ["고객센터/도움말"]
    
    let settingGeneral = [Setting(name: "공지사항", settingType: .general), Setting(name: "실험실", settingType: .personal), Setting(name: "버전정보", settingType: .general)]
    let settingPersonal = [Setting(name: "개인/보안", settingType: .personal), Setting(name: "알림", settingType: .personal), Setting(name: "채팅", settingType: .personal), Setting(name: "멀티프로필", settingType: .personal)]
    let settingEtc = [Setting(name: "고객센터/도움말", settingType: .etc)]
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Setting>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.backgroundColor = .white
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Setting>()
        snapshot.appendSections([0, 1, 2])
        snapshot.appendItems(settingGeneral, toSection: 0) // toSection: 해당 섹션에 해당 아이템을 넣겠다.
        snapshot.appendItems(settingPersonal, toSection: 1)
        snapshot.appendItems(settingEtc, toSection: 2)
        
        dataSource.apply(snapshot)
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Setting> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using:cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
}

