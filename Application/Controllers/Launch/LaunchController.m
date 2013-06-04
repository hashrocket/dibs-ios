#import "LaunchController.h"
#import "AppDelegate.h"

@interface LaunchController () {
  UIButton *_connectButton;
}
-(UIButton*)connectButton;
-(void)didTapConnect:(id)sender;
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
    [_connectButton addTarget:self action:@selector(didTapConnect:)
             forControlEvents:UIControlEventTouchUpInside];
    [_connectButton setTitle:NSLocalizedString(@"button.connect", nil)
                    forState:UIControlStateNormal];
  }
  return _connectButton;
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterX forSubview:self.connectButton];
  [self.view addEqualityConstraintOn:NSLayoutAttributeCenterY forSubview:self.connectButton];
}

-(void)didTapConnect:(id)sender {
  AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  [delegate openSessionWithAllowLoginUI:YES];
}

@end
