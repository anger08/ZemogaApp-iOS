//
//  PostsHomeViewController.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit

protocol PostsHomeDisplayLogic: AnyObject {
    func displayPosts(viewModel: PostsHomeModel.Posts.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue)
}

class PostsHomeViewController: BaseViewController {
    
    @IBOutlet weak var optionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var postsHomeTableView: UITableView!
    @IBOutlet weak var favoritePostsTableView: UITableView!
    @IBOutlet weak var deleteAllButton: UIButton!
    
    let cellPostsNibName = "PostsHomeTableViewCell"
    let cellfavoritePostsNibName = "FavoritePostsTableViewCell"
    
    var posts : [PostsHomeModel.Posts.Response] = []
    var postsFavorites: PostsHomeModel.Posts.Response?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: PostsHomeBusinessLogic?
    var router: (NSObjectProtocol & PostsHomeRoutingLogic & PostsHomeDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = PostsHomeInteractor()
        let presenter = PostsHomePresenter()
        let router = PostsHomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsNavBar(image: "reload")
        loadInitialData()
        settingTableView()
        reloadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // PostsSelected
        postsHomeTableView.reloadData()

        if posts.count > 0 {
            for i in posts.indices {
                ZASettings.current.postSelected?.forEach({ j in
                    if posts[i].id == j.id {
                        posts[i].isSelected = true
                    }
                })
            }

            postsHomeTableView.reloadData()
        }
        
        if posts.count > 0 {
            for i in posts.indices {
                ZASettings.current.postFavorite?.forEach({ j in
                    if posts[i].id == j.id {
                        posts[i].isFavorite = true
                    }
                })
            }
            posts = posts.sorted { $0.isFavorite && !$1.isFavorite }
            postsHomeTableView.reloadData()
        }
    }
    
// MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        refresher.endRefreshing()
        let request = PostsHomeModel.Posts.Request()
        interactor?.getPosts(request: request)
    }
    
    private func settingTableView() {
        postsHomeTableView.register(UINib(nibName: cellPostsNibName, bundle: nil), forCellReuseIdentifier: PostsHomeTableViewCell.reuseIdentifier)
        postsHomeTableView.delegate = self
        postsHomeTableView.dataSource = self
        postsHomeTableView.refreshControl = refresher
        
        favoritePostsTableView.register(UINib(nibName: cellfavoritePostsNibName, bundle: nil), forCellReuseIdentifier: FavoritePostsTableViewCell.reuseIdentifier)
        favoritePostsTableView.delegate = self
        favoritePostsTableView.dataSource = self
        favoritePostsTableView.refreshControl = refresher
    }
    
    func reloadPosts() {
        userButton.tapAction = {
            self.loadInitialData()
        }
    }
    
// MARK: - Actions
    @IBAction func segmentedOnClick(_ sender: Any) {
        if optionsSegmentedControl.selectedSegmentIndex == 0 {
            if posts.count > 0 {
                posts = posts.sorted { $0.isFavorite && !$1.isFavorite }
                postsHomeTableView.reloadData()
                favoritePostsTableView.isHidden = true
                postsHomeTableView.isHidden = false
            }
        } else if optionsSegmentedControl.selectedSegmentIndex == 1 {
            favoritePostsTableView.isHidden = false
            postsHomeTableView.isHidden = true
            favoritePostsTableView.reloadData()
        }
    }
    
    @IBAction func DeleteAllOnClick(_ sender: Any) {
        if optionsSegmentedControl.selectedSegmentIndex == 0 {
            posts.removeAll()
            ZASettings.current.postFavorite?.removeAll()
            postsHomeTableView.reloadData()
        } else if optionsSegmentedControl.selectedSegmentIndex == 1 {
            ZASettings.current.postFavorite?.removeAll()
            for i in posts.indices {
                posts[i].isFavorite = false
            }
            favoritePostsTableView.reloadData()
        }
        
    }
    
    func deleteFavorite(idFavorite: Int){
        for i in posts.indices{
            if posts[i].id == idFavorite {
                posts[i].isFavorite = false
                posts[i].isSelected = false
            }
        }
    }
}

// MARK: - PostsHomeDisplayLogic
extension PostsHomeViewController: PostsHomeDisplayLogic {
    func displayPosts(viewModel: PostsHomeModel.Posts.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        if viewModel.data.count > 0 {
            posts = viewModel.data
            postsHomeTableView.reloadData()
        }
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PostsHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == postsHomeTableView {
            return posts.count
        } else if tableView == favoritePostsTableView {
            return ZASettings.current.postFavorite?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == postsHomeTableView {
            guard let cell = postsHomeTableView.dequeueReusableCell(withIdentifier: PostsHomeTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? PostsHomeTableViewCell else {
                                                            fatalError()
            }
            
            let postsCell = posts[indexPath.row]
            cell.configUI(posts: postsCell, state: true)
            
            return cell
            
        } else if tableView == favoritePostsTableView {
            guard let cell = favoritePostsTableView.dequeueReusableCell(withIdentifier: FavoritePostsTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FavoritePostsTableViewCell else {
                                                            fatalError()
            }
            
            if let postsCell = ZASettings.current.postFavorite?[indexPath.row] {
                cell.configUI(posts: postsCell, state: true, favorite: postsCell.isFavorite)
            }
            
            return cell
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtrl = PostsDetailsViewController()
        viewCtrl.dataDescription = posts[indexPath.row]
        posts[indexPath.row].isSelected = true
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == postsHomeTableView {
            if editingStyle == .delete {
                posts.remove(at: indexPath.row)
                postsHomeTableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if tableView == favoritePostsTableView {
            if editingStyle == .delete {
                if let idFavorite = ZASettings.current.postFavorite?[indexPath.row].id {
                    deleteFavorite(idFavorite: idFavorite)
                }
                ZASettings.current.postFavorite?.remove(at: indexPath.row)
                favoritePostsTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }
}
