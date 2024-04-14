//
//  ViewController.swift
//  2nd_homework_KimHyeongi
//
//  Created by 김현기 on 3/31/24.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setTabBar()
    }

    private func setTabBar() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let comingSoon = UINavigationController(rootViewController: ComingSoonViewController())
        let downloads = UINavigationController(rootViewController: DownloadsViewController())
        let more = UINavigationController(rootViewController: MoreViewController())

        viewControllers = [home, search, comingSoon, downloads, more]
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .systemBackground

        home.tabBarItem.image = UIImage(named: "tab_home")
        home.title = "Home"
        search.tabBarItem.image = UIImage(named: "tab_search")
        search.title = "Search"
        comingSoon.tabBarItem.image = UIImage(named: "tab_comingsoon")
        comingSoon.title = "Coming Soon"
        downloads.tabBarItem.image = UIImage(named: "tab_downloads")
        downloads.title = "Downloads"
        more.tabBarItem.image = UIImage(named: "tab_more")
        more.title = "More"
    }

}
