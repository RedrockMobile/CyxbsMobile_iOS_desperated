//
//  FreshMan2018ViewController01.m
//  
//
//  Created by J J on 2018/8/15.
//

#import "FreshMan2018ViewController01.h"

@interface FreshMan2018ViewController01 ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation FreshMan2018ViewController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topHeight.constant = HEADERHEIGHT;
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, _imageView.frame.size.height);
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%f",_imageView.frame.size.height);

    
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

@end
