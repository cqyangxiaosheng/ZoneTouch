# 智能导诊
该模块是智能导诊里面点击人形图像作出不同反应功能的模块，该模块是在VIPhotoView开源模块基础上做的扩展。
在下载完本项目并运行pod install后，需要修改和添加两处。
1、将VIPhotoView源文件中containerView控件移到头文件，如下：
	@property (nonatomic, strong) UIView *containerView;
2、新增函数setImage，如下：
	头文件声明：- (void)setImage:(UIImage *)image;
	源文件实现如下：
	- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

然后直接运行应该就行了。