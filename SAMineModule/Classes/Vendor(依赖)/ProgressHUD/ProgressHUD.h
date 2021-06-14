//
// Copyright (c) 2014 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//-------------------------------------------------------------------------------------------------------------------------------------------------
#import <SpinKit/RTSpinKitView.h>

#define HUD_STATUS_FONT			[UIFont boldSystemFontOfSize:15]
#define HUD_STATUS_COLOR		RGBACOLOR(99, 99, 99, 1)

#define HUD_SPINNER_COLOR		RGBACOLOR(165, 0, 3, 1)
#define HUD_BACKGROUND_COLOR	[UIColor colorWithWhite:0 alpha:0.1]

#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"ProgressHUD.bundle/success-color.png"]
#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"ProgressHUD.bundle/error-color.png"]
//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ProgressHUD : UIView
//-------------------------------------------------------------------------------------------------------------------------------------------------

+ (ProgressHUD *)shared;

+ (void)dismiss;
+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showSuccess:(NSString *)status;

+ (void)showSuccess:(NSString *)status Interaction:(BOOL)Interaction;

+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)Interaction;

@property (nonatomic, assign) BOOL interaction;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIView *background;
@property (nonatomic, retain) UIToolbar *hud;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) RTSpinKitView *smallActivityIndicatorView;


@end
