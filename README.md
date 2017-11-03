# iCocosListGrid


//============================================梦工厂============================================//
// 微信：clpaial10201119(183**7821) / QQ：2211523682                                          
// github博文（如果你对iOS常用技术，基础，底层感兴趣请猛戳这里）：http://al1020119.github.io/                                           // github：https://github.com/al1020119                                                                                       
//============================================梦工厂============================================//
//

一种布局模式的切换（CollectionView&amp;TableView），支持单选，多选，全选，长按，编辑等操作


![image](https://github.com/al1020119/iCocosListGrid/001.png)

![image](https://github.com/al1020119/iCocosListGrid/blob/master/002.png)

![image](https://github.com/al1020119/iCocosListGrid/blob/master/003.png)

![image](https://github.com/al1020119/iCocosListGrid/blob/master/004.png)


## 模型数据


    import Foundation

    enum FileHanleType {
    case None
    }

    /// 模型数据
    class MainFileModel {
    var testName: String = ""
    var testDesc: String = ""
    var testIcon: String = ""

    var checked: Bool = false
    var handle: FileHanleType = .None
    }

## Cell与布局


    import UIKit

    /// Cell；列表数据
    class MainFileCell: UICollectionViewCell {

    var title = UILabel()       // 文件名
    var desc = UILabel()        // 文件描述
    var image = UIImageView()   // 文件图标
    var button = UIButton()     // 选择按钮
    var bottomLine = UIView()   //底部线条

    override init(frame: CGRect) {
    super.init(frame: frame)

    /// Cell初始化

    self.button.setImage(UIImage(named: "company_no_selected"), for: .normal)
    self.button.setImage(UIImage(named: "company_selected"), for: .selected)

    title.font = UIFont.systemFont(ofSize: 14)
    desc.font = UIFont.systemFont(ofSize: 12)

    desc.textColor = UIColor.gray
    bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

    button.isUserInteractionEnabled = false

    contentView.addSubview(title)
    contentView.addSubview(desc)
    contentView.addSubview(image)
    contentView.addSubview(button)
    contentView.addSubview(bottomLine)
    }

    override func layoutSubviews() {
    super.layoutSubviews()
    }

    /// 更新列表cell数据
    ///
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - listGridModel: 模型数据
    ///   - listGridType: 列表类型
    ///   - listGridSelected: 选择状态
    func updateCell(collectionView: UICollectionView, listGridModel: MainFileModel,listGridType: ListGridType, listGridSelected: ListGridSelected) {

    // 模型数据赋值与展示
    self.title.text = listGridModel.testName
    self.desc.text = listGridModel.testDesc
    self.image.image = UIImage(named:listGridModel.testIcon)

    // 根据列表类型和选中状态控制界面与显示效果
    button.isHidden = !(listGridSelected == .Selected)
    bottomLine.isHidden = listGridType == .Grid ? true : false
    title.textAlignment = listGridType == .Grid ? .center : .left
    desc.textAlignment = listGridType == .Grid ? .center : .left

    // 根据列表类型布局子控件
    if listGridType == .Grid {
    title.frame = CGRect(x: 10, y:self.frame.size.height - 45, width: self.frame.size.width - 20, height: 18)
    desc.frame = CGRect(x: 10, y:self.frame.size.height - 20, width: self.frame.size.width - 20, height: 14)
    image.frame = CGRect(x: (self.frame.size.width - 40) / 2, y: 20, width: 40, height: 40)
    button.frame = CGRect(x: image.frame.maxX - 10,y: 10, width: 20, height: 20)
    } else {
    // 由于是列表模式，最左侧是选择按钮，因此需要根据是否是选择模式，来控制左右选择按钮的位置和显示隐藏，并控制右边所有控件的位置（X）
    self.title.frame = CGRect(x: listGridSelected == .Selected ? 90 : 60, y: 8, width:self.frame.size.width - 80, height: 18)
    self.desc.frame = CGRect(x: listGridSelected == .Selected ? 90 : 60, y: 33, width:self.frame.size.width - 80, height: 12)
    self.image.frame = CGRect(x: listGridSelected == .Selected ? 40 : 10, y: 10, width: 40, height: 40)
    self.bottomLine.frame = CGRect(x: listGridSelected == .Selected ? 40 : 10, y: self.frame.size.height - 0.5, width: self.frame.size.width - ((listGridSelected == .Selected) ? 40 : 10), height: 0.5)
    self.button.frame = CGRect(x: listGridSelected == .Selected ? 10 : -20,y: 20, width: 20, height: 20)
    }

    }

    /// 选中按钮
    ///
    /// - Parameter checked: 选中状态
    func setSelectedItem(checked: Bool) {
    button.isSelected = checked
    self.setNeedsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    }


## 控制器代码逻辑




    import UIKit

    /// 主文件列表
    class MainFileController: UIViewController {

    var collectionView: UICollectionView!
    var listGridType: ListGridType = .List;             // 列表模式： Grid或List
    var listGridSelected: ListGridSelected = .Normal    // 选择状态：Normal或Selected
    var isAllSelected: Bool = false                     // 是否全选
    var dataArray = [MainFileModel]()                   // 模型数组数据
    var selectedArray = [MainFileModel]()               // 选中数组数据

    override func viewDidLoad() {
    super.viewDidLoad()

    // 初始化数据
    for _ in 0 ..< 100 {
    let model = MainFileModel()
    model.testName = "我的文件"
    model.testDesc = "文件描述信息与介绍..."
    model.testIcon = "folder"
    dataArray.append(model)
    }

    // 初始化CollectionView
    collectionViewInit()

    // 初始化其他子控件
    othersControlInit()
    }
    }

    // 初始化操作
    extension MainFileController {

    /// 初始化Collection
    func collectionViewInit(){
    let layout = ListGridLayout(delegate: self)
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    view.addSubview(collectionView)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.bounces = false
    collectionView.register(MainFileCell.self, forCellWithReuseIdentifier: "MainFileCell")
    }

    /// 初始化其他子控件
    func othersControlInit() {
    changeToSelectedTypeLayout()
    }

    }

    //=================================================================逻辑处理===========================================================================

    // 实际操作比变化： List Or Grid
    extension MainFileController: ListGridDataSource {

    // Item大小，根据列表模式控制
    func sizeOfItemAtIndexPath(at indexPath: IndexPath) -> CGSize {
    return listGridType == .List ? CGSize(width: collectionView.frame.size.width, height: 60) : CGSize(width: 80, height: 80)
    }

    // 列数
    func numberOfCols(at section: Int) -> Int {
    // iPad列数适配
    if UIDevice.current.userInterfaceIdiom == .pad && listGridType == .Grid {
    if (UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight) {
    return 8
    } else {
    return 6
    }
    }
    return listGridType.rawValue
    }

    // 间距
    func spaceOfCells(at section: Int) -> CGFloat{
    return listGridType == .List ? 0 : 20
    }

    // 内边距
    func sectionInsets(at section: Int) -> UIEdgeInsets {
    return listGridType == .List ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) : UIEdgeInsets(top: 10, left: 20, bottom: 15, right: 20)
    }
    }

    //=================================================================数据展示===========================================================================

    // 数据展示
    extension MainFileController: UICollectionViewDataSource{
    // 固定节数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
    }

    // 根据真实数据变化
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataArray.count
    }

    // 根据真实数据结合实际操作比变化： List Or Grid
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFileCell", for: indexPath) as! MainFileCell
    let model = dataArray[indexPath.row] as MainFileModel
    cell.updateCell(collectionView: collectionView, listGridModel: model, listGridType: listGridType, listGridSelected: listGridSelected)
    cell.tag = indexPath.row
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressCellToHandle(action:)))
    cell.addGestureRecognizer(longPress)
    self.cellChecked(cell: cell, row: indexPath.row, isChecked: false)
    return cell
    }

    }


    //===================================================================用户操作=========================================================================

    extension MainFileController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if listGridSelected == .Selected {
    let cell = collectionView.cellForItem(at: indexPath) as! MainFileCell
    let row = indexPath.row
    self.cellChecked(cell: cell, row: row, isChecked: true)

    /// 判断列表数据和选中数据是否相等，相等就全选，不相等就取消全选，
    /// 这里需要整理dataArray和selectArray对应数据进行处理

    } else {
    /// 根据对应的文件类型进行实际操作显示
    /// 视频，图片，PDF，文本，错误或者失败的文件
    }

    }
    }

    extension MainFileController {

    /// 选择控制处理
    ///
    /// - Parameters:
    ///   - cell: Cell
    ///   - row: 行
    ///   - isChecked: 是否选中
    func cellChecked(cell: MainFileCell, row: NSInteger, isChecked: Bool) {
    let model = dataArray[row] as MainFileModel
    model.checked = model.checked == false ? isChecked : !isChecked
    cell.setSelectedItem(checked: model.checked == false ? isChecked : !isChecked)
    }

    // 全选控制
    func allSelected() {
    isAllSelected = !isAllSelected
    for  model: MainFileModel  in dataArray {
    model.checked = isAllSelected
    }
    collectionView.reloadData()
    }


    /// 执行布局切换操作
    ///
    /// - Parameter sender: 布局模式按钮
    @objc func changeLayoutAction(sender: UIBarButtonItem) {
    listGridType = listGridType == .List ? .Grid : .List
    collectionView.reloadData()
    }


    /// 执行全选操作
    ///
    /// - Parameter sender: 全选按钮
    @objc func allSelectedAction(sender: UIBarButtonItem) {
    if sender.title == "全选" {
    sender.title = "全不选"
    isAllSelected = false
    self.allSelected()
    } else {
    sender.title = "全选"
    isAllSelected = true
    self.allSelected()
    }
    }

    /// 控制右上角Item按钮显示
    func changeToSelectedTypeLayout() {
    if listGridSelected == .Selected {
    let allSelItem = UIBarButtonItem(title: "全选", style: .plain, target: self, action: #selector(allSelectedAction(sender:)))
    let changeItem = UIBarButtonItem(title: "切换", style: .plain, target: self, action: #selector(changeLayoutAction(sender:)))
    self.navigationItem.rightBarButtonItems = [allSelItem, changeItem]
    } else {
    let changeItem = UIBarButtonItem(title: "切换", style: .plain, target: self, action: #selector(changeLayoutAction(sender:)))
    self.navigationItem.rightBarButtonItem = changeItem
    }
    }

    /// cell长按操作
    ///
    /// - Parameter action: UILongPressGestureRecognizer
    @objc func longPressCellToHandle(action: UILongPressGestureRecognizer) {
    if action.state == .began{
    // 获取长按的位置，取得对应的indexPath
    let point = action.location(in: collectionView)
    let indexPath = collectionView.indexPathForItem(at: point)
    // 选中当前长按对应的行
    if let indexPath = indexPath {
    let model = dataArray[indexPath.row] as MainFileModel
    model.checked = true
    }
    // 长按时判断已经是选择模式，如果是选择模式，长按就应该取消所有选中，并且控制右上角按钮，
    if listGridSelected == .Selected {
    for  model: MainFileModel  in dataArray {
    model.checked = false
    }
    } else {
    // 如果不是选中模式，判断是否只有一个，如果只有一个，则等于全部选中，并控制右上角按钮
    if dataArray.count == 1 {
    isAllSelected = false
    self.allSelected()
    return;
    }
    }
    listGridSelected = listGridSelected == .Normal ? .Selected : .Normal
    changeToSelectedTypeLayout()
    collectionView.reloadData()
    }
    }

    }






