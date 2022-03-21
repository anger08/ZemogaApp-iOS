//
//  PostsDetailsViewController.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit

protocol PostsDetailsDisplayLogic: AnyObject {
    func displayUsers(viewModel: PostsDetailsModel.Users.ViewModel, on queu: DispatchQueue)
    func displayComments(viewModel: PostsDetailsModel.Comments.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue)
}

class PostsDetailsViewController: BaseViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userWebsiteLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    let cellCommentsNibName = "CommentsTableViewCell"
    
    var dataDescription: PostsHomeModel.Posts.Response?
    var dataUser: [PostsDetailsModel.Users.Response]?
    var dataComments: [PostsDetailsModel.Comments.Response]?
    var userId: Int?
    var index: Int = 0
    
    var postsFavorites = [PostsHomeModel.Posts.Response]()
    var posts = [PostsHomeModel.Posts.Response]()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: PostsDetailsBusinessLogic?
    var router: (NSObjectProtocol & PostsDetailsRoutingLogic & PostsDetailsDataPassing)?

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
        let interactor = PostsDetailsInteractor()
        let presenter = PostsDetailsPresenter()
        let router = PostsDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        settingsNavBar(image: "favoriteBorder")
        loadInitialData()
        addFavorite()
        settingTableView()
        
        if ZASettings.current.postFavorite?.count ?? 0 > 0 {
            ZASettings.current.postFavorite?.forEach({ i in
                if dataDescription?.id == i.id {
                    settingsNavBar(image: "favoriteFilled")
                }
            })
        }
    }
    
// MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        
        let request = PostsDetailsModel.Users.Request()
        interactor?.getUsers(request: request)
    }
    
    func getComments() {
        let request = PostsDetailsModel.Comments.Request()
        interactor?.getComments(request: request)
    }
    
    func addFavorite() {
        userButton.tapAction = {
//            var isFound = false
//            if ZASettings.current.postFavorite?.count != 0 {
//                ZASettings.current.postFavorite?.forEach({ i in
//                    if i.id == self.dataDescription?.id {
//                        isFound = true
//                    }
//                })
//            }
            
//            if isFound {
//                Helper.presentFavoriteModal(vc: self, name: "Delete Favorite") {
//                    self.settingsNavBar(image: "favoriteBorder")
//                    self.dataDescription?.isFavorite = false
//                    ZASettings.current.postFavorite?.forEach({ i in
//                        if i.id == self.dataDescription?.id {
//                            ZASettings.current.postFavorite?.remove(at: self.index)
//                        }
//                        self.index += 1
//                    })
//                } completationCancel: {
//                    print("Cancel")
//                }
//            } else {
                Helper.presentFavoriteModal(vc: self, name: "Add to Favorites") {
                    self.settingsNavBar(image: "favoriteFilled")
                    self.dataDescription?.isFavorite = true
                    ZASettings.current.postFavorite?.append(self.dataDescription!)
                } completationCancel: {
                    print("Cancel")
                }
//            }
        }
    }
    
    private func settingTableView() {
        commentsTableView.register(UINib(nibName: cellCommentsNibName, bundle: nil), forCellReuseIdentifier: CommentsTableViewCell.reuseIdentifier)
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.refreshControl = refresher
    }
}

// MARK: - PostsDetailsDisplayLogic
extension PostsDetailsViewController: PostsDetailsDisplayLogic {
    func displayUsers(viewModel: PostsDetailsModel.Users.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        if viewModel.data.count > 0 {
            dataUser = viewModel.data
            descriptionLabel.text = dataDescription?.body
            userId = dataDescription?.userId
            
            dataUser?.forEach({ i in
                if userId == i.id {
                    userNameLabel.text = i.name
                    userEmailLabel.text = i.email
                    userPhoneLabel.text = i.phone
                    userWebsiteLabel.text = i.website
                    getComments()
                }
            })
        }
    }
    
    func displayComments(viewModel: PostsDetailsModel.Comments.ViewModel, on queu: DispatchQueue) {
        dataComments = viewModel.data.filter { $0.postId == dataDescription?.id }
        commentsTableView.reloadData()
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PostsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataComments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = commentsTableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CommentsTableViewCell else {
                                                        fatalError()
        }
        
        if let comments = dataComments?[indexPath.row] {
            cell.configUI(comments: comments)
        }
        
        return cell
    }
}
