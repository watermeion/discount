//
//  MyProfileViewController.m
//  DaZhe
//
//  Created by Mac on 11/26/14.
//  Copyright (c) 2014 麻辣工作室. All rights reserved.
//

#import "MyProfileViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CommonMacro.h"
@interface MyProfileViewController ()
{
    BOOL isFullScreen;
    NSString *imageFullPath;
}
@end

@implementation MyProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationItem.title=@"个人资料";
    //设置导航栏标题颜色及返回按钮颜色
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarAttributes];
    
    
    
    
    //刷新数据
    
    [self requestUsrBaseInfo];
    
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

- (IBAction)uploadProfileImageAction:(id)sender {
    
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
        
        imagePickerController.delegate=self;
        
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
    [self.usrProfileImage setImage:savedImage];
    
    self.usrProfileImage.tag = 100;
    
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
    
    //将图片上传到服务器
    [self saveUsrImage:imageFullPath];
    
}
//何时调用？
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    isFullScreen = !isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.usrProfileImage.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.usrProfileImage.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.usrProfileImage.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (isFullScreen) {
            // 放大尺寸
            
            self.usrProfileImage.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.usrProfileImage.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
    }
    
}


- (IBAction)changeNikiNameAction:(id)sender {
    UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:@"输入新昵称：" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerView.alertViewStyle=UIAlertViewStylePlainTextInput;
    alerView.tag=20000;
    [alerView show];
    
    
}


-(void)handleError
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"数据出错~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertView show];
    
}





#pragma --mark 与服务器交互
-(void)loadDataForInitViewContent:(NSArray*) objects
{
    AVObject *usrObj=[objects firstObject];
    self.usrPhoneNumberLabel.text=[usrObj objectForKey:@"mobilePhoneNumber"];
    self.usrNikiNameLabel.text=[usrObj objectForKey:@"nickName"];
    self.usrKubeNumberLabel.text=NSStringFromNumber([usrObj objectForKey:@"kubiFee"]);
    
    //处理图片
    AVFile *usrLogoFile=[usrObj objectForKey:@"userLogo"];
    NSData *imageData=[usrLogoFile getData];
    UIImage *image=[UIImage imageWithData:imageData];
    UIImage *imageWithoutNetwork=[UIImage imageNamed:@"mine.png"];
    self.usrProfileImage.image=(image)?image:imageWithoutNetwork;
    
}


-(void)requestUsrBaseInfo
{
    AVQuery *query=[AVQuery queryWithClassName:@"_User"];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    [query whereKey:@"objectId" equalTo:[AVUser currentUser].objectId];
    [query selectKeys:@[@"nickName",@"userLogo",@"mobilePhoneNumber",@"kubiFee"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error==nil && [objects count]==1) {
            
            [self loadDataForInitViewContent:objects];
        }
        else{
            [self handleError];
            
        }
    }];
}


-(void)saveUsrImage:(NSString *) imagePath
{
    if (imagePath!=nil) {
        
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        NSData *imageData=UIImageJPEGRepresentation(image,0.1);
        AVFile *imageFile=[AVFile fileWithData:imageData];
        [imageFile saveInBackground];
        
        AVUser * object=[AVUser currentUser];
        [object setObject:imageFile forKey:@"userLogo"];
//        [object setObject:[AVUser currentUser].objectId forKey:@"objectId"];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self uploadSuccess];
            }else
            {
                [self upLoadFailure];
            }
        }];
        
    }
    else
    {
        [self handleError];
        
    }
}





-(void)saveUsrNikiName:(NSString*) newName
{
    AVUser * object=[AVUser currentUser];
    [object setObject:newName forKey:@"nickName"];
//    [object setObject:[AVUser currentUser].objectId forKey:@"objectId"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self uploadSuccess];
            self.usrNikiNameLabel.text=newName;
        }
        else
        {
            [self upLoadFailure];
        }
    }];
    
    
}


-(void)uploadSuccess
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"保存成功~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertView show];
}
-(void)upLoadFailure
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"保存出错~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertView show];
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==20000) {
        if (buttonIndex==1) {
            UITextField *textField=[alertView textFieldAtIndex:0];
            NSString *nikeName=textField.text;
            [self saveUsrNikiName:nikeName];
            
        }
    }



}
@end
