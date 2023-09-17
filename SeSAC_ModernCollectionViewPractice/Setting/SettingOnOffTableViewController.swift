//
//  SettingOnOffTableViewController.swift
//  SeSAC_ModernCollectionViewPractice
//
//  Created by 문정호 on 2023/09/18.
//

import UIKit
import SnapKit

class SettingOnOffTableViewController: UIViewController{
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    let setting = [SettingOnOff(image: "moon.fill",title: "방해금지 모드", onOff: true), SettingOnOff(image: "bed.double.fill",title: "수면", onOff: nil), SettingOnOff(image: "iphone.gen2",title: "업무", onOff: nil), SettingOnOff(image: "person.fill",title: "개인시간", onOff: false)]
    let share = [SettingOnOff(image: "",title: "모든 기기에서 공유", onOff: true)]
    
    var dataSource: UICollectionViewDiffableDataSource<Int, SettingOnOff>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "집중 모드"
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.backgroundColor = .white
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, SettingOnOff>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(setting, toSection: 0) // toSection: 해당 섹션에 해당 아이템을 넣겠다.
        snapshot.appendItems(share, toSection: 1)
        
        dataSource.apply(snapshot)
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SettingOnOff> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.image = UIImage(systemName: itemIdentifier.image)
            content.secondaryText = (itemIdentifier.onOff ?? false) ? "켬":"끔"
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using:cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }

}
