//
//  ViewController.swift
//  frimap
//
//  Created by 杉山航 on 2017/08/23.
//  Copyright © 2017年 杉山航. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate {
    
    //商品名を入れるための配列
    var goods_Array: [String] = ["PPAP", "I have a pen", "I have a apple", "Uh! Apple-Pen!", "I have a pen", "I have pineapple", "Uh! Pineapple-Pen!", "Apple-Pen, Pineapple-Pen", "Uh! Pen-Pineapple-Apple-Pen", "Pen-Pineapple-Apple-Pen"]
    //商品を表示するためのtableview
    @IBOutlet var goods_View: UITableView!
    //商品を探すサーチバー
    var goods_Search = UISearchBar()
    
    var i: Int = 0
    //検索結果配列
    var searchResult = [String]()
    
    let data: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        goods_View = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height))
        goods_View.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        goods_View.dataSource = self
        goods_View.delegate = self
        self.view.addSubview(goods_View)
        
        goods_Search = UISearchBar()
        goods_Search.delegate = self
        goods_Search.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:42)
        goods_Search.layer.position = CGPoint(x: self.view.bounds.width/2, y: 89)
        goods_Search.searchBarStyle = UISearchBarStyle.default
        goods_Search.showsSearchResultsButton = false
        goods_Search.placeholder = "検索"
        goods_Search.setValue("キャンセル", forKey: "_cancelButtonText")
        goods_Search.tintColor = UIColor.red
        
        goods_View.tableHeaderView = goods_Search
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goods_Search.text != "" {
            return searchResult.count
        } else {
            return goods_Array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        if goods_Search.text != "" {
            cell.textLabel!.text = "\(searchResult[indexPath.row])"
        } else {
            cell.textLabel!.text = "\(goods_Array[indexPath.row])"
        }
        
        return cell
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
        self.searchResult = goods_Array.filter{
            // 大文字と小文字を区別せずに検索
            $0.lowercased().contains(searchBar.text!.lowercased())
        }
        self.goods_View.reloadData()
    }
    
    // キャンセルボタンが押された時に呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        self.goods_View.reloadData()
    }
    
    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    
}

