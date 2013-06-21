#import <UIKit/UIKit.h>

@interface TabButton : UIControl

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *iconName;

+(id)buttonWithTitle:(NSString*)title;
+(id)buttonWithTitle:(NSString*)title andIconName:(NSString*)iconName;

-(UILabel*)titleLabel;
-(UIImageView*)iconView;

-(NSString*)highlightedIconName;
-(void)setHighlightedIconName:(NSString*)highlightedIconName;

@end
