#import "LaunchController.h"

@interface LaunchController () {
  UIButton *_connectButton;
}
-(UIButton*)connectButton;
@end

@implementation LaunchController

-(id)init {
  if (self = [super init]) {
    [self.view addSubview:self.connectButton];
    [self.view setNeedsUpdateConstraints];
  }
  return self;
}

-(UIButton*)connectButton {
  if (!_connectButton) {
    _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_connectButton setBackgroundColor:[UIColor blueColor]];
    [_connectButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_connectButton setTitle:NSLocalizedString(@"button.connect", nil) forState:UIControlStateNormal];
  }
  return _connectButton;
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.connectButton];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.connectButton];
}

@end
