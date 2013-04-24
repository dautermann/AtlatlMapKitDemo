
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "CalloutView.h"
#import "CalloutAnnotation.h"
#import "AtlAtlButton.h"

@class ViewController;

@interface MyCalloutView : CalloutView

@property (nonatomic, retain) IBOutlet UILabel* title;
@property (nonatomic, retain) IBOutlet AtlAtlButton* imageButton;

- (IBAction) handleTouch:(id)sender;
- (id) initWithAnnotation:(CalloutAnnotation*)annotation;
- (void) setPersonForThisButton: (Person *) person andViewController: (ViewController *) parentVC;

@end
