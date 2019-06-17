//
//  MovieDetailVC.swift
//  movie-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 Patrick Ngo. All rights reserved.
//

import UIKit
import SnapKit
import ReSwift
import RxSwift
import RxCocoa

class MovieDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, StoreSubscriber {
    enum Section : Int {
        case header = 0
        case related
        case numberOfSections
    }
    
    typealias StoreSubscriberStateType = MovieDetailState
    
    let disposeBag = DisposeBag()
    
    private var selectedMovie: MovieModel? = nil {
        didSet {
            self.title = self.selectedMovie?.title
        }
    }
    private var movieList: [MovieModel] = []
    private var page = 0
    private var isLoading =  false
    private var hasNext = true
    
    //MARK: - Views -
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .plain)
        tv.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tv.separatorColor = UIColor.Border.around
        
        tv.delegate = self
        tv.dataSource = self
        
        // Cell registration
        tv.register(MovieDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: MovieDetailHeaderView.self))
        tv.register(MovieDetailSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: MovieDetailSectionHeaderView.self))
        tv.register(MovieListingsCell.self, forCellReuseIdentifier: String(describing: MovieListingsCell.self))
        tv.register(TableViewLoadingCell.self, forCellReuseIdentifier: String(describing: TableViewLoadingCell.self))
        
        // Cell size
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 80
        
        // Rx item selection
        tv.rx.itemSelected
            .map { self.movieList[$0.row] }
            .bind(onNext: { (movie) in
                // Update selected movie
                mainStore.dispatch(SetSelectedMovie(movie: movie))
                
                // Go to movie detail screen
                let movieDetailVC = MovieDetailVC()
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        return tv
    }()
    
    //MARK: - Init -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.setupViews()
        
        
        // subscribe to state changes
        mainStore.subscribe(self) { subcription in
            subcription.select { state in state.movieDetailState }
        }
        
        // Fetch related movies
        mainStore.dispatch(fetchRelatedMovies)
    }
    
    func setupNavBar() {
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.tintColor = .black
        navBar.barTintColor = .white
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = NSLocalizedString("TITLE_NOW_PLAYING", comment: "Now Playing")
    }
    
    func setupViews() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalToSuperview()
        }
    }
    
    //MARK: - State Updates -
    func newState(state: MovieDetailState) {
        if let selectedMovie = state.selectedMovie {
            self.selectedMovie = selectedMovie
        }
        
        if let relatedMovies = state.relatedMovies {
            self.movieList = relatedMovies
            
            // Reload table with new movies
            self.tableView.reloadData()
        }
    }
    
    //MARK: - TableView Datasource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.related.rawValue:
            return movieList.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.header.rawValue:
            return UITableViewCell(frame: CGRect.zero)
            
        case Section.related.rawValue:
            // Get movie cell
            let movieCell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListingsCell.self)) as? MovieListingsCell
            let movie = movieList[indexPath.row]
            movieCell?.movie = movie
            return movieCell!
        default:
            return UITableViewCell(frame: CGRect.zero)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.numberOfSections.rawValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Section.header.rawValue:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing:MovieDetailHeaderView.self)) as! MovieDetailHeaderView
            headerView.movie = self.selectedMovie
            return headerView
        case Section.related.rawValue:
            if movieList.count <= 0 {
                return UIView(frame: CGRect.zero)
            }
            let sectionheaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing:MovieDetailSectionHeaderView.self)) as! MovieDetailSectionHeaderView
            return sectionheaderView
        default:
            return UIView(frame: CGRect.zero)
        }
    }
}

