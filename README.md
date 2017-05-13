# 智能导诊
该功能模块是智能导诊里面点击人形图像作出不同事件反应功能的模块，该模块是在VIPhotoView开源模块基础上做的扩展。

1、下载完本项目并进入项目路径运行pod install。再进入目录打开智能导诊.xcworkspace打开工程。
2、需要修改和添加各一处，如下：

	1）、将VIPhotoView源文件中containerView控件移到头文件。
	2、新增函数setImage，如下：
	头文件VIPhotoView.h声明：- (void)setImage:(UIImage *)image;
	源文件VIPhotoView.m实现如下：
	- (void)setImage:(UIImage *)image
	{
    self.imageView.image = image;
	}

然后直接编译运行看看效果吧。

[](http://opwfpa155.bkt.clouddn.com/17-5-14/19583114-file_1494691513935_e36f.png)