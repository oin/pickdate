#import <Cocoa/Cocoa.h>

@interface NSDate (PickDate)
@end
@implementation NSDate (PickDate)
-(NSDate *)dateByAddingUnit:(NSCalendarUnit)unit value:(NSInteger)value
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	return [calendar dateByAddingUnit:unit value:value toDate:self options:0];
}
@end

@interface PickDatePicker : NSDatePicker
@end

@interface PickDateWindow : NSWindow
@end
@implementation PickDateWindow
-(IBAction)cancelOperation:(id)sender
{
	[self performClose:self];
}
@end

@interface PickDate : NSObject <NSApplicationDelegate, NSWindowDelegate>
{
	BOOL confirmed;
}
@property (nonatomic, strong) PickDateWindow *window;
@property (nonatomic, strong) PickDatePicker *picker;
@property (nonatomic, strong) NSDate *date;
-(void)datePickerDidDoubleClick;
@end

@implementation PickDatePicker
-(void)mouseDown:(NSEvent *)event
{
	NSPoint p = event.locationInWindow;
	[super mouseDown:event];
	if(event.clickCount == 2 && NSEqualPoints(event.locationInWindow, p)) {
		[(PickDate *)[NSApplication sharedApplication].delegate datePickerDidDoubleClick];
	}
}
@end

NSMenu* MenuApplication() {
	NSMenu* menu = [[NSMenu alloc] initWithTitle:@""];
	NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:@"About Date Picker" action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
	[menu addItem:item];
	[item release];

	item = [NSMenuItem separatorItem];
	[menu addItem:item];

	item = [[NSMenuItem alloc] initWithTitle:@"Quit Date Picker" action:@selector(terminate:) keyEquivalent:@"q"];
	[menu addItem:item];
	[item release];

	return [menu autorelease];
}

NSMenu *MenuFile() {
	NSMenu *menu = [[NSMenu alloc] initWithTitle:@"File"];
	NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Confirm" action:@selector(confirm:) keyEquivalent:@"\n"];
	item.keyEquivalentModifierMask = 0;
	[menu addItem:item];
	[item release];

	item = [NSMenuItem separatorItem];
	[menu addItem:item];

	item = [[NSMenuItem alloc] initWithTitle:@"Close" action:@selector(performClose:) keyEquivalent:@"w"];
	[menu addItem:item];
	[item release];

	return [menu autorelease];
}

NSMenu *MenuEdit() {
	NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Edit"];
	NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Today" action:@selector(selectToday:) keyEquivalent:@"t"];
	[menu addItem:item];
	[item release];

	item = [NSMenuItem separatorItem];
	[menu addItem:item];

	item = [[NSMenuItem alloc] initWithTitle:@"Previous Day" action:@selector(selectPreviousDay:) keyEquivalent:@"\uF702"];
	item.keyEquivalentModifierMask = 0;
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Next Day" action:@selector(selectNextDay:) keyEquivalent:@"\uF703"];
	item.keyEquivalentModifierMask = 0;
	[menu addItem:item];
	[item release];

	item = [NSMenuItem separatorItem];
	[menu addItem:item];

	item = [[NSMenuItem alloc] initWithTitle:@"Previous Week" action:@selector(selectPreviousWeek:) keyEquivalent:@"\uF700"];
	item.keyEquivalentModifierMask = 0;
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Next Week" action:@selector(selectNextWeek:) keyEquivalent:@"\uF701"];
	item.keyEquivalentModifierMask = 0;
	[menu addItem:item];
	[item release];

	item = [NSMenuItem separatorItem];
	[menu addItem:item];

	item = [[NSMenuItem alloc] initWithTitle:@"Previous Month" action:@selector(selectPreviousMonth:) keyEquivalent:@"\uF700"];
	item.keyEquivalentModifierMask = NSAlternateKeyMask;
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Next Month" action:@selector(selectNextMonth:) keyEquivalent:@"\uF701"];
	item.keyEquivalentModifierMask = NSAlternateKeyMask;
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Previous Year" action:@selector(selectPreviousYear:) keyEquivalent:@"\uF702"];
	item.keyEquivalentModifierMask = NSAlternateKeyMask;
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Next Year" action:@selector(selectNextYear:) keyEquivalent:@"\uF703"];
	item.keyEquivalentModifierMask = NSAlternateKeyMask;
	[menu addItem:item];
	[item release];

	return [menu autorelease];
}

NSMenu *MenuWindow() {
	NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Window"];
	NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Minimize" action:@selector(performMiniaturize:) keyEquivalent:@"m"];
	[menu addItem:item];
	[item release];
	
	item = [NSMenuItem separatorItem];
	[menu addItem:item];

	item = [[NSMenuItem alloc] initWithTitle:@"Bring All to Front" action:@selector(arrangeInFront:) keyEquivalent:@""];
	[menu addItem:item];
	[item release];

	return [menu autorelease];
}

NSMenu *MenuHelp() {
	NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Help"];
	return [menu autorelease];
}

@implementation PickDate
@synthesize window = _window;
@synthesize picker = _picker;
@synthesize date = _date;

-(void)initMainMenu
{
	NSMenu* menu = [[NSMenu alloc] initWithTitle:@"Main Menu"];
	NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:@"" action:NULL keyEquivalent:@""];
	item.submenu = MenuApplication();
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"File" action:NULL keyEquivalent:@""];
	item.submenu = MenuFile();
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Edit" action:NULL keyEquivalent:@""];
	item.submenu = MenuEdit();
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Window" action:NULL keyEquivalent:@""];
	item.submenu = MenuWindow();
	[menu addItem:item];
	[item release];

	item = [[NSMenuItem alloc] initWithTitle:@"Help" action:NULL keyEquivalent:@""];
	item.submenu = MenuHelp();
	[menu addItem:item];
	[item release];

	[[NSApplication sharedApplication] setMainMenu:menu];
	[menu release];
}

#define PW 138
#define PH 168
#define XPADDING 30
#define YPADDING 25

-(void)initWindow
{
	self.window = [[PickDateWindow alloc] initWithContentRect:NSMakeRect(0, 0, PW + XPADDING * 2, PH + YPADDING) styleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask backing:NSBackingStoreBuffered defer:false];
	self.window.title = @"Date Picker";

	self.picker = [[PickDatePicker alloc] initWithFrame:NSMakeRect(XPADDING, YPADDING, PW, PH)];
	self.picker.datePickerStyle = NSClockAndCalendarDatePickerStyle;
	self.picker.datePickerElements = NSYearMonthDayDatePickerElementFlag;
	self.picker.target = self;
	self.picker.action = @selector(pickerDidSelect:);
	self.picker.continuous = NO;
	[self.picker sendActionOn:NSMouseExitedMask];
	[self.window.contentView addSubview:self.picker];
	[self.picker bind:@"dateValue" toObject:self withKeyPath:@"date" options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"NSContinuouslyUpdatesValue"]];

	self.window.initialFirstResponder = self.picker;

	[self.window center];
	[self.window makeKeyAndOrderFront:self];
}

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
	NSString *dateStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"InitialDate"];
	if([dateStr length]) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"YYYY'-'MM'-'dd";
		NSDate *date = [formatter dateFromString:dateStr];
		if(date) {
			self.date = date;
		}
		[formatter release];
	}
	if(!self.date) {
		self.date = [NSDate date];
	}
	[NSApp setApplicationIconImage:[[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericWindowIcon)]];
	[self initMainMenu];
	[self initWindow];
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
	if(!confirmed) {
		exit(1);
		return;
	}

	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"YYYY'-'MM'-'dd";
	NSString *dateStr = [formatter stringFromDate:self.date];
	printf("%s\n", [dateStr UTF8String]);
	[formatter release];
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

-(IBAction)pickerDidSelect:(id)sender
{
	self.date = self.picker.dateValue;
}

-(void)datePickerDidDoubleClick
{
	[self confirm:self];
}

-(IBAction)confirm:(id)sender
{
	confirmed = YES;
	[NSApp terminate:self];
}

-(IBAction)cancelOperation:(id)sender
{
	[NSApp terminate:self];
}

-(IBAction)selectPreviousDay:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSDayCalendarUnit value:-1];
}

-(IBAction)selectNextDay:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSDayCalendarUnit value:1];
}

-(IBAction)selectPreviousWeek:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSDayCalendarUnit value:-7];
}

-(IBAction)selectNextWeek:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSDayCalendarUnit value:7];
}

-(IBAction)selectPreviousMonth:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSMonthCalendarUnit value:-1];
}

-(IBAction)selectNextMonth:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSMonthCalendarUnit value:1];
}

-(IBAction)selectPreviousYear:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSYearCalendarUnit value:-1];
}

-(IBAction)selectNextYear:(id)sender
{
	self.date = [self.date dateByAddingUnit:NSYearCalendarUnit value:1];
}

-(IBAction)selectToday:(id)sender
{
	self.date = [NSDate date];
}

-(void)setDate:(NSDate *)date
{
	if(![date isEqualToDate:_date]) {
		NSDate *old = _date;
		_date = date;
		[_date retain];
		[old release];
	}
}

@end

int main(int argc, char const *argv[]) {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	PickDate* delegate = [[PickDate alloc] init];
	[NSApplication sharedApplication].delegate = delegate;
	
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
	dispatch_async(dispatch_get_main_queue(), ^{
		[NSApp activateIgnoringOtherApps:YES];
    });
	
	[NSApp run];
	
	[delegate release];
	[pool release];
	
	return 0;
}
