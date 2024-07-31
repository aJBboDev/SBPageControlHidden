#import <UIKit/UIKit.h>

@interface SBFolderScrollAccessoryView : UIView
@end

%group iOS16Hook
%hook SBFolderScrollAccessoryView
-(void)layoutSubviews { 
   %orig;
   self.hidden = YES;
}
%end
%end

@interface SBIconListPageControl : UIView
@end

%group iOS14and15Hook
%hook SBIconListPageControl
-(void)layoutSubviews { 
   %orig;
   self.hidden = YES;
}
%end
%end

%ctor {

   %init;

   if (@available(iOS 16, *)) {
        %init(iOS16Hook);
    } else {
        %init(iOS14and15Hook);
    }
    
}


