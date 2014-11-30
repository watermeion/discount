//
//  SRWantOfferARewardViewController.m
//  DaZhe
//
//  Created by Mac on 11/9/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "SRWantOfferARewardViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SRLoginVC.h"
#import "CommonMacro.h"
@interface SRWantOfferARewardViewController ()
{
    BOOL isFullScreen;
}
@end

@implementation SRWantOfferARewardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//拉去自己的酷币信息和城市信息

-(void)querySelfKubeFee
{
    AVUser *usr=[AVUser currentUser];
    if (usr==nil) {
        
        self.alert.tag=00000;
        self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"您好,您还未登陆，现在就是登陆？" delegate:self cancelButtonTitle:@"等会去" otherButtonTitles:@"马上去",nil];
        self.alert.tag=10001;
        [self.alert show];
    }
    else
    {
        AVQuery *query=[AVQuery queryWithClassName:@"_User"];
        query.cachePolicy=kPFCachePolicyNetworkElseCache;
        [query whereKey:@"objectId" equalTo:usr.objectId];
        [query selectKeys:@[@"kubiFee"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error==nil && [objects count]==1) {
                //没有错误刷新
                    AVObject *obj=[objects firstObject];
                    usrKubeFee=[obj objectForKey:@"kubiFee"];
                    //刷新列表
                    self.personKube.text=NSStringFromNumber( usrKubeFee);
                
            }
            else
            {
                [self.alert dismissWithClickedButtonIndex:0 animated:YES];
                self.alert=nil;
                self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"个人酷币拉取失败" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                [self.alert show];
                self.view.hidden=YES;
            
            }
        }];
    }
}

-(void)queryCityDistrictDataFromAVOS
{
    AVQuery *query=[AVQuery queryWithClassName:@"CityDiscrict"];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==nil)
        {
            if (cityAndZoneDict==nil) {
                cityAndZoneDict=[[NSMutableDictionary alloc]initWithCapacity:0];
            }
            for (AVObject *obj in objects) {
                NSString *cityName=[obj objectForKey:@"City"];
                NSArray *districtArray=[obj objectForKey:@"District"];
                [cityAndZoneDict setObject:districtArray forKey:cityName];
            }
            [self.alert dismissWithClickedButtonIndex:0 animated:YES];
            pickViewDataArray=[[NSArray alloc]initWithObjects:@"美食",@"住宿",@"娱乐",@"其他",nil];
            
            [self querySelfKubeFee];
        }
        else
        {
            [self.alert dismissWithClickedButtonIndex:0 animated:YES];
            self.alert=nil;
            self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"网络错误" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [self.alert show];
            self.view.hidden=YES;
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10001) {
        
        if (buttonIndex==0) {
            
        }else if (buttonIndex==1)
        {
            SRLoginVC *loginVC=[SRLoginVC shareLoginVC];
            [self presentViewController:loginVC animated:YES completion:^{
                nil;
            }];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            alertView.tag=11111;
        }
        
    }
    else{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (DEVICE_IS_IPHONE4){
        self.view.frame=CGRectMake(0, 0, 320, 376);
        self.submmitButon.center=CGPointMake(self.submmitButon.center.x, self.submmitButon.center.y-88);
        self.pickViewer.center=CGPointMake(self.pickViewer.center.x, self.pickViewer.center.y-88);
    }
    
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.scrollEnabled=YES;
    self.scrollView.contentSize=CGSizeMake(320, 630);
    submitRewardObject=[[Reward alloc]init];
//    self.submmitButon.enabled=NO;
    if (pickViewDataArray==nil) {
        self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"正在拉去位置数据" delegate:self cancelButtonTitle:nil otherButtonTitles:nil ];
        [self.alert show];
        [self queryCityDistrictDataFromAVOS];
        //拉去个人酷币信息
        
    }
    [self registKeyBoardNotification];
    //设置选择文本的输入View
    self.chooseCity.tag=10001;
    self.chooseCity.inputView=self.pickViewer;
    self.chooseCity.inputAccessoryView=self.pickViewToolBar;
    
    self.chooseType.tag=10000;
    self.chooseType.inputView=self.pickViewer;
    self.chooseType.inputAccessoryView=self.pickViewToolBar;
    
    self.chooseZone.tag=10002;
    self.chooseZone.inputView=self.pickViewer;
    self.chooseZone.inputAccessoryView=self.pickViewToolBar;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.hidden=NO;
    
}

- (void)viewWillLayoutSubviews{
    self.navigationItem.title=@"我要悬赏";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
}


- (void)ViewGone:(UIView *)senderView
{
    if (senderView.hidden == NO) {
        senderView.hidden = YES;
        //获取源控件的View
        NSInteger targetY = senderView.frame.origin.y;
        NSInteger targetHeightY = senderView.frame.origin.y+senderView.frame.size.height+10;
        
        BOOL isHidden = senderView.hidden;
        if (isHidden) {
            for (UIView *view in self.scrollView.subviews) {
                NSInteger tempY = view.frame.origin.y;
                //如果遇到view的Y坐标等于目标的Y坐标，且不为hidden的话，则暂停，恐会覆盖调
                if(tempY == targetY && !view.hidden){
                    break;
                }
                if (tempY >= targetHeightY ) {
                    if ([view isMemberOfClass:[UIImageView class]]) {
                        continue;
                    }
                    //上移到目标位置，达到隐藏的效果
                    CGRect tmpFrame = CGRectMake(view.frame.origin.x, view.frame.origin.y-senderView.frame.size.height-10, view.frame.size.width, view.frame.size.height);
                    view.frame = tmpFrame;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickViewTag) {
        case 0:
            self.chooseType.text=[pickViewDataArray objectAtIndex:row];
            break;
        case 1:
            self.chooseCity.text=[pickViewDataArray objectAtIndex:row];
            break;
        case 2:
            self.chooseZone.text=[pickViewDataArray objectAtIndex:row];
            break;
        default:
            break;
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickViewDataArray count];
   
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickViewDataArray objectAtIndex:row];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    return YES;
}
-(void)textDidChange:(id<UITextInput>)textInput
{
}

-(void)textWillChange:(id<UITextInput>)textInput
{
}


-(void)selectionDidChange:(id<UITextInput>)textInput
{

}

-(void)selectionWillChange:(id<UITextInput>)textInput
{
    
}




-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTextField=textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    activeTextField=nil;
}



-(void)registKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWasDown:) name:UIKeyboardDidHideNotification  object:nil];
}



-(void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //the key for an NSValue object containing a CGRect that identifies the start frame of the keyboard in screen coordinates. These coordinates do not take into account any rotation factors applied to the window’s contents as a result of interface orientation changes. Thus, you may need to convert the rectangle to window coordinates (using the convertRect:fromWindow: method) or to view coordinates (using the convertRect:fromView: method) before using it.
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
     self.scrollView.scrollIndicatorInsets = contentInsets;
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint scrollPoint = CGPointMake(0.0, self.rewardWordText.frame.origin.y-kbSize.height);
        [ self.scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)keyboardWasDown:(NSNotification*)aNotification
{
//    NSDictionary* info = [aNotification userInfo];
//    
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    CGRect bkgndRect = self.rewardWordText.superview.frame;
//    bkgndRect.size.height += kbSize.height;
//    
//    [self.rewardWordText.superview setFrame:bkgndRect];
//    
//    [self.scrollView setContentOffset:CGPointMake(0.0, self.rewardWordText.frame.origin.y-kbSize.height) animated:YES];
}

//数据完整性校验
- (IBAction)submitBtnAction:(id)sender {
    
    AVUser *usr=[AVUser currentUser];
    if (usr==nil) {
        self.alert.tag=00000;
        self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"您好,您还未登陆，现在就是登陆？" delegate:self cancelButtonTitle:@"等会去" otherButtonTitles:@"马上去",nil];
        self.alert.tag=10001;
        [self.alert show];
    }
    else
    {
    Reward *saveObj=[Reward object];
        saveObj.rewardUserAccount=[usr objectForKey:@"username"];
//        saveObj.rewardUserLogo=[usr objectForKey:@"userLogo"];
    saveObj.rewardAverage=[NSNumber numberWithInt:[self.rewardAverageText.text intValue]];
    saveObj.rewardFee=[NSNumber numberWithInt:[self.rewardMoney.text intValue]];
    NSString *LocationString=self.chooseCity.text;
    saveObj.rewardShopLocationDescri=[LocationString stringByAppendingString:self.chooseZone.text];
    saveObj.rewardShopType=self.chooseType.text;
    saveObj.rewardContent=self.rewardWordText.text;
    saveObj.rewardShopName=self.rewardShopName.text;
    saveObj.rewardTitle=self.rewardTitle.text;
    if (imageFullPath!=nil) {
            UIImage *image=[UIImage imageWithContentsOfFile:imageFullPath];
            NSData *imageData=UIImageJPEGRepresentation(image,0.1);
            AVFile *imageFile=[AVFile fileWithData:imageData];
            [imageFile saveInBackground];

        [saveObj setObject:imageFile forKey:@"rewardImage"];
    }
//    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [indicator startAnimating];
//    [self.view addSubview:indicator];
    [saveObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error==nil) {
            
            self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"提交成功" delegate:self cancelButtonTitle:@"留着这里" otherButtonTitles:@"返回",nil];
            [self.alert show];
        }
        else
        {
            
            self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"提交失败" delegate:self cancelButtonTitle:@"留在这里" otherButtonTitles:@"返回",nil];
            [self.alert show];
        }
    }];
    }
}



- (IBAction)doneChooseEdit:(id)sender {
    
    if ([self.chooseCity isFirstResponder]) {
        [self.chooseCity resignFirstResponder];
    }
    if ([self.chooseType isFirstResponder]) {
        [self.chooseType resignFirstResponder];
    }
    if ([self.chooseZone isFirstResponder]) {
        [self.chooseZone resignFirstResponder];
    }
    
}

- (IBAction)chooseEditBeginAction:(id)sender {
    UITextField *textField=sender;
    switch (textField.tag) {
        case 10000:
            pickViewTag=0;
            pickViewDataArray=[[NSArray alloc]initWithObjects:@"美食",@"住宿",@"娱乐",@"其他",nil];
            [self.pickViewer reloadAllComponents];
            break;
         case 10001:
            pickViewTag=1;
            pickViewDataArray=[cityAndZoneDict allKeys];
            [self.pickViewer reloadAllComponents];
            break;
        case 10002:
            pickViewTag=2;
            if (self.chooseCity.text!=nil&&[[cityAndZoneDict allKeys]containsObject:self.chooseCity.text]) {
                pickViewDataArray=[cityAndZoneDict objectForKey:self.chooseCity.text];
                [self.pickViewer reloadAllComponents];
            }
            else
            {
              
                self.alert=[[UIAlertView alloc]initWithTitle:@"" message:@"请先选择城市" delegate:self cancelButtonTitle:@"知道" otherButtonTitles:nil];
                [self.alert show];
            }
            
        default:
            break;
    }
    
    
}


- (IBAction)UpLoadImageAction:(id)sender {
    
    
    UIActionSheet *sheet;
    //判断是不是支持相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet=[[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消"otherButtonTitles:@"拍照上传",@"从相册选择", nil];
        sheet.tag=255;
    }
    else
    {
        sheet=[[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消"otherButtonTitles:@"从相册选择", nil];
    }
     [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    
    //高保真压缩图片
//    NSData * UIImageJPEGRepresentation ( UIImage *image, CGFloat compressionQuality);
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    [self.upLoadImageView setImage:savedImage];
    
    self.upLoadImageView.tag = 100;
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
   imageFullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:imageFullPath atomically:NO];
    NSLog(@"imageFullPath:%@",imageFullPath);
    
}

//何时调用？
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    isFullScreen = !isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.upLoadImageView.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.upLoadImageView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.upLoadImageView.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (isFullScreen) {
            // 放大尺寸
            
            self.upLoadImageView.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.upLoadImageView.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
    }
    
}
@end
