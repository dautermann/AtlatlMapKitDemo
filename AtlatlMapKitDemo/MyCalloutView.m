// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "MyCalloutView.h"


@implementation MyCalloutView

@synthesize title = _title;

-(IBAction) handleTouch:(id)sender {
    //debug(@"touch %@", sender);
}


- (id)initWithAnnotation:(CalloutAnnotation*)annotation {
    self = [super initWithAnnotation:annotation];
    UIImage * imageToSet = [annotation.content.values objectForKey: @"image"];
    if(imageToSet)
    {
        [self.imageButton setImage: imageToSet forState: UIControlStateNormal];
    }
    
    ViewController * parentVC = [annotation.content.values objectForKey: @"parent"];
    Person * person = [annotation.content.values objectForKey: @"person"];
    
    [self setPersonForThisButton:person andViewController:parentVC];
    
    return self;
}

- (void)setAnnotation:(CalloutAnnotation *)annotation
{
    UIImage * imageToSet = [annotation.content.values objectForKey: @"image"];
    if(imageToSet)
    {
        [self.imageButton setImage: imageToSet forState: UIControlStateNormal];
    }
    
    ViewController * parentVC = [annotation.content.values objectForKey: @"parent"];
    Person * person = [annotation.content.values objectForKey: @"person"];
    
    [self setPersonForThisButton:person andViewController:parentVC];

    [super setAnnotation:annotation];
}

- (void) setPersonForThisButton: (Person *) person andViewController: (ViewController *) parentVC
{
    self.imageButton.person = person;
    
    NSSet * existingTargets = [self.imageButton allTargets];
    
    // doing this means we only add the touch down event and target only once...
    if([existingTargets count] == 0)
        [self.imageButton addTarget:parentVC action:@selector(displayDetails:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - NSObject

- (void)dealloc {
    self.title = nil;
    [super dealloc];
}


@end
