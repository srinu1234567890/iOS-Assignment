

import UIKit

class ViewController: UIViewController {

    lazy var collectionView: UICollectionView! = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var layout: UICollectionViewLayout! = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { section, enviroment -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.3)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.4)), subitem: item, count: 3)
            group.interItemSpacing = .fixed(10)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        }, configuration: configuration)
        
        return layout
    }()
    
    var values = [WelcomeElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        callAPI()
    }


}

extension ViewController{
    
    func configureUI(){
        view.backgroundColor = .white
        addSubView()
    }
    
    func addSubView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
}

extension ViewController: UICollectionViewDelegate{
    
    func callAPI(){
        
        let urlRequest = URLRequest(url: URL(string: "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 45)
        Task {
            do{
                let (data, _) = try await URLSession.shared.data(for: urlRequest)
                values.append(contentsOf: try JSONDecoder().decode([WelcomeElement].self, from: data))
                collectionView.reloadData()
                
            }catch let error{
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
        cell.imageView.downloaded(from: values[indexPath.row].backupDetails?.screenshotURL ?? "", contentMode: .scaleAspectFit)
        cell.backgroundColor = .gray
        return cell
    }
    
}


