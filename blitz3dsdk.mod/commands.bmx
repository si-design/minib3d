Extern "C"

Rem
bbdoc: <p> Initializes the Blitz3D runtime environment and returns 0 if there is an error.
about:
</p>
See Also: <a href=#bbendblitz3d>bbEndBlitz3D</a>
EndRem
Function BeginBlitz3D()="bbBeginBlitz3D"

Rem
bbdoc: <p> Closes down the Blitz3D runtime environment and releases all resources.
about:
</p>
EndRem
Function EndBlitz3D()="bbEndBlitz3D"

Rem
bbdoc: <p> Sets the debugging level for the Blitz3DSDK
about:
A value of 0
can be used for release builds that have been fully debugged
and do not require runtime checks on all parameters
passed to Blitz3DSDK functions.
</p>
EndRem
Function SetBlitz3DDebugMode(debugmode)="bbSetBlitz3DDebugMode"

Rem
bbdoc: <p> Installs an error handler for use by the Blitz3DSDK.
about:
</p>
<p>
The prototype for the callback is
</p>
<pre>
</pre>
<p>
The Blitz3D runtime is closed before the error handler is invoked by the Blitz3DSDK.
</p>
<p>
The BlitzMax Blitz3DSDK module installs a default error handler which throws a
BlitzMax RuntimError containing the error message.
</p>
EndRem
Function SetBlitz3DDebugCallback(callback:Byte Ptr)="bbSetBlitz3DDebugCallback"

Rem
bbdoc: <p> Installs an event handler for use by the Blitz3DSDK.
about:
</p>
<p>
<a href=#bbsetblitz3deventcallback>bbSetBlitz3DEventCallback</a> must be called before <a href=#bbbeginblitz3d>bbBeginBlitz3D</a>.
</p>
<p>
The prototype for the callback is:
</p>
<pre>
</pre>
<p>
The following BlitzMax code demonstrates the use of an eventhandler which
enables standard BlitzMax input commands to be used with the Blitz3DSDK.
</p>
<pre>
</pre>
EndRem
Function SetBlitz3DEventCallback(callback)="bbSetBlitz3DEventCallback"

Rem
bbdoc: <p> Specifies a parent window for the Blitz3DSDK to use with the windowed modes of the <a href=#bbgraphics3d>bbGraphics3D</a> command.
about:
</p>
<p>
<a href=#bbsetblitz3dhwnd>bbSetBlitz3DHWND</a> must be called before <a href=#bbbeginblitz3d>bbBeginBlitz3D</a>.
</p>
<p>
Call <a href=#bbgraphics3d>bbGraphics3D</a> using the <b>GFX_WINDOWED</b> mode and
the maximum size of the parent window and use the
<a href=#bbsetviewport>bbSetViewport</a> command to configure the 3D display
to the  parent window's current size.
</p>
EndRem
Function SetBlitz3DHWND(hwndparent)="bbSetBlitz3DHWND"

Rem
bbdoc: <p> Specifies a title for any windows created by the Blitz3DSDK and optionally a message that is displayed when the user closes a window created by the Blitz3DSDK.
about:
</p>
EndRem
Function SetBlitz3DTitle(windowtitle$z,quitmessage$z)="bbSetBlitz3DTitle"

Rem
bbdoc: <p> The <a href=#bbgraphics>bbGraphics</a> command resizes the graphics display to the specified size in pixels and with the specified display properties including the color depth and fullscreen options.
about:
<table class="arg">
<tr><td class=argname>width</td><td class=argvalue>width of display in pixels</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of display in pixels</td></tr>
<tr><td class=argname>depth</td><td class=argvalue>color depth in bits, 0 = default</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>video mode flags, 0 = default</td></tr>
</table>
</p>
<p>
When a Blitz program begins a default 400x300 pixel
graphics window is created.
</p>
<p>
The depth parameter is optional, the default value of 0
specifies that Blitz3D select the most appropriate color
depth.
</p>
<p>
The mode parameter may be any of the following values:
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>GFX_DEFAULT</td><td class=data>0</td><td class=data>FixedWindowed in Debug mode and FullScreen in Release</td></tr>
<tr><td class=data>GFX_FULLSCREEN</td><td class=data>1</td><td class=data>Own entire screen for optimal performance</td></tr>
<tr><td class=data>GFX_WINDOWED</td><td class=data>2</td><td class=data>A fixed size window placed on the desktop</td></tr>
<tr><td class=data>GFX_WINDOWEDSCALED</td><td class=data>3</td><td class=data>Graphics scaled according to current size of Window</td></tr>
</table>
<p>
Before using <a href=#bbgraphics>bbGraphics</a> to configure a fullscreen display,
the specified resolution should be verified as available
on the current graphics driver.
</p>
<p>
The <a href=#bbgfxmodeexists>bbGfxModeExists</a> function will return False
resolution is not available. Calling <a href=#bbgraphics>bbGraphics</a> with an unsupported
resolution will cause the program to fail with an &quot;Unable to Set
Graphics Mode&quot; error message.
</p>
<p class="hint">
The <a href=#bbgraphics>bbGraphics</a> command causes all images to be destroyed meaning
all images should be (re)loaded after any use of the <a href=#bbgraphics>bbGraphics</a> command.
</p>
<p>
See the Blitz3D command <a href=#bbgraphics3d>bbGraphics3D</a> for configuring the display
for use with 3D graphics.
</p>
See Also: <a href=#bbgfxmodeexists>bbGfxModeExists</a> <a href=#bbgraphics3d>bbGraphics3D</a> <a href=#bbfrontbuffer>bbFrontBuffer</a> <a href=#bbbackbuffer>bbBackBuffer</a> <a href=#bbflip>bbFlip</a> <a href=#bbendgraphics>bbEndGraphics</a>
EndRem
Function Graphics(width,height,depth=0,mode=0)="bbGraphics"

Rem
bbdoc: <p> The <a href=#bbflip>bbFlip</a> command switches the FrontBuffer() and BackBuffer() of the current <a href=#bbgraphics>bbGraphics</a> display.
about:
<table class="arg">
<tr><td class=argname>synch</td><td class=argvalue>True
</table>
</p>
<p>
See the <a href=#bbbackbuffer>bbBackBuffer</a> command for a description on setting a
standard <a href=#bbgraphics>bbGraphics</a> display up for double buffered drawing.
</p>
<p>
The ability to draw graphics to a hidden buffer and then
transfer the completed drawing to the display is called
double buffering.
</p>
<p>
The <a href=#bbflip>bbFlip</a> command is used at the end of each drawing cycle
to display the results onto the display in a flicker free
manner.
</p>
<p>
The optional <b>synch</b> value may be set to False to override
the default True setting. Unsynchronized flipping should
only ever be used monitoring rendering performance as
it results in an ugly screen tearing.
</p>
See Also: <a href=#bbbackbuffer>bbBackBuffer</a> <a href=#bbfrontbuffer>bbFrontBuffer</a>
EndRem
Function Flip(synch=True)="bbFlip"

Rem
bbdoc: <p> The <a href=#bbbackbuffer>bbBackBuffer</a> function returns a buffer that corresponds to the hidden area that will be flipped to the display when the <a href=#bbflip>bbFlip</a> command is called.
about:
</p>
<p>
The <a href=#bbbackbuffer>bbBackBuffer</a> is the current drawing buffer after a call
to <a href=#bbgraphics3d>bbGraphics3D</a>.
</p>
<p>
Unlike <a href=#bbgraphics3d>bbGraphics3D</a> the <a href=#bbgraphics>bbGraphics</a> command does not make the
<a href=#bbbackbuffer>bbBackBuffer</a> the default drawing surface so a <a href=#bbsetbuffer>bbSetBuffer</a> <a href=#bbbackbuffer>bbBackBuffer</a>
command sequence is required after the <a href=#bbgraphics>bbGraphics</a> command
in order for the display to be configured for double buffered drawing.
</p>
See Also: <a href=#bbflip>bbFlip</a> <a href=#bbsetbuffer>bbSetBuffer</a> <a href=#bbfrontbuffer>bbFrontBuffer</a>
EndRem
Function BackBuffer()="bbBackBuffer"

Rem
bbdoc: <p> The <a href=#bbfrontbuffer>bbFrontBuffer</a> function returns a buffer that corresponds to that viewable on the display.
about:
</p>
<p>
Drawing to the FrontBuffer() can be used to display an image
that is progressively rendered. That is each main loop the
program does not include a <a href=#bbcls>bbCls</a> or <a href=#bbflip>bbFlip</a> but continually draws
to the FrontBuffer allowing the user to view the image as it
is created over the period of minutes or hours.
</p>
See Also: <a href=#bbbackbuffer>bbBackBuffer</a>
EndRem
Function FrontBuffer()="bbFrontBuffer"

Rem
bbdoc: <p> The <a href=#bbgraphicswidth>bbGraphicsWidth</a> command returns the current width of the display in pixels.
about:
</p>
See Also: <a href=#bbgraphics>bbGraphics</a> <a href=#bbgraphicsheight>bbGraphicsHeight</a> <a href=#bbgraphicsdepth>bbGraphicsDepth</a>
EndRem
Function GraphicsWidth()="bbGraphicsWidth"

Rem
bbdoc: <p> The <a href=#bbgraphicsheight>bbGraphicsHeight</a> command returns the current height of the display in pixels.
about:
</p>
See Also: <a href=#bbgraphics>bbGraphics</a> <a href=#bbgraphicswidth>bbGraphicsWidth</a> <a href=#bbgraphicsdepth>bbGraphicsDepth</a>
EndRem
Function GraphicsHeight()="bbGraphicsHeight"

Rem
bbdoc: <p> The <a href=#bbgraphicsdepth>bbGraphicsDepth</a> command returns the current color depth of the display.
about:
</p>
See Also: <a href=#bbgraphics>bbGraphics</a> <a href=#bbgraphicswidth>bbGraphicsWidth</a> <a href=#bbgraphicsheight>bbGraphicsHeight</a>
EndRem
Function GraphicsDepth()="bbGraphicsDepth"

Rem
bbdoc: <p> Returns the Graphics mode to the original 400x300 fixed window.
about:
</p>
<p class="hint">
The <a href=#bbendgraphics>bbEndGraphics</a> command causes all images to be destroyed.
</p>
See Also: <a href=#bbgraphics>bbGraphics</a>
EndRem
Function EndGraphics()="bbEndGraphics"

Rem
bbdoc: <p> <a href=#bbvwait>bbVWait</a> will cause the program to halt execution until the video display has completed its refresh and reached it's Vertical Blank cycle (the time during which the video beam returns to the top of the display to begin its next refresh).
about:
<table class="arg">
<tr><td class=argname>frames</td><td class=argvalue>optional number of frames to wait. Default is 1</td></tr>
</table>
</p>
<p>
The <a href=#bbvwait>bbVWait</a> command provides an alternative method to using
the synchronized version of the <a href=#bbflip>bbFlip</a> command (default)
which is useful on vintage computer hardware that does
not provide a properly synchonized Flip response.
</p>
<p>
Synching a game's display using the VWait command will also
cause the program to exhibit excess CPU usage and should
be made optional if utilized at all.
</p>
See Also: <a href=#bbflip>bbFlip</a> <a href=#bbscanline>bbScanLine</a>
EndRem
Function VWait(frames=1)="bbVWait"

Rem
bbdoc: <p> The <a href=#bbscanline>bbScanLine</a> function returns the actual scanline being refreshed by the video hardware or 0 if in vertical blank or unsupported by the hardware.
about:
</p>
See Also: <a href=#bbvwait>bbVWait</a> <a href=#bbflip>bbFlip</a>
EndRem
Function ScanLine()="bbScanLine"

Rem
bbdoc: <p> Returns the total amount of graphics memory present on the current graphics device.
about:
</p>
<p>
Use the <a href=#bbavailvidmem>bbAvailVidMem</a> command to find the available amount of video memory
and the difference to calculate the amount of video memory currently in
use.
</p>
See Also: <a href=#bbavailvidmem>bbAvailVidMem</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a>
EndRem
Function TotalVidMem()="bbTotalVidMem"

Rem
bbdoc: <p> Returns the available amount of graphics memory on the current graphics device.
about:
</p>
See Also: <a href=#bbtotalvidmem>bbTotalVidMem</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a>
EndRem
Function AvailVidMem()="bbAvailVidMem"

Rem
bbdoc: <p> SetGamma allows you to modify the gamma tables.
about:
<table class="arg">
<tr><td class=argname>red</td><td class=argvalue>red input value</td></tr>
<tr><td class=argname>green</td><td class=argvalue>green input value</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>blue input value</td></tr>
<tr><td class=argname>dest_red</td><td class=argvalue>red output value</td></tr>
<tr><td class=argname>dest_green</td><td class=argvalue>green output value</td></tr>
<tr><td class=argname>dest_blue</td><td class=argvalue>blue output value</td></tr>
</table>
</p>
<p>
Gamma can ONLY be used in fullscreen mode.
</p>
<p>
Gamma is performed on a per channel basis, with each red, green and blue
channel using a translation table of 256 entries to modify the resultant
color output. The <a href=#bbsetgamma>bbSetGamma</a> command allows you to modify the specified
entry with the specified value for each of the 3 channels.
</p>
<p>
Suitable translation tables can be configured to influence
any or all of the 3 primary color components allowing the
displayed channel (red, green or blue) to be amplified,
muted or even inverted.
</p>
<p>
After performing one or more <a href=#bbsetgamma>bbSetGamma</a> commands, call <a href=#bbupdategamma>bbUpdateGamma</a> in
order for the changes to become effective.
</p>
See Also: <a href=#bbupdategamma>bbUpdateGamma</a> <a href=#bbgammared>bbGammaRed</a> <a href=#bbgammablue>bbGammaBlue</a> <a href=#bbgammagreen>bbGammaGreen</a>
EndRem
Function SetGamma(red,green,blue,dest_red,dest_green,dest_blue)="bbSetGamma"

Rem
bbdoc: <p> UpdateGamma should be used after a series of <a href=#bbsetgamma>bbSetGamma</a> commands in order to effect actual changes.
about:
<table class="arg">
<tr><td class=argname>calibrate</td><td class=argvalue>True if the gamma table should be calibrated to the display</td></tr>
</table>
</p>
See Also: <a href=#bbsetgamma>bbSetGamma</a>
EndRem
Function UpdateGamma(calibrate=0)="bbUpdateGamma"

Rem
bbdoc: <p> Returns the adjusted output value of the red channel given the specified input <b>value</b> by referencing the current gamma correction tables.
about:
<table class="arg">
<tr><td class=argname>value</td><td class=argvalue>an integer index into the red gamma table</td></tr>
</table>
</p>
<p>
See <b>SetGamma</b> for more information
</p>
See Also: <a href=#bbgammagreen>bbGammaGreen</a> <a href=#bbgammablue>bbGammaBlue</a> <a href=#bbsetgamma>bbSetGamma</a>
EndRem
Function GammaRed(value)="bbGammaRed"

Rem
bbdoc: <p> Returns the adjusted output value of the green channel given the specified input <b>value</b> by referencing the current gamma correction tables.
about:
<table class="arg">
<tr><td class=argname>value</td><td class=argvalue>an integer index into the green gamma table</td></tr>
</table>
</p>
<p>
See <b>SetGamma</b> for more information
</p>
See Also: <a href=#bbgammared>bbGammaRed</a> <a href=#bbgammablue>bbGammaBlue</a> <a href=#bbsetgamma>bbSetGamma</a>
EndRem
Function GammaGreen(value)="bbGammaGreen"

Rem
bbdoc: <p> Returns the adjusted output value of the blue channel given the specified input <b>value</b> by referencing the current gamma correction tables.
about:
<table class="arg">
<tr><td class=argname>value</td><td class=argvalue>an integer index into the blue gamma table</td></tr>
</table>
</p>
<p>
See <b>SetGamma</b> for more information
</p>
See Also: <a href=#bbgammared>bbGammaRed</a> <a href=#bbgammagreen>bbGammaGreen</a> <a href=#bbsetgamma>bbSetGamma</a>
EndRem
Function GammaBlue(value)="bbGammaBlue"

Rem
bbdoc: <p> The <a href=#bbprint>bbPrint</a> command writes a string version of <b>value</b> if specified to the current graphics buffer at the current cursor position and moves the cursor position to the next line.
about:
<table class="arg">
<tr><td class=argname>value</td><td class=argvalue>the text to be output (optional)</td></tr>
</table>
</p>
<p>
If the optional value parameter is omitted the <a href=#bbprint>bbPrint</a> command simply
moves the cursor position down a line.
</p>
<p>
As Blitz automatically converts any numeric or custom type to a string
the value parameter can in fact be any value.
</p>
See Also: <a href=#bbwrite>bbWrite</a> <a href=#bbinput>bbInput</a> <a href=#bblocate>bbLocate</a>
EndRem
Function Print(value$z)="bbPrint"

Rem
bbdoc: <p> The <a href=#bbwrite>bbWrite</a> command is similar to the <a href=#bbprint>bbPrint</a> command but the cursor is not moved to a new line at the completion of the command.
about:
<table class="arg">
<tr><td class=argname>value</td><td class=argvalue>the text to be output (optional)</td></tr>
</table>
</p>
<p>
Instead, the cursor is moved to the end of the output text.
</p>
See Also: <a href=#bbprint>bbPrint</a> <a href=#bblocate>bbLocate</a>
EndRem
Function Write(value$z)="bbWrite"

Rem
bbdoc: <p> The <a href=#bbinput>bbInput</a> command accepts and prints keyboard entry from the user until a Return key is received at which time the Input command returns a string result.
about:
<table class="arg">
<tr><td class=argname>prompt$</td><td class=argvalue>optional text to be printed before keyboard input proceeds</td></tr>
</table>
</p>
See Also: <a href=#bbprint>bbPrint</a> <a href=#bblocate>bbLocate</a>
EndRem
Function Input$z(prompt$z)="bbInput"

Rem
bbdoc: <p> The <a href=#bblocate>bbLocate</a> command positions the cursor position at the specified pixel position of the current graphics buffer.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal position on the current graphics buffer in pixels</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical position on the current graphics buffer in pixels</td></tr>
</table>
</p>
See Also: <a href=#bbprint>bbPrint</a> <a href=#bbwrite>bbWrite</a> <a href=#bbinput>bbInput</a>
EndRem
Function Locate(x,y)="bbLocate"

Rem
bbdoc: <p> The <a href=#bbcls>bbCls</a> command clears the current graphics buffer clean, using an optional color specified with a previous call to <a href=#bbclscolor>bbClsColor</a>.
about:
</p>
<p>
<a href=#bbcls>bbCls</a> is not commonly called when using <a href=#bbgraphics3d>bbGraphics3D</a> due to the
behavior of <a href=#bbrenderworld>bbRenderWorld</a> which clears the <a href=#bbbackbuffer>bbBackBuffer</a>
using the various <a href=#bbcameraclsmode>bbCameraClsMode</a> settings instead.
</p>
See Also: <a href=#bbclscolor>bbClsColor</a> <a href=#bbcameraclsmode>bbCameraClsMode</a>
EndRem
Function Cls()="bbCls"

Rem
bbdoc: <p> <a href=#bbplot>bbPlot</a> draws a single pixel at the coordinates specified using the current drawing color.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position</td></tr>
</table>
</p>
See Also: <a href=#bbline>bbLine</a> <a href=#bbrect>bbRect</a> <a href=#bbcolor>bbColor</a>
EndRem
Function Plot(x,y)="bbPlot"

Rem
bbdoc: <p> The <a href=#bbline>bbLine</a> command draws a line, in the current drawing color, from one pixel position to another.
about:
<table class="arg">
<tr><td class=argname>x1</td><td class=argvalue>start pixel's horizontal position</td></tr>
<tr><td class=argname>y1</td><td class=argvalue>start pixel's vertical position</td></tr>
<tr><td class=argname>x2</td><td class=argvalue>end pixel's horizontal position</td></tr>
<tr><td class=argname>y2</td><td class=argvalue>end pixel's vertical position</td></tr>
</table>
</p>
See Also: <a href=#bbplot>bbPlot</a> <a href=#bbrect>bbRect</a> <a href=#bbcolor>bbColor</a>
EndRem
Function Line(x1,y1,x2,y2)="bbLine"

Rem
bbdoc: <p> The <a href=#bbrect>bbRect</a> command draws a rectangle.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontl pixel position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width in pixels</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height in pixels</td></tr>
<tr><td class=argname>solid</td><td class=argvalue>False draws an outline only</td></tr>
</table>
</p>
<p>
It uses the current drawing color to draw a solid rectangle or
outlined if a False setting is specified for the <b>solid</b> parameter.
</p>
See Also: <a href=#bbplot>bbPlot</a> <a href=#bbline>bbLine</a> <a href=#bbcolor>bbColor</a>
EndRem
Function Rect(x,y,width,height,solid=True)="bbRect"

Rem
bbdoc: <p> The <a href=#bboval>bbOval</a> command can be used to draw circles and ovals in solid or outline form.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontl pixel position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width in pixels</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height in pixels</td></tr>
<tr><td class=argname>solid</td><td class=argvalue>False draws an outline only</td></tr>
</table>
</p>
<p>
The shape of the <a href=#bboval>bbOval</a> drawn is the largest that can fit inside
the specified rectangle.
</p>
EndRem
Function Oval(x,y,width,height,solid=True)="bbOval"

Rem
bbdoc: <p> This command sets the current drawing color allowing Lines, Rectangles, Ovals, Pixels and Text to be drawn in any color of the rainbow.
about:
<table class="arg">
<tr><td class=argname>red</td><td class=argvalue>amount of red (0..255)</td></tr>
<tr><td class=argname>green</td><td class=argvalue>amount of green (0..255)</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>amount of blue (0..255)</td></tr>
</table>
</p>
<p>
The actual color is specified by 3 numbers representing
the amount of red, green and blue mixed together.
</p>
<p>
The following table demonstrates values of red, green and blue
required to specify the named colors:
</p>
<table class="data">
<tr><th class=data>Color</th><th class=data>Red</th><th class=data>Green</th><th class=data>Blue</th></tr>
<tr><td class=data>Black</td><td class=data>0</td><td class=data>0</td><td class=data>0</td></tr>
<tr><td class=data>Red</td><td class=data>255</td><td class=data>0</td><td class=data>0</td></tr>
<tr><td class=data>Green</td><td class=data>0</td><td class=data>255</td><td class=data>0</td></tr>
<tr><td class=data>Blue</td><td class=data>0</td><td class=data>0</td><td class=data>255</td></tr>
<tr><td class=data>Yellow</td><td class=data>255</td><td class=data>255</td><td class=data>0</td></tr>
<tr><td class=data>Turquoise</td><td class=data>0</td><td class=data>255</td><td class=data>255</td></tr>
<tr><td class=data>Purple</td><td class=data>255</td><td class=data>0</td><td class=data>255</td></tr>
<tr><td class=data>White</td><td class=data>255</td><td class=data>255</td><td class=data>255</td></tr>
</table>
EndRem
Function Color(red,green,blue)="bbColor"

Rem
bbdoc: <p> The <a href=#bbclscolor>bbClsColor</a> command is used to change the Color used by the <a href=#bbcls>bbCls</a> command.
about:
<table class="arg">
<tr><td class=argname>red</td><td class=argvalue>amount of red (0..255)</td></tr>
<tr><td class=argname>green</td><td class=argvalue>amount of green (0..255)</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>amount of blue (0..255)</td></tr>
</table>
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for combining values of red, green and blue
in order to specify some commonly used colors.
</p>
See Also: <a href=#bbcls>bbCls</a> <a href=#bbcolor>bbColor</a>
EndRem
Function ClsColor(red,green,blue)="bbClsColor"

Rem
bbdoc: <p> The <a href=#bborigin>bbOrigin</a> command sets a point of origin for all subsequent drawing commands.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position</td></tr>
</table>
</p>
<p>
The default <a href=#bborigin>bbOrigin</a> of a drawing buffer is the top left pixel.
</p>
<p>
After calling <a href=#bborigin>bbOrigin</a>, all drawing commands will treat the pixel
at location <b>x</b>,<b>y</b> as coordinate 0,0
</p>
See Also: <a href=#bbplot>bbPlot</a> <a href=#bbline>bbLine</a> <a href=#bbrect>bbRect</a> <a href=#bboval>bbOval</a>
EndRem
Function Origin(x,y)="bbOrigin"

Rem
bbdoc: <p> The <a href=#bbviewport>bbViewport</a> command allows the cropping of subsequent drawing commands to a rectangular region of the current graphics buffer.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width in pixels</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height in pixels</td></tr>
</table>
</p>
<p>
This is useful for partitioning the screen into separate errors such as the split screen mode common in two player video games.
</p>
See Also: <a href=#bborigin>bbOrigin</a>
EndRem
Function Viewport(x,y,width,height)="bbViewport"

Rem
bbdoc: <p> The <a href=#bbgetcolor>bbGetColor</a> command sets the current drawing color to that of the pixel at the specified screen coordinates.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position</td></tr>
</table>
</p>
<p>
The <a href=#bbcolorred>bbColorRed</a>, <a href=#bbcolorgreen>bbColorGreen</a> and <a href=#bbcolorblue>bbColorBlue</a> functions can
be used to retrieve the current drawing color, allowing you
to determine a pixel's color.
</p>
See Also: <a href=#bbcolor>bbColor</a> <a href=#bbcolorred>bbColorRed</a> <a href=#bbcolorgreen>bbColorGreen</a> <a href=#bbcolorblue>bbColorBlue</a>
EndRem
Function GetColor(x,y)="bbGetColor"

Rem
bbdoc: <p> The <a href=#bbcolorred>bbColorRed</a> function returns the red component of the current drawing color.
about:
</p>
See Also: <a href=#bbcolor>bbColor</a> <a href=#bbgetcolor>bbGetColor</a> <a href=#bbcolorgreen>bbColorGreen</a> <a href=#bbcolorblue>bbColorBlue</a>
EndRem
Function ColorRed()="bbColorRed"

Rem
bbdoc: <p> The <a href=#bbcolorgreen>bbColorGreen</a> function returns the green component of the current drawing color.
about:
</p>
See Also: <a href=#bbcolor>bbColor</a> <a href=#bbgetcolor>bbGetColor</a> <a href=#bbcolorred>bbColorRed</a> <a href=#bbcolorblue>bbColorBlue</a>
EndRem
Function ColorGreen()="bbColorGreen"

Rem
bbdoc: <p> The <a href=#bbcolorblue>bbColorBlue</a> function returns the blue component of the current drawing color.
about:
</p>
See Also: <a href=#bbcolor>bbColor</a> <a href=#bbgetcolor>bbGetColor</a> <a href=#bbcolorred>bbColorRed</a> <a href=#bbcolorgreen>bbColorGreen</a>
EndRem
Function ColorBlue()="bbColorBlue"

Rem
bbdoc: <p> The <a href=#bbtext>bbText</a> command prints the <b>string</b> specified at the pixel coordinate <b>x</b>,<b>y.</b> </p> <p> <a href=#bbtext>bbText</a> uses the current font which can be modified with the <a href=#bbsetfont>bbSetFont</a> command and the current color which can be modified with the <a href=#bbcolor>bbColor</a> command.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel position of top left enclosing rectangle</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel position of the top left enclosing rectangle</td></tr>
<tr><td class=argname>str$</td><td class=argvalue>string/text to print</td></tr>
<tr><td class=argname>centerX</td><td class=argvalue>True to center text horizontally</td></tr>
<tr><td class=argname>centerY</td><td class=argvalue>True to center text vertically</td></tr>
</table>
</p>
<p>
The optional centering parameters allow the specified pixel
position to be used as the center of the text printed rather
than representing the top left position of the region.
</p>
See Also: <a href=#bbsetfont>bbSetFont</a> <a href=#bbstringwidth>bbStringWidth</a> <a href=#bbstringheight>bbStringHeight</a>
EndRem
Function Text(x,y,str$z,centerX=False,centerY=False)="bbText"

Rem
bbdoc: <p> The <a href=#bbloadfont>bbLoadFont</a> function loads a font and returns a font handle which can subsequently used with commands such as <a href=#bbsetfont>bbSetFont</a> and <a href=#bbfreefont>bbFreeFont</a>.
about:
<table class="arg">
<tr><td class=argname>fontname$</td><td class=argvalue>name of font to be loaded, e.g. &quot;arial&quot;</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of font in points (default is 12)</td></tr>
<tr><td class=argname>bold</td><td class=argvalue>True to load bold version of font</td></tr>
<tr><td class=argname>italic</td><td class=argvalue>True to load italic version of font</td></tr>
<tr><td class=argname>underlined</td><td class=argvalue>True to load underlined version of font</td></tr>
</table>
</p>
See Also: <a href=#bbsetfont>bbSetFont</a>
EndRem
Function LoadFont(FontName$z,height=12,bold=False,italic=False,underlined=False)="bbLoadFont"

Rem
bbdoc: <p> The <a href=#bbsetfont>bbSetFont</a> command is used in combination with a prior LoadFont command to specify which font subsequent <a href=#bbtext>bbText</a>, <a href=#bbprint>bbPrint</a>, <a href=#bbwrite>bbWrite</a>, <a href=#bbfontwidth>bbFontWidth</a>, <a href=#bbfontheigtht>bbFontHeigtht</a>, <a href=#bbstringwidth>bbStringWidth</a> and <a href=#bbstringheight>bbStringHeight</a> commands will use.
about:
<table class="arg">
<tr><td class=argname>fonthandle</td><td class=argvalue>handle of a font successfully returned by <a href=#bbloadfont>bbLoadFont</a></td></tr>
</table>
</p>
See Also: <a href=#bbtext>bbText</a> <a href=#bbfreefont>bbFreeFont</a> <a href=#bbprint>bbPrint</a> <a href=#bbwrite>bbWrite</a> <a href=#bbfontwidth>bbFontWidth</a> <a href=#bbfontheight>bbFontHeight</a> <a href=#bbstringwidth>bbStringWidth</a> <a href=#bbstringheight>bbStringHeight</a>
EndRem
Function SetFont(fonthandle)="bbSetFont"

Rem
bbdoc: <p> Use the <a href=#bbfreefont>bbFreeFont</a> command when a font returned by the <a href=#bbloadfont>bbLoadFont</a> command is no longer required for text drawing duties.
about:
<table class="arg">
<tr><td class=argname>fonthandle</td><td class=argvalue>A handle to a previously loaded font.</td></tr>
</table>
</p>
EndRem
Function FreeFont(fonthandle)="bbFreeFont"

Rem
bbdoc: <p> Returns the current width in pixels of the WIDEST character in the font.
about:
</p>
See Also: <a href=#bbfontheight>bbFontHeight</a> <a href=#bbsetfont>bbSetFont</a>
EndRem
Function FontWidth()="bbFontWidth"

Rem
bbdoc: <p> Returns the current height in pixels of the currently selected font.
about:
</p>
See Also: <a href=#bbfontwidth>bbFontWidth</a> <a href=#bbsetfont>bbSetFont</a>
EndRem
Function FontHeight()="bbFontHeight"

Rem
bbdoc: <p> Returns the width in pixels of the specified string accounting for the current font selected with the most recent <a href=#bbsetfont>bbSetFont</a> command for the current graphics buffer.
about:
<table class="arg">
<tr><td class=argname>str$</td><td class=argvalue>any valid string or string variable</td></tr>
</table>
</p>
See Also: <a href=#bbsetfont>bbSetFont</a> <a href=#bbstringheight>bbStringHeight</a>
EndRem
Function StringWidth(str$z)="bbStringWidth"

Rem
bbdoc: <p> Returns the height in pixels of the specified string accounting for the current font selected with the most recent <a href=#bbsetfont>bbSetFont</a> command for the current graphics buffer.
about:
<table class="arg">
<tr><td class=argname>str</td><td class=argvalue>any valid string or string variable</td></tr>
</table>
</p>
See Also: <a href=#bbsetfont>bbSetFont</a> <a href=#bbstringwidth>bbStringWidth</a>
EndRem
Function StringHeight(str$z)="bbStringHeight"

Rem
bbdoc: <p> Reads an image file from disk.
about:
<table class="arg">
<tr><td class=argname>filename$</td><td class=argvalue>the name of the image file to be loaded</td></tr>
</table>
</p>
<p>
Blitz3D supports BMP, JPG and PNG image formats.
</p>
<table class="data">
<tr><th class=data>Extension</th><th class=data>Compression</th><th class=data>Features</th></tr>
<tr><td class=data>bmp</td><td class=data> none</td><td class=data> can be created with <a href=#bbsaveimage>bbSaveImage</a> command</td></tr>
<tr><td class=data>png</td><td class=data> good</td><td class=data> loss-less compression</td></tr>
<tr><td class=data>jpg</td><td class=data> excellent</td><td class=data> small loss in image quality</td></tr>
</table>
<p>
The PNG image format is recomended for general use.
</p>
<p>
The <a href=#bbloadimage>bbLoadImage</a> function returns an image handle that
can then be used with <a href=#bbdrawimage>bbDrawImage</a> to draw the image
on the current graphics buffer.
</p>
<p>
If the image file contains multiple frames of animation
use the <a href=#bbloadanimimage>bbLoadAnimImage</a> function instead.
</p>
<p>
If the image file cannot be located or there is a
problem loading, <a href=#bbloadimage>bbLoadImage</a> will fail and return 0.
</p>
See Also: <a href=#bbdrawimage>bbDrawImage</a> <a href=#bbloadanimimage>bbLoadAnimImage</a> <a href=#bbcreateimage>bbCreateImage</a> <a href=#bbfreeimage>bbFreeImage</a> <a href=#bbsaveimage>bbSaveImage</a>
EndRem
Function LoadImage(filename$z)="bbLoadImage"

Rem
bbdoc: <p> The <a href=#bbloadanimimage>bbLoadAnimImage</a> function is an alternative to <a href=#bbloadimage>bbLoadImage</a> that can load many frames of animation from a single image file.
about:
<table class="arg">
<tr><td class=argname>filename$</td><td class=argvalue>the name of the image file to be loaded</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width in pixels of each frame in the image.</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height in pixels of each frame in the image.</td></tr>
<tr><td class=argname>first</td><td class=argvalue>index of first animation frame in source image to load(usually 0)</td></tr>
<tr><td class=argname>count</td><td class=argvalue>number of frames to load</td></tr>
</table>
</p>
<p>
The frames must be drawn in similar sized rectangles
arranged from left to right, top to bottom on the
image source.
</p>
<p>
Animation is achieved by selecting a different frame
of animation to be used each time the image is drawn.
The optional <b>frame</b> parameter of commands such as
<a href=#bbdrawimage>bbDrawImage</a> select a specific frame of animation
to draw of the specified <b>image</b> loaded with this
command.
</p>
<p>
If the image file cannot be located or there is a
problem loading, <a href=#bbloadanimimage>bbLoadAnimImage</a> will fail and return 0.
</p>
See Also: <a href=#bbdrawimage>bbDrawImage</a> <a href=#bbloadimage>bbLoadImage</a>
EndRem
Function LoadAnimImage(filename$z,width,height,first,count)="bbLoadAnimImage"

Rem
bbdoc: <p> The <a href=#bbcreateimage>bbCreateImage</a> function returns a new image with the specified dimensions in pixels containing an optional number of animation frames.
about:
<table class="arg">
<tr><td class=argname>width</td><td class=argvalue>width in pixels of the new image</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height in pixels of the new image</td></tr>
<tr><td class=argname>frames</td><td class=argvalue>optional number of frames</td></tr>
</table>
</p>
<p>
Images need not be loaded from files but can instead be
created and modified by the program. Once an image
is created with <a href=#bbcreateimage>bbCreateImage</a> it can be used as the destination
of a <a href=#bbgrabimage>bbGrabImage</a> command or its pixel buffer can be
accessed directly with the <a href=#bbimagebuffer>bbImageBuffer</a> command.
</p>
See Also: <a href=#bbimagebuffer>bbImageBuffer</a> <a href=#bbfreeimage>bbFreeImage</a>
EndRem
Function CreateImage(width,height,frames=1)="bbCreateImage"

Rem
bbdoc: <p> The color specified by mixing the <b>red</b>, <b>green</b> and <b>blue</b> amounts is assigned as the mask color of the specified image.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>red</td><td class=argvalue>amount of red (0..255)</td></tr>
<tr><td class=argname>green</td><td class=argvalue>amount of green (0..255)</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>amount of blue (0..255)</td></tr>
</table>
</p>
<p>
When an image is drawn with <a href=#bbdrawimage>bbDrawImage</a>, <a href=#bbtileimage>bbTileImage</a>
or <a href=#bbdrawimagerect>bbDrawImageRect</a>, any pixels in the image that are the
same color as the mask color are not drawn.
</p>
<p>
<a href=#bbdrawblock>bbDrawBlock</a> and other block based commands can be used to
draw an image and ignore the image's mask color.
</p>
<p>
By default an image has a mask color of black.
</p>
See Also: <a href=#bbdrawimage>bbDrawImage</a>
EndRem
Function MaskImage(image,red,green,blue)="bbMaskImage"

Rem
bbdoc: <p> Returns the width in pixels of the specified image.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
</p>
<p>
Use this function and <a href=#bbimageheight>bbImageHeight</a> to ascertain the
exact pixel size of an image's bounding rectangle.
</p>
See Also: <a href=#bbimageheight>bbImageHeight</a>
EndRem
Function ImageWidth(image)="bbImageWidth"

Rem
bbdoc: <p> Returns the height in pixels of the specified image.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
</p>
<p>
Use this function and <a href=#bbimagewidth>bbImageWidth</a> to ascertain the
exact pixel size of an image's bounding rectangle.
</p>
See Also: <a href=#bbimagewidth>bbImageWidth</a>
EndRem
Function ImageHeight(image)="bbImageHeight"

Rem
bbdoc: <p> <a href=#bbsaveimage>bbSaveImage</a> saves an image or one of its frames to a .bmp format image file.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>bmpfile$</td><td class=argvalue>the filename to be used when the image file is created</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame of the image to save</td></tr>
</table>
</p>
<p>
Returns True
</p>
<p class="hint">
The .bmp suffix should be included at the end of the filename if the
image file created by <a href=#bbsaveimage>bbSaveImage</a> is to be recognized as a valid image
by the system and other applications.
</p>
See Also: <a href=#bbloadimage>bbLoadImage</a> <a href=#bbsavebuffer>bbSaveBuffer</a>
EndRem
Function SaveImage(image,bmpfile$z,frame=0)="bbSaveImage"

Rem
bbdoc: <p> The <a href=#bbfreeimage>bbFreeImage</a> command releases all memory used by the image specified.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
</p>
<p>
Following a call to <a href=#bbfreeimage>bbFreeImage</a> the specified image handle
is no longer valid and must not be used.
</p>
See Also: <a href=#bbloadimage>bbLoadImage</a> <a href=#bbcreateimage>bbCreateImage</a> <a href=#bbcopyimage>bbCopyImage</a>
EndRem
Function FreeImage(image)="bbFreeImage"

Rem
bbdoc: <p> The <a href=#bbdrawimage>bbDrawImage</a> command draws an image to the current graphics buffer at the specified pixel location.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame number</td></tr>
</table>
</p>
<p>
The <b>image</b> parameter must be a valid image loaded
with <a href=#bbloadimage>bbLoadImage</a> or <a href=#bbloadanimimage>bbLoadAnimImage</a> or alternatively
created with <a href=#bbcreateimage>bbCreateImage</a>.
</p>
<p>
If specified, a particular frame of animation from the
image may be drawn. The image in this situation must
be the result of a call to <a href=#bbloadanimimage>bbLoadAnimImage</a> and contain
the <b>frame</b> specified.
</p>
<p>
A faster version of <a href=#bbdrawimage>bbDrawImage</a> is available for images
that do not contain a mask or alpha channel called
<a href=#bbdrawblock>bbDrawBlock</a>.
</p>
See Also: <a href=#bbmaskimage>bbMaskImage</a> <a href=#bbdrawimagerect>bbDrawImageRect</a> <a href=#bbtileimage>bbTileImage</a> <a href=#bbloadimage>bbLoadImage</a> <a href=#bbdrawblock>bbDrawBlock</a>
EndRem
Function DrawImage(image,x,y,frame=0)="bbDrawImage"

Rem
bbdoc: <p> <a href=#bbdrawblock>bbDrawBlock</a> is similar to <a href=#bbdrawimage>bbDrawImage</a> except all masking and image transparency is ignored.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame number</td></tr>
</table>
</p>
See Also: <a href=#bbdrawblockrect>bbDrawBlockRect</a> <a href=#bbtileblock>bbTileBlock</a> <a href=#bbdrawimage>bbDrawImage</a>
EndRem
Function DrawBlock(image,x,y,frame=0)="bbDrawBlock"

Rem
bbdoc: <p> The <a href=#bbdrawimagerect>bbDrawImageRect</a> command draws a part of an Image on to the current graphics buffer at location <b>x</b>, <b>y.</b> </p> <p> The region of the image used is defined by the rectangle at location <b>image_x</b>,<b>image_y</b> of size <b>width</b>,<b>height.</b> </p> <p> See <a href=#bbdrawimage>bbDrawImage</a> for more details about drawing with images.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>image_x</td><td class=argvalue>horizontal pixel location in image</td></tr>
<tr><td class=argname>image_y</td><td class=argvalue>vertical pixel location in image</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width of rectangle to Draw</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of rectangle to Draw</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame number</td></tr>
</table>
</p>
See Also: <a href=#bbdrawimage>bbDrawImage</a> <a href=#bbdrawblockrect>bbDrawBlockRect</a> <a href=#bbtileimage>bbTileImage</a>
EndRem
Function DrawImageRect(image,x,y,image_x,image_y,width,height,frame=0)="bbDrawImageRect"

Rem
bbdoc: <p> The <a href=#bbdrawblockrect>bbDrawBlockRect</a> command is similar to <a href=#bbdrawimagerect>bbDrawImageRect</a> but ignores any masking and transparency in the source image.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>image_x</td><td class=argvalue>horizontal pixel location in image</td></tr>
<tr><td class=argname>image_y</td><td class=argvalue>vertical pixel location in image</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width of rectangle to Draw</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of rectangle to Draw</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame number</td></tr>
</table>
</p>
See Also: <a href=#bbdrawimagerect>bbDrawImageRect</a>
EndRem
Function DrawBlockRect(image,x,y,image_x,image_y,width,height,frame=0)="bbDrawBlockRect"

Rem
bbdoc: <p> The <a href=#bbtileimage>bbTileImage</a> command tiles the entire viewport of the current graphics buffer with the specified image.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel offset</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel offset</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame number</td></tr>
</table>
</p>
<p>
The optional pixel offsets effectively scroll the
tilemap drawn in the direction specified.
</p>
<p>
See <a href=#bbdrawimage>bbDrawImage</a> for more drawing images details.
</p>
See Also: <a href=#bbtileblock>bbTileBlock</a> <a href=#bbdrawimage>bbDrawImage</a>
EndRem
Function TileImage(image,x,y,frame=0)="bbTileImage"

Rem
bbdoc: <p> Similar to <a href=#bbtileimage>bbTileImage</a> but ignores transparency.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel offset</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel offset</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame number</td></tr>
</table>
</p>
<p>
Use this to tile an entire or portion of the screen
with a single repetitive image.
</p>
EndRem
Function TileBlock(image,x,y,frame=0)="bbTileBlock"

Rem
bbdoc: <p> Sets an image's drawing handle to the specified pixel offset.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel offset</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel offset</td></tr>
</table>
</p>
<p>
An image's handle is an offset added to the pixel
coordinate specified in a <a href=#bbdrawimage>bbDrawImage</a> command.
</p>
<p>
Images typically have their handle set to 0,0 which means
drawing commands draw the image with its top left pixel
at the drawing location specified.
</p>
<p>
The <a href=#bbautomidhandle>bbAutoMidHandle</a> command changes this behavior so that
all subsequent Images are loaded or created with their
handle set to the center of the Image.
</p>
<p>
The <a href=#bbhandleimage>bbHandleImage</a> command is used to position the handle
to any given pixel offset after it has been created.
</p>
<p>
Also See:
MidHandle;AutoMidHandle;DrawImage;RotateImage
</p>
EndRem
Function HandleImage(image,x,y)="bbHandleImage"

Rem
bbdoc: <p> The <a href=#bbmidhandle>bbMidHandle</a> command sets the specified image's handle to the center of the image
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
See <a href=#bbhandleimage>bbHandleImage</a> for more
details on using image handles.
</p>
See Also: <a href=#bbhandleimage>bbHandleImage</a>
EndRem
Function MidHandle(image)="bbMidHandle"

Rem
bbdoc: <p> Enabling <a href=#bbautomidhandle>bbAutoMidHandle</a> causes all subsequent loaded and created images to have their handles initialized to the center of the image.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True to enable automtic MidHandles, False to disable</td></tr>
</table>
</p>
<p>
The default setting of the AutoMidHandle setting is disabled
which dictates all newly create images have their handles set
to the top left pixel position of the image.
</p>
See Also: <a href=#bbmidhandle>bbMidHandle</a>
EndRem
Function AutoMidHandle(enable)="bbAutoMidHandle"

Rem
bbdoc: <p> Returns the horizontal pixel position of an image's handle.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
</p>
See Also: <a href=#bbimageyhandle>bbImageYHandle</a> <a href=#bbhandleimage>bbHandleImage</a>
EndRem
Function ImageXHandle(image)="bbImageXHandle"

Rem
bbdoc: <p> Returns the vertical pixel position of an image's handle.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
</p>
See Also: <a href=#bbimagexhandle>bbImageXHandle</a> <a href=#bbhandleimage>bbHandleImage</a>
EndRem
Function ImageYHandle(image)="bbImageYHandle"

Rem
bbdoc: <p> Returns an identical copy of the specified image.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
</table>
</p>
See Also: <a href=#bbfreeimage>bbFreeImage</a>
EndRem
Function CopyImage(image)="bbCopyImage"

Rem
bbdoc: <p> Copies pixels at the specified offset in the current graphics buffer to the image specified.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>left most horizontal pixel position to grab from</td></tr>
<tr><td class=argname>y</td><td class=argvalue>top most vertical pixel position to grab from</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional frame in which to store grabbed pixels</td></tr>
</table>
</p>
<p>
<a href=#bbgrabimage>bbGrabImage</a> is a useful way of capturing the result of
a sequence of drawing commands in an image's pixel
buffer.
</p>
See Also: <a href=#bbcreateimage>bbCreateImage</a> <a href=#bbdrawimage>bbDrawImage</a>
EndRem
Function GrabImage(image,x,y,frame=0)="bbGrabImage"

Rem
bbdoc: <p> The <a href=#bbimagebuffer>bbImageBuffer</a> function returns a graphics buffer that can be used with such commands as <a href=#bbsetbuffer>bbSetBuffer</a> and <a href=#bblockbuffer>bbLockBuffer</a>.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional animation frame</td></tr>
</table>
</p>
See Also: <a href=#bbsetbuffer>bbSetBuffer</a> <a href=#bblockbuffer>bbLockBuffer</a>
EndRem
Function ImageBuffer(image,frame=0)="bbImageBuffer"

Rem
bbdoc: <p> The <a href=#bbscaleimage>bbScaleImage</a> function returns a copy of an image scaled in each axis by the specified factors.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>xscale#</td><td class=argvalue>horizontal scale factor</td></tr>
<tr><td class=argname>yscale#</td><td class=argvalue>vertical scale factor</td></tr>
</table>
</p>
<p>
A negative scale factor also causes the resulting image to be
flipped in that axis, i.e. ScaleImage image,1,-1 will return
a copy of image flipped vertically. Other common scale
factors are 2,2 which produce a double sized image and
0.5,0.5 which will produce an image half the size of the
original.
</p>
<p>
The quality of the transformed result can be controlled
with the <a href=#bbtformfilter>bbTFormFilter</a> command.
</p>
<p>
See the <a href=#bbresizeimage>bbResizeImage</a> command for a similar command that
uses a target image size to calculate scale factors.
</p>
<p class="hint">
This command is not particularly fast and hence like loading
it is recomended images are scaled before a game level
commences.
</p>
See Also: <a href=#bbresizeimage>bbResizeImage</a> <a href=#bbrotateimage>bbRotateImage</a> <a href=#bbtformfilter>bbTFormFilter</a> <a href=#bbtformimage>bbTFormImage</a>
EndRem
Function ScaleImage(image,xscale#,yscale#)="bbScaleImage"

Rem
bbdoc: <p> The <a href=#bbresizeimage>bbResizeImage</a> function returns a copy of the specified image scaled to the specified pixel dimensions.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>width#</td><td class=argvalue>horizontal pixel size of new image</td></tr>
<tr><td class=argname>height#</td><td class=argvalue>vertical pixel size of new image</td></tr>
</table>
</p>
<p class="hint">
This command is not particularly fast and hence like loading
it is recomended images are sized before a game level
commences.
</p>
See Also: <a href=#bbscaleimage>bbScaleImage</a> <a href=#bbrotateimage>bbRotateImage</a> <a href=#bbtformfilter>bbTFormFilter</a>
EndRem
Function ResizeImage(image,width#,height#)="bbResizeImage"

Rem
bbdoc: <p> The RotateImage function creates a new image by copying the specified image and rotating it <b>angle</b> degrees around its current handle.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>angle#</td><td class=argvalue>angle in degree to rotate the image clockwise</td></tr>
</table>
</p>
<p class="hint">
This command is not particularly fast and hence like loading
it is recomended images are prerotated before a game level
commences.
</p>
See Also: <a href=#bbhandleimage>bbHandleImage</a> <a href=#bbscaleimage>bbScaleImage</a> <a href=#bbtformimage>bbTFormImage</a> <a href=#bbtformfilter>bbTFormFilter</a>
EndRem
Function RotateImage(image,angle#)="bbRotateImage"

Rem
bbdoc: <p> The <a href=#bbtformimage>bbTFormImage</a> function is similar in function to the <a href=#bbscaleimage>bbScaleImage</a> and <a href=#bbrotateimage>bbRotateImage</a> functions where the image returned is a transformed copy of the original image </p> <p> Instead of using a scale factor or angle of rotation, <a href=#bbtformimage>bbTFormImage</a> accepts 4 values that define a 2x2 matrix that allows the resultant copy to be the product of a transform that is a combination of both scale and rotation.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>m11#</td><td class=argvalue>first element of 2x2 matrix</td></tr>
<tr><td class=argname>m12#</td><td class=argvalue>second element of 2x2 matrix</td></tr>
<tr><td class=argname>m21#</td><td class=argvalue>third element of 2x2 matrix</td></tr>
<tr><td class=argname>m22#</td><td class=argvalue>fourth element of 2x2 matrix</td></tr>
</table>
</p>
<p>
<a href=#bbtformimage>bbTFormImage</a> is also useful for shearing an Image.
</p>
<p class="hint">
This command is not particularly fast and hence like loading
it is recomended images are transformed before a game level
commences.
</p>
See Also: <a href=#bbhandleimage>bbHandleImage</a> <a href=#bbscaleimage>bbScaleImage</a> <a href=#bbrotateimage>bbRotateImage</a> <a href=#bbtformfilter>bbTFormFilter</a>
EndRem
Function TFormImage(image,m11#,m12#,m21#,m22#)="bbTFormImage"

Rem
bbdoc: <p> The <a href=#bbtformfilter>bbTFormFilter</a> command controls the quality of transformation achieved when using the <a href=#bbscaleimage>bbScaleImage</a>, <a href=#bbrotateimage>bbRotateImage</a> and <a href=#bbtformimage>bbTFormImage</a> commands.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True to enable filtering, False to disable</td></tr>
</table>
</p>
<p>
Use a paramter of True to enable filtering, which although
slower produces a higher quality result.
</p>
See Also: <a href=#bbscaleimage>bbScaleImage</a> <a href=#bbrotateimage>bbRotateImage</a> <a href=#bbtformimage>bbTFormImage</a>
EndRem
Function TFormFilter(enable)="bbTFormFilter"

Rem
bbdoc: <p> <a href=#bbrectsoverlap>bbRectsOverlap</a> returns True if the two rectangular regions described overlap.
about:
<table class="arg">
<tr><td class=argname>x1</td><td class=argvalue>top left horizontal position of first rectangle</td></tr>
<tr><td class=argname>y1</td><td class=argvalue>top left vertical position of first rectangle</td></tr>
<tr><td class=argname>w1</td><td class=argvalue>width of first rectangle</td></tr>
<tr><td class=argname>h1</td><td class=argvalue>height of first rectangle</td></tr>
<tr><td class=argname>x2</td><td class=argvalue>top left horizontal position of second rectangle</td></tr>
<tr><td class=argname>y2</td><td class=argvalue>top left vertical position of seconf rectangle</td></tr>
<tr><td class=argname>w2</td><td class=argvalue>width of second rectangle</td></tr>
<tr><td class=argname>h2</td><td class=argvalue>height of second rectangle</td></tr>
</table>
</p>
EndRem
Function RectsOverlap(x1,y1,w1,h1,x2,y2,w2,h2)="bbRectsOverlap"

Rem
bbdoc: <p> The <a href=#bbimagesoverlap>bbImagesOverlap</a> function returns True if image1 drawn at the specified pixel location would overlap with image2 if drawn at its specified location.
about:
<table class="arg">
<tr><td class=argname>image1</td><td class=argvalue>first image to test</td></tr>
<tr><td class=argname>x1</td><td class=argvalue>image1's x location</td></tr>
<tr><td class=argname>y1</td><td class=argvalue>image1's y location</td></tr>
<tr><td class=argname>image2</td><td class=argvalue>second image to test</td></tr>
<tr><td class=argname>x2</td><td class=argvalue>image2's x location</td></tr>
<tr><td class=argname>y2</td><td class=argvalue>image2's y location</td></tr>
</table>
</p>
<p>
<a href=#bbimagesoverlap>bbImagesOverlap</a> does not take into account any transparent pixels and
hence is faster but less accurate than the comparable <a href=#bbimagescollide>bbImagesCollide</a>
function.
</p>
See Also: <a href=#bbimagescollide>bbImagesCollide</a>
EndRem
Function ImagesOverlap(image1,x1,y1,image2,x2,y2)="bbImagesOverlap"

Rem
bbdoc: <p> Unlike <a href=#bbimagesoverlap>bbImagesOverlap</a>, <a href=#bbimagescollide>bbImagesCollide</a> does respect transparent pixels in the source images and will only return True if actual solid pixels would overlap if the images were drawn in the specified locations.
about:
<table class="arg">
<tr><td class=argname>image1</td><td class=argvalue>first image to test</td></tr>
<tr><td class=argname>x1</td><td class=argvalue>image1's x location</td></tr>
<tr><td class=argname>y1</td><td class=argvalue>image1's y location</td></tr>
<tr><td class=argname>frame1</td><td class=argvalue>image1's frame to test (optional)</td></tr>
<tr><td class=argname>image2</td><td class=argvalue>second image to test</td></tr>
<tr><td class=argname>x2</td><td class=argvalue>image2's x location</td></tr>
<tr><td class=argname>y2</td><td class=argvalue>image2's y location</td></tr>
<tr><td class=argname>frame2</td><td class=argvalue>image2's frame to test (optional)</td></tr>
</table>
</p>
<p>
As <a href=#bbimagescollide>bbImagesCollide</a> tests actual pixels from the two images it
is slower but more exact than the <a href=#bbimagesoverlap>bbImagesOverlap</a> function.
</p>
See Also: <a href=#bbimagesoverlap>bbImagesOverlap</a> <a href=#bbrectsoverlap>bbRectsOverlap</a>
EndRem
Function ImagesCollide(image1,x1,y1,frame1,image2,x2,y2,frame2)="bbImagesCollide"

Rem
bbdoc: <p> The <a href=#bbimagerectoverlap>bbImageRectOverlap</a> function returns True if the image specified drawn at the location specified would overlap with the rectangle described.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location of image</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location of image</td></tr>
<tr><td class=argname>rectx</td><td class=argvalue>horizontal pixel location of rect</td></tr>
<tr><td class=argname>recty</td><td class=argvalue>vertical pixel location of rect</td></tr>
<tr><td class=argname>rectw</td><td class=argvalue>width of the rect</td></tr>
<tr><td class=argname>recth</td><td class=argvalue>height of the rect</td></tr>
</table>
</p>
<p>
<a href=#bbimagerectoverlap>bbImageRectOverlap</a> perform a fast rectangular based test ignoring
the shape of any image mask, see <a href=#bbimagerectcollide>bbImageRectCollide</a> for a more
exact collision test.
</p>
See Also: <a href=#bbimagesoverlap>bbImagesOverlap</a> <a href=#bbrectsoverlap>bbRectsOverlap</a> <a href=#bbimagerectcollide>bbImageRectCollide</a>
EndRem
Function ImageRectOverlap(image,x,y,rectx,recty,rectw,recth)="bbImageRectOverlap"

Rem
bbdoc: <p> The <a href=#bbimagerectcollide>bbImageRectCollide</a> function returns True if the image specified drawn at the location specified will result in any non transparent pixels being drawn inside the rectangle described.
about:
<table class="arg">
<tr><td class=argname>image</td><td class=argvalue>a valid image handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location of image</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location of image</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>image's frame</td></tr>
<tr><td class=argname>rectx</td><td class=argvalue>horizontal pixel location of rect</td></tr>
<tr><td class=argname>recty</td><td class=argvalue>vertical pixel location of rect</td></tr>
<tr><td class=argname>rectw</td><td class=argvalue>width of the rect</td></tr>
<tr><td class=argname>recth</td><td class=argvalue>height of the rect</td></tr>
</table>
</p>
<p>
Because <a href=#bbimagerectcollide>bbImageRectCollide</a> respects the transparent pixels in an
image's mask it is slower but more accurate than using the
<a href=#bbimagerectoverlap>bbImageRectOverlap</a> command.
</p>
See Also: <a href=#bbimagerectoverlap>bbImageRectOverlap</a>
EndRem
Function ImageRectCollide(image,x,y,frame,rectx,recty,rectw,recth)="bbImageRectCollide"

Rem
bbdoc: <p> The <a href=#bbsetbuffer>bbSetBuffer</a> command is used to set the current graphics buffer.
about:
<table class="arg">
<tr><td class=argname>buffer</td><td class=argvalue>a valid graphics buffer</td></tr>
</table>
</p>
<p>
After calling <a href=#bbsetbuffer>bbSetBuffer</a>, All 2D rendering commands will write to the specified
graphics buffer. 3D rendering always writes to the back buffer.
</p>
<p>
<a href=#bbsetbuffer>bbSetBuffer</a> also resets the <a href=#bborigin>bbOrigin</a> to 0,0 and the <a href=#bbviewport>bbViewport</a> to the
dimensions of the entire selected buffer.
</p>
<p>
<b>buffer</b> should be a valid graphics buffer returned by <a href=#bbfrontbuffer>bbFrontBuffer</a>,
<a href=#bbbackbuffer>bbBackBuffer</a>, <a href=#bbimagebuffer>bbImageBuffer</a>, <a href=#bbtexturebuffer>bbTextureBuffer</a> or the result of a previous call
to <a href=#bbgraphicsbuffer>bbGraphicsBuffer</a>.
</p>
<p>
At the beginning of program execution and following any call
to <a href=#bbgraphics>bbGraphics</a> the current graphics buffer is set to the display's
<a href=#bbfrontbuffer>bbFrontBuffer</a>.
</p>
<p>
After a call to <a href=#bbgraphics3d>bbGraphics3D</a> the current buffer is set to the
display's <a href=#bbbackbuffer>bbBackBuffer</a>.
</p>
See Also: <a href=#bbgraphicsbuffer>bbGraphicsBuffer</a> <a href=#bbfrontbuffer>bbFrontBuffer</a> <a href=#bbbackbuffer>bbBackBuffer</a> <a href=#bbimagebuffer>bbImageBuffer</a> <a href=#bbtexturebuffer>bbTextureBuffer</a>
EndRem
Function SetBuffer(buffer)="bbSetBuffer"

Rem
bbdoc: <p> Returns the currently selected graphics buffer.
about:
</p>
<p>
The <a href=#bbgraphicsbuffer>bbGraphicsBuffer</a> function is useful for storing the current
graphics buffer so it can be restored later.
</p>
<p>
See <a href=#bbsetbuffer>bbSetBuffer</a> for more information.
</p>
See Also: <a href=#bbsetbuffer>bbSetBuffer</a> <a href=#bbfrontbuffer>bbFrontBuffer</a> <a href=#bbbackbuffer>bbBackBuffer</a> <a href=#bbimagebuffer>bbImageBuffer</a>
EndRem
Function GraphicsBuffer()="bbGraphicsBuffer"

Rem
bbdoc: <p> Instead of calling <a href=#bbloadimage>bbLoadImage</a> and creating a new image the <a href=#bbloadbuffer>bbLoadBuffer</a> command reads the contents of a valid image file into the contents of an existing image, texture or if required the front or back buffer of the current display.
about:
<table class="arg">
<tr><td class=argname>buffer</td><td class=argvalue>a valid graphics buffer</td></tr>
<tr><td class=argname>filename$</td><td class=argvalue>the filename of an existing image file</td></tr>
</table>
</p>
EndRem
Function LoadBuffer(buffer,filename$z)="bbLoadBuffer"

Rem
bbdoc: <p> The <a href=#bbsavebuffer>bbSaveBuffer</a> function is similar to the <a href=#bbsaveimage>bbSaveImage</a> function in that it creates a .bmp image file with the specified <b>filename.</b> </p> <p> Unlike <a href=#bbsaveimage>bbSaveImage</a>, <a href=#bbsavebuffer>bbSaveBuffer</a> uses the pixels from the specified graphics buffer and so is useful for making screenshots.
about:
<table class="arg">
<tr><td class=argname>buffer</td><td class=argvalue>a valid graphics buffer</td></tr>
<tr><td class=argname>filename$</td><td class=argvalue>a legal filename</td></tr>
</table>
</p>
<p class="hint">
The .bmp suffix should be included at the end of the filename if the
image file created by <a href=#bbsavebuffer>bbSaveBuffer</a> is to be recognized as a valid image
by the system and other applications.
</p>
See Also: <a href=#bbsaveimage>bbSaveImage</a> <a href=#bbsetbuffer>bbSetBuffer</a>
EndRem
Function SaveBuffer(buffer,filename$z)="bbSaveBuffer"

Rem
bbdoc: <p> The <a href=#bbreadpixel>bbReadPixel</a> function determines the color of a pixel at the specified location of the specified graphics buffer.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>buffer</td><td class=argvalue>valid graphics buffer</td></tr>
</table>
</p>
<p>
The return value is an integer with the red, green and blue
values packed int the low 24 binary bits and a transparency
value in the high 8 bits.
</p>
<p>
If the x,y coordinate falls outside the bounds of the buffer
a value of BLACK or in the case of an image buffer, the images
mask color is returned.
</p>
<p>
If no graphics buffer is specified <a href=#bbreadpixel>bbReadPixel</a> uses the current
graphics buffer, see <a href=#bbsetbuffer>bbSetBuffer</a> for more details.
</p>
See Also: <a href=#bbwritepixel>bbWritePixel</a> <a href=#bbcopypixel>bbCopyPixel</a> <a href=#bbgetcolor>bbGetColor</a> <a href=#bbreadpixelfast>bbReadPixelFast</a>
EndRem
Function ReadPixel(x,y,buffer=0)="bbReadPixel"

Rem
bbdoc: <p> The <a href=#bbwritepixel>bbWritePixel</a> command sets the color of a pixel at the specified location of the specified graphics buffer to the value <b>color.</b> </p> <p> The <b>color</b> value is an integer with the red, green and blue values packed into the low 24 binary bits and if required the transparency value in the high 8 bits.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>color</td><td class=argvalue>binary packed color value</td></tr>
<tr><td class=argname>buffer</td><td class=argvalue>valid graphics buffer</td></tr>
</table>
</p>
<p>
If the x,y coordinate falls outside the bounds of the buffer
the <a href=#bbwritepixel>bbWritePixel</a> command does nothing.
</p>
<p>
If no graphics buffer is specified <a href=#bbwritepixel>bbWritePixel</a> uses the current
graphics buffer, see <a href=#bbsetbuffer>bbSetBuffer</a> for more details.
</p>
See Also: <a href=#bbreadpixel>bbReadPixel</a> <a href=#bbcopypixel>bbCopyPixel</a> <a href=#bbwritepixelfast>bbWritePixelFast</a> <a href=#bblockbuffer>bbLockBuffer</a>
EndRem
Function WritePixel(x,y,color,buffer=0)="bbWritePixel"

Rem
bbdoc: <p> The <a href=#bbcopypixel>bbCopyPixel</a> command sets the color of a pixel at the destination location of the destination graphics buffer to the color of the pixel at the source location of the source buffer.
about:
<table class="arg">
<tr><td class=argname>src_x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>src_y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>src_buffer</td><td class=argvalue>valid graphics buffer to read from</td></tr>
<tr><td class=argname>dest_x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>dest_y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>dest_buffer</td><td class=argvalue>valid graphics buffer to write to</td></tr>
</table>
</p>
<p>
If no destination graphics buffer is specified <a href=#bbcopypixel>bbCopyPixel</a>
writes to the the current graphics buffer.
</p>
See Also: <a href=#bbreadpixel>bbReadPixel</a> <a href=#bbwritepixel>bbWritePixel</a> <a href=#bbcopypixelfast>bbCopyPixelFast</a>
EndRem
Function CopyPixel(src_x,src_y,src_buffer,dest_x,dest_y,dest_buffer=0)="bbCopyPixel"

Rem
bbdoc: <p> The <a href=#bbcopyrect>bbCopyRect</a> command is similar to <a href=#bbcopypixel>bbCopyPixel</a> but copies a region of pixels <b>width</b>, <b>height</b> in size.
about:
<table class="arg">
<tr><td class=argname>src_x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>src_y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>width</td><td class=argvalue>horizontal size of pixel region to copy</td></tr>
<tr><td class=argname>height</td><td class=argvalue>vertical size of pixel region to copy</td></tr>
<tr><td class=argname>dest_x</td><td class=argvalue>horizontal destination pixel location</td></tr>
<tr><td class=argname>dest_y</td><td class=argvalue>vertical destination pixel location</td></tr>
<tr><td class=argname>src_buffer</td><td class=argvalue>valid graphics buffer</td></tr>
<tr><td class=argname>dest_buffer</td><td class=argvalue>valid graphics buffer</td></tr>
</table>
</p>
<p>
If src_buffer and dest_buffer are not specified <a href=#bbcopyrect>bbCopyRect</a> uses
the current graphics buffer, see <a href=#bbsetbuffer>bbSetBuffer</a> for more details.
</p>
See Also: <a href=#bbcopypixel>bbCopyPixel</a>
EndRem
Function CopyRect(src_x,src_y,width,height,dest_x,dest_y,src_buffer=0,dest_buffer=0)="bbCopyRect"

Rem
bbdoc: <p> <a href=#bblockbuffer>bbLockBuffer</a> locks the specified graphics buffer.
about:
<table class="arg">
<tr><td class=argname>buffer</td><td class=argvalue>any valid graphics buffer</td></tr>
</table>
</p>
<p>
High speed pixel functions such as <a href=#bbreadpixelfast>bbReadPixelFast</a>, <a href=#bbwritepixelfast>bbWritePixelFast</a>
and <a href=#bbcopypixelfast>bbCopyPixelFast</a> require the graphics buffer be in a locked state.
</p>
<p>
<a href=#bbunlockbuffer>bbUnlockBuffer</a> must be used once the high speed pixel manipulation
is complete.
</p>
<p>
Standard drawing commands should not be issued when a buffer is in
a locked state.
</p>
<p>
See the other commands for more
information.
</p>
See Also: <a href=#bbunlockbuffer>bbUnlockBuffer</a> <a href=#bbreadpixelfast>bbReadPixelFast</a> <a href=#bbwritepixelfast>bbWritePixelFast</a> <a href=#bbcopypixelfast>bbCopyPixelFast</a>
EndRem
Function LockBuffer(buffer=0)="bbLockBuffer"

Rem
bbdoc: <p> <a href=#bbunlockbuffer>bbUnlockBuffer</a> must be used once the high speed pixel manipulation is complete on a locked buffer.
about:
<table class="arg">
<tr><td class=argname>buffer</td><td class=argvalue>any valid locked graphics buffer</td></tr>
</table>
</p>
<p>
See <a href=#bblockbuffer>bbLockBuffer</a> for more information.
</p>
See Also: <a href=#bblockbuffer>bbLockBuffer</a> <a href=#bbreadpixelfast>bbReadPixelFast</a> <a href=#bbwritepixelfast>bbWritePixelFast</a> <a href=#bbcopypixelfast>bbCopyPixelFast</a>
EndRem
Function UnlockBuffer(buffer=0)="bbUnlockBuffer"

Rem
bbdoc: <p> <a href=#bbreadpixelfast>bbReadPixelFast</a> is similar in function to <a href=#bbreadpixel>bbReadPixel</a> but the buffer must be locked with the <a href=#bblockbuffer>bbLockBuffer</a> command and no bounds checking is performed in the interests of speed.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>buffer</td><td class=argvalue>valid graphics buffer</td></tr>
</table>
</p>
<p>
Warning: like <a href=#bbwritepixelfast>bbWritePixelFast</a> extreme care must be taken to ensure
the pixel position specified falls inside the specified buffers
area to avoid crashing the computer.
</p>
See Also: <a href=#bbreadpixel>bbReadPixel</a> <a href=#bblockbuffer>bbLockBuffer</a> <a href=#bbunlockbuffer>bbUnlockBuffer</a> <a href=#bbwritepixelfast>bbWritePixelFast</a>
EndRem
Function ReadPixelFast(x,y,buffer=0)="bbReadPixelFast"

Rem
bbdoc: <p> <a href=#bbwritepixelfast>bbWritePixelFast</a> is similar in function to <a href=#bbreadpixel>bbReadPixel</a> but the buffer must be locked with the <a href=#bblockbuffer>bbLockBuffer</a> command and no bounds checking is performed in the interests of speed.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>color</td><td class=argvalue>binary packed color value</td></tr>
<tr><td class=argname>buffer</td><td class=argvalue>valid graphics buffer</td></tr>
</table>
</p>
<p>
Warning: like <a href=#bbreadpixelfast>bbReadPixelFast</a> extreme care must be taken to ensure
the pixel position specified falls inside the specified buffers
area to avoid crashing the computer.
</p>
See Also: <a href=#bbwritepixel>bbWritePixel</a> <a href=#bblockbuffer>bbLockBuffer</a> <a href=#bbunlockbuffer>bbUnlockBuffer</a> <a href=#bbreadpixelfast>bbReadPixelFast</a>
EndRem
Function WritePixelFast(x,y,color,buffer=0)="bbWritePixelFast"

Rem
bbdoc: <p> <a href=#bbcopypixelfast>bbCopyPixelFast</a> is similar in function to <a href=#bbcopypixel>bbCopyPixel</a> but the buffer must be locked with the <a href=#bblockbuffer>bbLockBuffer</a> command and no bounds checking is performed in the interests of speed.
about:
<table class="arg">
<tr><td class=argname>src_x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>src_y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>src_buffer</td><td class=argvalue>valid graphics buffer to read from</td></tr>
<tr><td class=argname>dest_x</td><td class=argvalue>horizontal pixel location</td></tr>
<tr><td class=argname>dest_y</td><td class=argvalue>vertical pixel location</td></tr>
<tr><td class=argname>dest_buffer</td><td class=argvalue>valid graphics buffer to write to</td></tr>
</table>
</p>
<p>
Warning: like <a href=#bbreadpixelfast>bbReadPixelFast</a> extreme care must be taken to ensure
the pixel position specified falls inside the specified buffers
area to avoid crashing the computer.
</p>
See Also: <a href=#bbcopypixel>bbCopyPixel</a> <a href=#bbreadpixelfast>bbReadPixelFast</a> <a href=#bbwritepixelfast>bbWritePixelFast</a>
EndRem
Function CopyPixelFast(src_x,src_y,src_buffer,dest_x,dest_y,dest_buffer=0)="bbCopyPixelFast"

Rem
bbdoc: <p> The <a href=#bbcountgfxmodes>bbCountGfxModes</a> function returns the number of graphics modes supported by the current graphics driver.
about:
</p>
<p>
Use the <a href=#bbgfxmodewidth>bbGfxModeWidth</a>, <a href=#bbgfxmodeheight>bbGfxModeHeight</a> and <a href=#bbgfxmodedepth>bbGfxModeDepth</a> to obtain
information about each mode for use with the <a href=#bbgraphics>bbGraphics</a> command.
</p>
<p>
Legal graphics modes for these functions are numbered from 1 up
to and including the value returned by <a href=#bbcountgfxmodes>bbCountGfxModes</a>.
</p>
<p class="hint">
Use <a href=#bbcountgfxmodes3d>bbCountGfxModes3D</a>() instead if <a href=#bbgraphics3d>bbGraphics3D</a> use is required as older
hardware may support 3D acceleration on only a subset of its video modes.
</p>
See Also: <a href=#bbgfxmodewidth>bbGfxModeWidth</a> <a href=#bbgfxmodeheight>bbGfxModeHeight</a> <a href=#bbgfxmodedepth>bbGfxModeDepth</a> <a href=#bbgraphics>bbGraphics</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a> <a href=#bbcountgfxmodes3d>bbCountGfxModes3D</a>
EndRem
Function CountGfxModes()="bbCountGfxModes"

Rem
bbdoc: <p> Returns the width in pixels of the specified graphics mode where mode is a value from 1 up to and including the result of the CountGfxModes() Function.
about:
</p>
See Also: <a href=#bbcountgfxmodes>bbCountGfxModes</a> <a href=#bbgfxmodeheight>bbGfxModeHeight</a> <a href=#bbgfxmodedepth>bbGfxModeDepth</a>
EndRem
Function GfxModeWidth(mode)="bbGfxModeWidth"

Rem
bbdoc: <p> Returns the height in pixels of the specified graphics mode where mode is a value from 1 up to and including the result of the CountGfxModes() Function.
about:
</p>
See Also: <a href=#bbcountgfxmodes>bbCountGfxModes</a> <a href=#bbgfxmodeheight>bbGfxModeHeight</a> <a href=#bbgfxmodedepth>bbGfxModeDepth</a>
EndRem
Function GfxModeHeight(mode)="bbGfxModeHeight"

Rem
bbdoc: <p> Returns the depth in pixels of the specified graphics mode where mode is a value from 1 up to and including the result of the CountGfxModes() Function.
about:
</p>
See Also: <a href=#bbcountgfxmodes>bbCountGfxModes</a> <a href=#bbgfxmodeheight>bbGfxModeHeight</a> <a href=#bbgfxmodedepth>bbGfxModeDepth</a>
EndRem
Function GfxModeDepth(mode)="bbGfxModeDepth"

Rem
bbdoc: <p> Returns True if the resolution specified is supported by the current graphics driver
about:
<table class="arg">
<tr><td class=argname>width</td><td class=argvalue>width in pixels</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height in pixels</td></tr>
<tr><td class=argname>depth</td><td class=argvalue>color depth in bits</td></tr>
</table>
Calling <a href=#bbgraphics>bbGraphics</a> with settings that
cause this function to return False
to halt.
</p>
<p>
For more information see <a href=#bbgraphics>bbGraphics</a>.
</p>
<p>
For an alternative method for verifying legal resolutions
see the <a href=#bbcountgfxmodes>bbCountGfxModes</a> function.
</p>
See Also: <a href=#bbgraphics>bbGraphics</a> <a href=#bbcountgfxmodes>bbCountGfxModes</a>
EndRem
Function GfxModeExists(width,height,depth)="bbGfxModeExists"

Rem
bbdoc: <p> <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a> returns the number of graphcis drivers connected to the system.
about:
</p>
<p>
The <a href=#bbsetgfxdriver>bbSetGfxDriver</a> command is used to change the current graphics driver.
</p>
<p>
A return value of larger than 1 means a secondary monitor is present
and your program may wish to give the user an option for it to be used
for the purposes of playing your game.
</p>
See Also: <a href=#bbgfxdrivername>bbGfxDriverName</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a>
EndRem
Function CountGfxDrivers()="bbCountGfxDrivers"

Rem
bbdoc: <p> The <a href=#bbgfxdrivername>bbGfxDriverName</a> function returns the name of the graphics driver at the specified index.
about:
<table class="arg">
<tr><td class=argname>index</td><td class=argvalue>index number of display device</td></tr>
</table>
</p>
<p>
The index parameter should be in the range of 1 up to and
including the value returned by <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a>.
</p>
See Also: <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a>
EndRem
Function GfxDriverName$z(index)="bbGfxDriverName"

Rem
bbdoc: <p> The <a href=#bbsetgfxdriver>bbSetGfxDriver</a> command is used to change the current graphics driver.
about:
<table class="arg">
<tr><td class=argname>index</td><td class=argvalue>index number of display device</td></tr>
</table>
</p>
<p>
The current graphics driver dictates which display device is used on
a multimonitor system when the <a href=#bbgraphics>bbGraphics</a> command is used. It also
affects the graphics modes reported by <a href=#bbcountgfxmodes>bbCountGfxModes</a>.
</p>
<p>
The index parameter should be in the range of 1 up to and
including the value returned by <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a>.
</p>
See Also: <a href=#bbgraphics>bbGraphics</a> <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a> <a href=#bbcountgfxmodes>bbCountGfxModes</a>
EndRem
Function SetGfxDriver(index)="bbSetGfxDriver"

Rem
bbdoc: <p> If successful returns the handle of a sound object to be used with the <a href=#bbplaysound>bbPlaySound</a> command.
about:
<table class="arg">
<tr><td class=argname>filename$</td><td class=argvalue>the name of an existing sound file</td></tr>
</table>
</p>
<p>
The following file formats are supported:
</p>
<table class="data">
<tr><th class=data>Format</th><th class=data>Compression</th><th class=data>Features</th></tr>
<tr><td class=data>wav</td><td class=data>none</td><td class=data>fast loading</td></tr>
<tr><td class=data>mp3</td><td class=data>yes</td><td class=data>license required</td></tr>
<tr><td class=data>ogg</td><td class=data>yes</td><td class=data>license free</td></tr>
</table>
<p>
The reader should be aware that an additional license is
required to distribute software that utilizes playback of
mp3 files.
</p>
See Also: <a href=#bbplaysound>bbPlaySound</a> <a href=#bbloopsound>bbLoopSound</a> <a href=#bbfreesound>bbFreeSound</a>
EndRem
Function LoadSound(filename$z)="bbLoadSound"

Rem
bbdoc: <p> Returns the channel allocated for playback.
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>valid sound handle</td></tr>
</table>
</p>
<p>
<a href=#bbplaysound>bbPlaySound</a> plays a sound previously loaded using the <a href=#bbloadsound>bbLoadSound</a> command.
</p>
<p>
The channel handle returned can subsequently be used to control
the playback of the sound sample specified.
</p>
<p>
The initial volume and pitch of the sound may be modified before
playback using the <a href=#bbsoundvolume>bbSoundVolume</a> and <a href=#bbsoundpitch>bbSoundPitch</a> commands.
</p>
See Also: <a href=#bbchannelplaying>bbChannelPlaying</a> <a href=#bbstopchannel>bbStopChannel</a> <a href=#bbpausechannel>bbPauseChannel</a> <a href=#bbresumechannel>bbResumeChannel</a> <a href=#bbchannelpitch>bbChannelPitch</a>
EndRem
Function PlaySound(sound)="bbPlaySound"

Rem
bbdoc: <p> The <a href=#bbfreesound>bbFreeSound</a> command releases the resources used by a sound created by a previous call to <a href=#bbloadsound>bbLoadSound</a>.
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>valid sound handle</td></tr>
</table>
</p>
<p>
Usually a program will load all its sound files at startup
and let Blitz3D automatically free the resources when the
program ends.
</p>
<p>
The <a href=#bbfreesound>bbFreeSound</a> command however provides a way of managing
system resources when large sound files are no longer needed
by a running program.
</p>
See Also: <a href=#bbloadsound>bbLoadSound</a>
EndRem
Function FreeSound(sound)="bbFreeSound"

Rem
bbdoc: <p> Enables a sound objects looping property
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>valid sound handle</td></tr>
</table>
Subsequent playback
of the sound object using <a href=#bbplaysound>bbPlaySound</a> will result in continuous
looped playback of the sound.
</p>
See Also: <a href=#bbloadsound>bbLoadSound</a> <a href=#bbplaysound>bbPlaySound</a>
EndRem
Function LoopSound(sound)="bbLoopSound"

Rem
bbdoc: <p> Modifies the pitch of an existing sound object by changing its playback rate.
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>valid sound handle</td></tr>
<tr><td class=argname>samplerate</td><td class=argvalue>playback rate in samples per second</td></tr>
</table>
</p>
<p>
Sounds are commonly recorded at rates such as 22050 and 44100
samples per second and their playback rate defaults to the
recorded rate.
</p>
<p>
Changing the sounds playback rate with the <a href=#bbsoundpitch>bbSoundPitch</a> command
will modify the pitch at which it is next played with the
<a href=#bbplaysound>bbPlaySound</a> command.
</p>
<p>
For more dynamic control see the <a href=#bbchannelpitch>bbChannelPitch</a> command that
allows modifying the pitch of a channel during playback of
a sound.
</p>
See Also: <a href=#bbsoundvolume>bbSoundVolume</a> <a href=#bbplaysound>bbPlaySound</a>
EndRem
Function SoundPitch(sound,samplerate)="bbSoundPitch"

Rem
bbdoc: <p> Modifies the default volume of an existing sound object by changing its amplitude setting.
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>valid sound handle</td></tr>
<tr><td class=argname>volume#</td><td class=argvalue>amplitude setting</td></tr>
</table>
</p>
<p>
The default volume of a sound returned by <a href=#bbloadsound>bbLoadSound</a> is 1.0.
</p>
<p>
Use values between 0.0 and 1.0 to cause <a href=#bbplaysound>bbPlaySound</a> to begin
playback of the specified sound at a quieter volume and values
greater than 1.0 for their volume to be amplified.
</p>
<p>
Use the <a href=#bbchannelvolume>bbChannelVolume</a> command to modify volumes during sound
playback.
</p>
EndRem
Function SoundVolume(sound,volume#)="bbSoundVolume"

Rem
bbdoc: <p> Modifies the default balance of an existing sound object by changing its pan setting.
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>valid sound handle</td></tr>
<tr><td class=argname>pan#</td><td class=argvalue>stereo position</td></tr>
</table>
</p>
<p>
The <b>pan</b> value can be any float between -1.0 and 1.0 and
modifies the stereo position used the next time the sound
is played using the <a href=#bbplaysound>bbPlaySound</a> command.
</p>
<table class="data">
<tr><th class=data>Pan Value</th><th class=data>Effect</th></tr>
<tr><td class=data>-1</td><td class=data>sound played through left speaker</td></tr>
<tr><td class=data>0</td><td class=data>sound played through both speakers</td></tr>
<tr><td class=data>1</td><td class=data>sound played through right speaker</td></tr>
</table>
<p>
Use the <a href=#bbchannelpan>bbChannelPan</a> command to pan the sound during playback.
</p>
See Also: <a href=#bbplaysound>bbPlaySound</a> <a href=#bbchannelpan>bbChannelPan</a>
EndRem
Function SoundPan(sound,pan#)="bbSoundPan"

Rem
bbdoc: <p> Returns a valid channel handle or 0 if unsuccessful.
about:
<table class="arg">
<tr><td class=argname>filename$</td><td class=argvalue>name of music file</td></tr>
</table>
</p>
<p>
<a href=#bbplaymusic>bbPlayMusic</a> opens the music file specified and begins
playback.
</p>
<p>
Unlike a combination of <a href=#bbloadsound>bbLoadSound</a> and <a href=#bbplaysound>bbPlaySound</a>, <a href=#bbplaymusic>bbPlayMusic</a>
allocates only a small buffer of resources and the music
file is streamed directly from the file.
</p>
<table class="data">
<tr><th class=data>Format</th><th class=data>FileSize</th><th class=data>Features</th></tr>
<tr><td class=data>raw;wav</td><td class=data>large</td><td class=data>industry standard uncompressed</td></tr>
<tr><td class=data>mod;s3m;xm;it</td><td class=data>medium</td><td class=data>8 channel module files</td></tr>
<tr><td class=data>mid</td><td class=data>small</td><td class=data>midi files depend on the system's music synthesizer</td></tr>
<tr><td class=data>mp3</td><td class=data>medium</td><td class=data>requires additional license</td></tr>
<tr><td class=data>ogg;wma;asf</td><td class=data>medium</td><td class=data>compressed and freely distributable</td></tr>
</table>
<p>
The channel handle returned can be used to change various
playback settings including volume, pitch as well as
pause and resume playback itself.
</p>
See Also: <a href=#bbstopchannel>bbStopChannel</a> <a href=#bbpausechannel>bbPauseChannel</a> <a href=#bbresumechannel>bbResumeChannel</a> <a href=#bbplaysound>bbPlaySound</a>
EndRem
Function PlayMusic(filename$z)="bbPlayMusic"

Rem
bbdoc: <p> Plays a CD track and returns a sound channel.
about:
<table class="arg">
<tr><td class=argname>track</td><td class=argvalue>track number to play</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>playback mode</td></tr>
</table>
</p>
<p>
The behavior of the <a href=#bbplaycdtrack>bbPlayCDTrack</a> may be modified
with the optional <b>mode</b> parameter:
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>PLAYCD_SINGLE</td><td class=data>1</td><td class=data>play track once - default</td></tr>
<tr><td class=data>PLAYCD_LOOP</td><td class=data>2</td><td class=data>loop track</td></tr>
<tr><td class=data>PLAYCD_ALL</td><td class=data>3</td><td class=data>play track once then continue to next track</td></tr>
</table>
<p>
The <a href=#bbplaycdtrack>bbPlayCDTrack</a> requires the user has a CD playback
facility on their system and that a CD containing
music tracks is currently inserted.
</p>
See Also: <a href=#bbstopchannel>bbStopChannel</a> <a href=#bbpausechannel>bbPauseChannel</a> <a href=#bbresumechannel>bbResumeChannel</a>
EndRem
Function PlayCDTrack(track,mode=1)="bbPlayCDTrack"

Rem
bbdoc: <p> Stop any audio being output on a currently playing channel.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
</table>
</p>
<p>
The <a href=#bbplaysound>bbPlaySound</a>, <a href=#bbplaymusic>bbPlayMusic</a> and <a href=#bbplaycdtrack>bbPlayCDTrack</a> functions all return
a channel handle that can be used with <a href=#bbstopchannel>bbStopChannel</a> to cancel the
resulting sound playback.
</p>
See Also: <a href=#bbplaysound>bbPlaySound</a> <a href=#bbplaymusic>bbPlayMusic</a> <a href=#bbplaycdtrack>bbPlayCDTrack</a> <a href=#bbpausechannel>bbPauseChannel</a>
EndRem
Function StopChannel(channel)="bbStopChannel"

Rem
bbdoc: <p> Pauses playback in the specified audio channel.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
</table>
</p>
<p>
Any sound playing from the result of a <a href=#bbplaysound>bbPlaySound</a>, <a href=#bbplaymusic>bbPlayMusic</a>
or <a href=#bbplaycdtrack>bbPlayCDTrack</a> may be paused with the <a href=#bbpausechannel>bbPauseChannel</a> command.
</p>
<p>
Use the <a href=#bbresumechannel>bbResumeChannel</a> command to continue playback after
pausing an audio channel with <a href=#bbpausechannel>bbPauseChannel</a>.
</p>
See Also: <a href=#bbresumechannel>bbResumeChannel</a> <a href=#bbstopchannel>bbStopChannel</a> <a href=#bbplaysound>bbPlaySound</a>
EndRem
Function PauseChannel(channel)="bbPauseChannel"

Rem
bbdoc: <p> Continue playback of a previously paused audio channel.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
</table>
</p>
EndRem
Function ResumeChannel(channel)="bbResumeChannel"

Rem
bbdoc: <p> Modifies the pitch of an active audio channel by changing its playback rate.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
<tr><td class=argname>samplerate</td><td class=argvalue>playback rate in samples per second</td></tr>
</table>
</p>
<p>
Sound sources are commonly recorded at rates such as 22050
and 44100 samples per second and their playback rate defaults
to the recorded rate.
</p>
<p>
Changing a channel's playback rate with the <a href=#bbchannelpitch>bbChannelPitch</a> command
will modify the pitch of the recorded audio currently used as
a playback source.
</p>
See Also: <a href=#bbloadsound>bbLoadSound</a> <a href=#bbsoundpitch>bbSoundPitch</a>
EndRem
Function ChannelPitch(channel,samplerate)="bbChannelPitch"

Rem
bbdoc: <p> Modifies the amplitude of the specified audio channel.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
<tr><td class=argname>volume#</td><td class=argvalue>volume level</td></tr>
</table>
</p>
<p>
A floating point of less than 1.0 will reduce volume
while a value of larger than 1.0 will increase the volume
of the specified channel.
</p>
<p>
Increasing a channel volume above 1.0 should not be
attempted if distortion and clamping of the audio output
is to be avoided.
</p>
<p>
To make a channel silent use <a href=#bbstopchannel>bbStopChannel</a> or <a href=#bbpausechannel>bbPauseChannel</a>
as an alternative to a volume setting of 0.0.
</p>
See Also: <a href=#bbsoundvolume>bbSoundVolume</a>
EndRem
Function ChannelVolume(channel,volume#)="bbChannelVolume"

Rem
bbdoc: <p> Position the output of an audio channel in left right stereo space.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
<tr><td class=argname>pan#</td><td class=argvalue>left right stereo position</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Effective pan</th></tr>
<tr><td class=data>0.0</td><td class=data>Left</td></tr>
<tr><td class=data>0.25</td><td class=data>Center Left</td></tr>
<tr><td class=data>0.5</td><td class=data>Center</td></tr>
<tr><td class=data>0.75</td><td class=data>Center Right</td></tr>
<tr><td class=data>1.0</td><td class=data>Right</td></tr>
</table>
<p>
Panning the position of sound effects in a video game is a
useful technique for adding to the immersive experience.
</p>
EndRem
Function ChannelPan(channel,pan#)="bbChannelPan"

Rem
bbdoc: <p> Returns True mode.
about:
<table class="arg">
<tr><td class=argname>channel</td><td class=argvalue>valid playback channel</td></tr>
</table>
</p>
See Also: <a href=#bbplaysound>bbPlaySound</a> <a href=#bbpausechannel>bbPauseChannel</a> <a href=#bbstopchannel>bbStopChannel</a>
EndRem
Function ChannelPlaying(channel)="bbChannelPlaying"

Rem
bbdoc: <p> Locates and starts a movie file playing.
about:
<table class="arg">
<tr><td class=argname>moviefile$</td><td class=argvalue>filename of a movie file</td></tr>
</table>
</p>
<p>
Returns a valid movie handle if the function is successful
or 0 if the command fails for any reason.
</p>
<p>
Use the <a href=#bbdrawmovie>bbDrawMovie</a> command to see the movie playing.
</p>
<p>
Movie files will typically have the AVI, MPEG and MPG
file extensions.
</p>
<p>
Blitz3D applications may need to specify DirectX8
requirements or the installation of a particular
version of Window's media  player software if they
are to support movie files using codecs other than
MPEG1, CinePak, MotionJPEG and the like.
</p>
See Also: <a href=#bbdrawmovie>bbDrawMovie</a> <a href=#bbclosemovie>bbCloseMovie</a> <a href=#bbmovieplaying>bbMoviePlaying</a> <a href=#bbmoviewidth>bbMovieWidth</a> <a href=#bbmovieheight>bbMovieHeight</a>
EndRem
Function OpenMovie(moviefile$z)="bbOpenMovie"

Rem
bbdoc: <p> Stops and closes an open movie.
about:
<table class="arg">
<tr><td class=argname>movie</td><td class=argvalue>valid open movie file</td></tr>
</table>
</p>
See Also: <a href=#bbopenmovie>bbOpenMovie</a>
EndRem
Function CloseMovie(movie)="bbCloseMovie"

Rem
bbdoc: <p> Draws the current frame of the specified playing movie onto the current graphics buffer.
about:
<table class="arg">
<tr><td class=argname>movie</td><td class=argvalue>movie handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>horizontal position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical position</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width of movie in pixels</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of movie in pixels</td></tr>
</table>
</p>
<p>
The movie must not overlap the edges of the current graphics
buffer or else nothing is drawn.
</p>
<p>
The Viewport and Origin are not taken into account.
</p>
<p>
See the <a href=#bbopenmovie>bbOpenMovie</a> command for more details regarding supported
movie files and how to open them before using the <a href=#bbdrawmovie>bbDrawMovie</a>
command.
</p>
See Also: <a href=#bbopenmovie>bbOpenMovie</a> <a href=#bbclosemovie>bbCloseMovie</a> <a href=#bbmovieplaying>bbMoviePlaying</a> <a href=#bbmoviewidth>bbMovieWidth</a> <a href=#bbmovieheight>bbMovieHeight</a>
EndRem
Function DrawMovie(movie,x,y,width,height=0)="bbDrawMovie"

Rem
bbdoc: <p> Returns the width of a movie.
about:
<table class="arg">
<tr><td class=argname>movie</td><td class=argvalue>movie handle</td></tr>
</table>
</p>
See Also: <a href=#bbopenmovie>bbOpenMovie</a> <a href=#bbdrawmovie>bbDrawMovie</a> <a href=#bbclosemovie>bbCloseMovie</a> <a href=#bbmovieplaying>bbMoviePlaying</a> <a href=#bbmovieheight>bbMovieHeight</a>
EndRem
Function MovieWidth(movie)="bbMovieWidth"

Rem
bbdoc: <p> Returns the height of a movie.
about:
<table class="arg">
<tr><td class=argname>movie</td><td class=argvalue>movie handle</td></tr>
</table>
</p>
See Also: <a href=#bbopenmovie>bbOpenMovie</a> <a href=#bbdrawmovie>bbDrawMovie</a> <a href=#bbclosemovie>bbCloseMovie</a> <a href=#bbmovieplaying>bbMoviePlaying</a> <a href=#bbmoviewidth>bbMovieWidth</a>
EndRem
Function MovieHeight(movie)="bbMovieHeight"

Rem
bbdoc: <p> Returns True if the specified movie is playing.
about:
<table class="arg">
<tr><td class=argname>movie</td><td class=argvalue>movie handle</td></tr>
</table>
</p>
See Also: <a href=#bbopenmovie>bbOpenMovie</a> <a href=#bbdrawmovie>bbDrawMovie</a> <a href=#bbclosemovie>bbCloseMovie</a> <a href=#bbmoviewidth>bbMovieWidth</a> <a href=#bbmovieheight>bbMovieHeight</a>
EndRem
Function MoviePlaying(movie)="bbMoviePlaying"

Rem
bbdoc: <p> Returns an ascii code corresponding to the key last typed by the user or 0 if all keyboard events have been reported.
about:
</p>
<p>
As Blitz uses an internal queue for tracking key presses it is
sometimes useful to call <a href=#bbgetkey>bbGetKey</a> multiple times to empty the
queue. Use the <a href=#bbflushkeys>bbFlushKeys</a> command to completely empty the internal
key queue.
</p>
<p>
The <a href=#bbgetkey>bbGetKey</a> function is useful for situations when the user is
expected to type some text.
</p>
<p>
The <a href=#bbkeydown>bbKeyDown</a> function is more appropriate when the player is
expected to hold down certain key combinations in a more
action oriented game environment.
</p>
See Also: <a href=#bbkeydown>bbKeyDown</a> <a href=#bbwaitkey>bbWaitKey</a> <a href=#bbflushkeys>bbFlushKeys</a>
EndRem
Function GetKey()="bbGetKey"

Rem
bbdoc: <p> Waits for a keystroke and returns the ascii code corresponding to the key pressed.
about:
</p>
<p>
<a href=#bbwaitkey>bbWaitKey</a> is similar in behavior to the <a href=#bbgetkey>bbGetKey</a> function but pauses
program execution until a keystroke is made by the user.
</p>
See Also: <a href=#bbgetkey>bbGetKey</a> <a href=#bbchr>bbChr</a>
EndRem
Function WaitKey()="bbWaitKey"

Rem
bbdoc: <p> Returns True being pressed.
about:
<table class="arg">
<tr><td class=argname>scancode</td><td class=argvalue>scancode of key to test</td></tr>
</table>
</p>
<p>
Note that keyboard scan codes relate to the physical position of a key
on the keyboard and should not be confused with ascii character codes.
</p>
<p class="hint">
There are physical limitations regarding the rows and columns
of some physical keyboards that will not report certain key
combinations. It is advisable to thoroughly test all default
scancode combinations that a game may provide for keyboard
control.
</p>
See Also: <a href=#bbkeyboardscancodes>bbKeyboardScancodes</a> <a href=#bbkeyhit>bbKeyHit</a>
EndRem
Function KeyDown(scancode)="bbKeyDown"

Rem
bbdoc: <p> Returns the number of times the specified key has been pressed since the last time the <a href=#bbkeyhit>bbKeyHit</a> command was called with the specified scancode.
about:
<table class="arg">
<tr><td class=argname>scancode</td><td class=argvalue>scancode of key to test</td></tr>
</table>
</p>
<p>
<a href=#bbkeyhit>bbKeyHit</a> will only return positive once when a key is pressed where as
<a href=#bbkeydown>bbKeyDown</a> will repeatedly return True until the specified key is released.
</p>
See Also: <a href=#bbkeyboardscancodes>bbKeyboardScancodes</a> <a href=#bbkeydown>bbKeyDown</a> <a href=#bbgetkey>bbGetKey</a> <a href=#bbwaitkey>bbWaitKey</a> <a href=#bbflushkeys>bbFlushKeys</a>
EndRem
Function KeyHit(scancode)="bbKeyHit"

Rem
bbdoc: <p> Resets the state of the internal keyboard map so all keys are considered up.
about:
</p>
See Also: <a href=#bbkeyhit>bbKeyHit</a> <a href=#bbkeydown>bbKeyDown</a>
EndRem
Function FlushKeys()="bbFlushKeys"

Rem
bbdoc: <p> Returns the horizontal display position of the mouse pointer.
about:
</p>
See Also: <a href=#bbmousey>bbMouseY</a> <a href=#bbmousez>bbMouseZ</a>
EndRem
Function MouseX()="bbMouseX"

Rem
bbdoc: <p> Returns the vertical display position of the mouse pointer.
about:
</p>
See Also: <a href=#bbmousex>bbMouseX</a> <a href=#bbmousez>bbMouseZ</a>
EndRem
Function MouseY()="bbMouseY"

Rem
bbdoc: <p> Returns the mouse wheel position if present.
about:
</p>
<p>
The value returned by <a href=#bbmousez>bbMouseZ</a> increases as the user scrolls
the wheel up (away from them) and decreases when the user
scrolls the wheel down (towards them).
</p>
See Also: <a href=#bbmousex>bbMouseX</a> <a href=#bbmousey>bbMouseY</a>
EndRem
Function MouseZ()="bbMouseZ"

Rem
bbdoc: <p> The <a href=#bbmousedown>bbMouseDown</a> function returns True is currently being pressed.
about:
<table class="arg">
<tr><td class=argname>button</td><td class=argvalue>1,2 or 3 (left, right or middle)</td></tr>
</table>
</p>
<p>
Similar to <a href=#bbkeydown>bbKeyDown</a> a corresponding <a href=#bbmousehit>bbMouseHit</a> command is available
that will return True
button is being pressed.
</p>
See Also: <a href=#bbmousehit>bbMouseHit</a>
EndRem
Function MouseDown(button)="bbMouseDown"

Rem
bbdoc: <p> The <a href=#bbmousehit>bbMouseHit</a> function returns the number of times the specified mouse button has been pressed down since the last call to <a href=#bbmousehit>bbMouseHit</a> with the specified button.
about:
<table class="arg">
<tr><td class=argname>button</td><td class=argvalue>1,2 or 3 (left, right or middle)</td></tr>
</table>
</p>
<p>
Use the <a href=#bbmousedown>bbMouseDown</a> command to test if the specified button is
currently in a depressed state as opposed to if the button has
just been hit.
</p>
See Also: <a href=#bbmousedown>bbMouseDown</a>
EndRem
Function MouseHit(button)="bbMouseHit"

Rem
bbdoc: <p> Returns the mouse button pressed since the last call to <a href=#bbgetmouse>bbGetMouse</a> or 0 if none.
about:
</p>
<p>
<a href=#bbgetmouse>bbGetMouse</a> will return 1 if the left button, 2 if the right and
3 if the middle button has been recently pressed.
</p>
<p>
Mouse button presses are queued internally by Blitz so it is often
useful to call <a href=#bbgetmouse>bbGetMouse</a> repeatedly to empty the queue or use the
<a href=#bbflushmouse>bbFlushMouse</a> command.
</p>
See Also: <a href=#bbflushmouse>bbFlushMouse</a> <a href=#bbmousedown>bbMouseDown</a>
EndRem
Function GetMouse()="bbGetMouse"

Rem
bbdoc: <p> <a href=#bbwaitmouse>bbWaitMouse</a> causes the program to halt until a mouse button is pressed by the user and returns the ID of that button.
about:
</p>
<p>
<a href=#bbwaitmouse>bbWaitMouse</a> will wait and return 1 for the left button, 2 for the right
and 3 for the middle button when pressed.
</p>
See Also: <a href=#bbgetmouse>bbGetMouse</a>
EndRem
Function WaitMouse()="bbWaitMouse"

Rem
bbdoc: <p> <a href=#bbshowpointer>bbShowPointer</a> displays the mouse pointer if previously hidden with the <a href=#bbhidepointer>bbHidePointer</a> command.
about:
</p>
<p>
Has no effect in FullScreen modes.
</p>
See Also: <a href=#bbhidepointer>bbHidePointer</a>
EndRem
Function ShowPointer()="bbShowPointer"

Rem
bbdoc: <p> <a href=#bbhidepointer>bbHidePointer</a> makes the mouse pointer invisible when moved over the program window when using <a href=#bbgraphics>bbGraphics</a> in windowed mode.
about:
</p>
<p>
The mouse pointer is always hidden in FullScreen <a href=#bbgraphics>bbGraphics</a> mode.
</p>
See Also: <a href=#bbshowpointer>bbShowPointer</a> <a href=#bbgraphics>bbGraphics</a>
EndRem
Function HidePointer()="bbHidePointer"

Rem
bbdoc: <p> The <b>x</b>, <b>y</b> parameters define a location on the graphics display that the mouse pointer is moved to.
about:
<table class="arg">
<tr><td class=argname>x</td><td class=argvalue>horizontal screen position</td></tr>
<tr><td class=argname>y</td><td class=argvalue>vertical screen position</td></tr>
</table>
</p>
<p>
By recentering the mouse to the middle of the display every
frame the <a href=#bbmousexspeed>bbMouseXSpeed</a> and <a href=#bbmouseyspeed>bbMouseYSpeed</a> functions can be used
to provide &quot;mouse look&quot; type control common in first person
shooters.
</p>
See Also: <a href=#bbmousexspeed>bbMouseXSpeed</a> <a href=#bbmouseyspeed>bbMouseYSpeed</a>
EndRem
Function MoveMouse(x,y)="bbMoveMouse"

Rem
bbdoc: <p> Returns the horizontal distance travelled by the mouse since the last call to <a href=#bbmousexspeed>bbMouseXSpeed</a> or <a href=#bbmovemouse>bbMoveMouse</a>.
about:
</p>
See Also: <a href=#bbmovemouse>bbMoveMouse</a> <a href=#bbmouseyspeed>bbMouseYSpeed</a>
EndRem
Function MouseXSpeed()="bbMouseXSpeed"

Rem
bbdoc: <p> Returns the vertical distance travelled by the mouse since the last call to <a href=#bbmouseyspeed>bbMouseYSpeed</a> or <a href=#bbmovemouse>bbMoveMouse</a>.
about:
</p>
See Also: <a href=#bbmovemouse>bbMoveMouse</a> <a href=#bbmousexspeed>bbMouseXSpeed</a>
EndRem
Function MouseYSpeed()="bbMouseYSpeed"

Rem
bbdoc: <p> Returns the number of clicks the mouse scroll wheel has been turned since the last call to <a href=#bbmousezspeed>bbMouseZSpeed</a>.
about:
</p>
<p>
The result is negative if the wheel is scrolled down (rolled
back) and positive if scrolled up (rolled forward).
</p>
EndRem
Function MouseZSpeed()="bbMouseZSpeed"

Rem
bbdoc: <p> Resets the state of the internal mouse button map so all buttons are considered up.
about:
</p>
EndRem
Function FlushMouse()="bbFlushMouse"

Rem
bbdoc: <p> Returns the type of joystick that is currently connected to the computer.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>JoyType</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>JOYTYPE_NONE</td><td class=data>0</td><td class=data>None</td></tr>
<tr><td class=data>JOYTYPE_DIGITAL</td><td class=data>1</td><td class=data>Digital</td></tr>
<tr><td class=data>JOYTYPE_ANALOG</td><td class=data>2</td><td class=data>Analog</td></tr>
</table>
<p>
The optional <b>port</b> identifier is required to index
all the joysticks, wheels and other gaming devices
connected to the system.
</p>
See Also: <a href=#bbgetjoy>bbGetJoy</a> <a href=#bbjoydown>bbJoyDown</a>
EndRem
Function JoyType(port=0)="bbJoyType"

Rem
bbdoc: <p> Returns the number of any button press that has not already been reported by the <a href=#bbgetjoy>bbGetJoy</a> command.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>optional joystick port to read</td></tr>
</table>
</p>
<p>
Returns 0 if the system button buffer is
empty.
</p>
<p>
The <a href=#bbgetjoy>bbGetJoy</a> command may be called multiple
times until it signals there are no more
button events queued by returning 0.
</p>
<p>
The optional port identifier provides access to a
particular game controller, joystick or gamepad connected
to the system and positively identified by <a href=#bbjoytype>bbJoyType</a>.
</p>
See Also: <a href=#bbjoytype>bbJoyType</a>
EndRem
Function GetJoy(port=0)="bbGetJoy"

Rem
bbdoc: <p> Returns True if the specified button of the specified joystick is pressed.
about:
<table class="arg">
<tr><td class=argname>button</td><td class=argvalue>number of joystick button to check</td></tr>
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
The optional port identifier provides access to a
particular game controller, joystick or gamepad connected
to the system and positively identified by <a href=#bbjoytype>bbJoyType</a>.
</p>
See Also: <a href=#bbjoyhit>bbJoyHit</a> <a href=#bbkeydown>bbKeyDown</a> <a href=#bbmousedown>bbMouseDown</a>
EndRem
Function JoyDown(button,port=0)="bbJoyDown"

Rem
bbdoc: <p> Returns the number of times a specified joystick button has been hit since the last time it was specified in a <a href=#bbjoyhit>bbJoyHit</a> function call.
about:
<table class="arg">
<tr><td class=argname>button</td><td class=argvalue>number of joystick button to check</td></tr>
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
The optional <b>port</b> identifier provides access to a
particular game controller, joystick or gamepad connected
to the system and positively identified by <a href=#bbjoytype>bbJoyType</a>.
</p>
See Also: <a href=#bbkeyhit>bbKeyHit</a> <a href=#bbmousehit>bbMouseHit</a>
EndRem
Function JoyHit(button,port=0)="bbJoyHit"

Rem
bbdoc: <p> Waits for any joystick button to be pressed and returns the button identifier.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>optional joystick port to pause for</td></tr>
</table>
</p>
<p>
<a href=#bbwaitjoy>bbWaitJoy</a> causes the program to pause until any button of the
specified joystick is pressed.
</p>
<p>
If there is no gaming device connected or the optional
port identifier is not a valid device <a href=#bbwaitjoy>bbWaitJoy</a>
will not pause but return 0 immediately.
</p>
See Also: <a href=#bbjoytype>bbJoyType</a>
EndRem
Function WaitJoy(port=0)="bbWaitJoy"

Rem
bbdoc: <p> Resets the state of the internal joystick button map so all buttons of all joysticks are considered up and all joystick events are discarded.
about:
</p>
<p>
<a href=#bbflushjoy>bbFlushJoy</a> is useful when transitioning from control
systems based on the state commands such as <a href=#bbjoydown>bbJoyDown</a>
to an event style control using the <a href=#bbgetjoy>bbGetJoy</a> command
and any buffered button presses need to be discarded.
</p>
See Also: <a href=#bbjoydown>bbJoyDown</a> <a href=#bbgetjoy>bbGetJoy</a>
EndRem
Function FlushJoy()="bbFlushJoy"

Rem
bbdoc: <p> Returns a compass angle between 0 and 360 degrees in which the direction of the D-Pad or &quot;hat&quot; control is being pressed.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
<a href=#bbjoyhat>bbJoyHat</a> returns a value of -1 if the &quot;hat&quot; or D-Pad is
currently centered.
</p>
<p>
The optional port identifier provides access to a
particular game controller, joystick or gamepad connected
to the system and positively identified by <a href=#bbjoytype>bbJoyType</a>.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyyaw>bbJoyYaw</a> <a href=#bbjoypitch>bbJoyPitch</a> <a href=#bbjoyroll>bbJoyRoll</a>
EndRem
Function JoyHat(port=0)="bbJoyHat"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the direction of the joystick in the horizontal axis.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
A value near 0.0 represents the joystick at rest position.
</p>
<p>
Due to the nature of analog joysticks <a href=#bbjoyx>bbJoyX</a> and the other
axis reading commands are unlikely to ever return an exact
value of 0.0 and so a tolerance factor may need to be applied
if a rest position is required.
</p>
<p>
The <a href=#bbjoyxdir>bbJoyXDir</a> command should be used instead of <a href=#bbjoyx>bbJoyX</a>
when only the digital state of the stick is required
(be it left, centered or right).
</p>
<p>
The optional port identifier provides access to a
particular game controller, joystick or gamepad connected
to the system and positively identified by <a href=#bbjoytype>bbJoyType</a>.
</p>
See Also: <a href=#bbjoyxdir>bbJoyXDir</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyhat>bbJoyHat</a>
EndRem
Function JoyX#(port=0)="bbJoyX"

Rem
bbdoc: <p> Returns an integer value of -1, 0 or 1 representing the horizontal direction of the joystick be it left, centered or right.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Direction</th></tr>
<tr><td class=data>-1</td><td class=data>left</td></tr>
<tr><td class=data>0</td><td class=data>centered</td></tr>
<tr><td class=data>1</td><td class=data>right</td></tr>
</table>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyudir>bbJoyUDir</a>
EndRem
Function JoyXDir(port=0)="bbJoyXDir"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the direction of the the joystick in the vertical axis.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyydir>bbJoyYDir</a> <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyv>bbJoyV</a>
EndRem
Function JoyY#(port=0)="bbJoyY"

Rem
bbdoc: <p> Returns an integer value of -1, 0 or 1 representing the vertical direction of the joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Direction</th></tr>
<tr><td class=data>-1</td><td class=data>up</td></tr>
<tr><td class=data>0</td><td class=data>centered</td></tr>
<tr><td class=data>1</td><td class=data>down</td></tr>
</table>
See Also: <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyxdir>bbJoyXDir</a> <a href=#bbjoyvdir>bbJoyVDir</a>
EndRem
Function JoyYDir(port=0)="bbJoyYDir"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the rotation axis of the joystick or steering wheel.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyv>bbJoyV</a>
EndRem
Function JoyZ#(port=0)="bbJoyZ"

Rem
bbdoc: <p> Returns an integer value of -1, 0 or 1 representing the rotation axis of the joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Direction</th></tr>
<tr><td class=data>-1</td><td class=data>anti-clockwise</td></tr>
<tr><td class=data>0</td><td class=data>centered</td></tr>
<tr><td class=data>1</td><td class=data>clockwise</td></tr>
</table>
See Also: <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyxdir>bbJoyXDir</a>
EndRem
Function JoyZDir(port=0)="bbJoyZDir"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the horizontal direction of the second stick of a dual stick joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyv>bbJoyV</a>
EndRem
Function JoyU#(port=0)="bbJoyU"

Rem
bbdoc: <p> Returns an integer value of -1, 0 or 1 representing the horizontal direction of the joystick's second stick be it left, centered or right.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Direction</th></tr>
<tr><td class=data>-1</td><td class=data>left</td></tr>
<tr><td class=data>0</td><td class=data>centered</td></tr>
<tr><td class=data>1</td><td class=data>right</td></tr>
</table>
See Also: <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyxdir>bbJoyXDir</a>
EndRem
Function JoyUDir(port=0)="bbJoyUDir"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the vertical direction of the second stick of a dual stick joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyyaw>bbJoyYaw</a> <a href=#bbjoypitch>bbJoyPitch</a> <a href=#bbjoyroll>bbJoyRoll</a>
EndRem
Function JoyV#(port=0)="bbJoyV"

Rem
bbdoc: <p> Returns an integer value of -1, 0 or 1 representing the vertical direction of the joystick's second stick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Direction</th></tr>
<tr><td class=data>-1</td><td class=data>up</td></tr>
<tr><td class=data>0</td><td class=data>centered</td></tr>
<tr><td class=data>1</td><td class=data>down</td></tr>
</table>
See Also: <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyxdir>bbJoyXDir</a>
EndRem
Function JoyVDir(port=0)="bbJoyVDir"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the yaw axis if present of the specified joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyyaw>bbJoyYaw</a> <a href=#bbjoypitch>bbJoyPitch</a> <a href=#bbjoyroll>bbJoyRoll</a>
EndRem
Function JoyYaw#(port=0)="bbJoyYaw"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the pitch axis if present of the specified joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyyaw>bbJoyYaw</a> <a href=#bbjoypitch>bbJoyPitch</a> <a href=#bbjoyroll>bbJoyRoll</a>
EndRem
Function JoyPitch#(port=0)="bbJoyPitch"

Rem
bbdoc: <p> Returns a value between -1.0 and 1.0 representing the roll axis if present of the specified joystick.
about:
<table class="arg">
<tr><td class=argname>port</td><td class=argvalue>number of joystick port to check (optional)</td></tr>
</table>
</p>
<p>
The roll axis of a joystick commonly refers to a joystick's
twistable stick or rudder feature.
</p>
<p>
See the <a href=#bbjoyx>bbJoyX</a> command for more details on using joystick
axis commands.
</p>
See Also: <a href=#bbjoyx>bbJoyX</a> <a href=#bbjoyy>bbJoyY</a> <a href=#bbjoyz>bbJoyZ</a> <a href=#bbjoyu>bbJoyU</a> <a href=#bbjoyyaw>bbJoyYaw</a> <a href=#bbjoypitch>bbJoyPitch</a> <a href=#bbjoyroll>bbJoyRoll</a>
EndRem
Function JoyRoll#(port=0)="bbJoyRoll"

Rem
bbdoc: <p> The <a href=#bbgraphics3d>bbGraphics3D</a> command resizes the Graphics display To the specified size in pixels And with the specified display properties including color depth And fullscreen options.
about:
<table class="arg">
<tr><td class=argname>width</td><td class=argvalue>width of screen resolution</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of screen resolution</td></tr>
<tr><td class=argname>depth</td><td class=argvalue>optional color depth For fullscreen modes</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>display mode of window created</td></tr>
</table>
</p>
<p>
This command is the same as the <a href=#bbgraphics>bbGraphics</a> command with the
additional feature that 3D programming is supported following
a succesful call To the <a href=#bbgraphics3d>bbGraphics3D</a> command.
</p>
<p>
A simple &quot;Graphics3D 640,480&quot; creates a window on the desktop
ready For 3D program development. Once your program is
running And debug mode has been disabled, the same command
opens a fullscreen display with standard VGA resolution
of 640 pixels wide by 480 pixels high.
</p>
<p>
The <b>depth</b> parameter is optional, the Default value of 0
specifies that Blitz3D Select the most appropriate color
depth.
</p>
<p>
The <b>mode</b> parameter may be any of the following values:
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>GFX_DEFAULT</td><td class=data>0</td><td class=data>Default selects FixedWindow in Debug mode Or FullScreen in Release</td></tr>
<tr><td class=data>GFX_FULLSCREEN</td><td class=data>1</td><td class=data>FullScreen acheives optimal performance by owning the display</td></tr>
<tr><td class=data>GFX_WINDOWED</td><td class=data>2</td><td class=data>FixedWindow opens a fixed size window placed on the desktop</td></tr>
<tr><td class=data>GFX_WINDOWEDSCALED</td><td class=data>3</td><td class=data>ScaledWindow opens a user sizable window with Graphics scaled To fit </td></tr>
</table>
<p>
Before using <a href=#bbgraphics3d>bbGraphics3D</a> the specified resolution Or support
For 3D in Windows should be confirmed with the use of the
<a href=#bbgfxmode3dexists>bbGfxMode3DExists</a> Or <a href=#bbwindowed3d>bbWindowed3D</a> functions respectively.
</p>
See Also: <a href=#bbgfxmode3dexists>bbGfxMode3DExists</a> <a href=#bbwindowed3d>bbWindowed3D</a> <a href=#bbendgraphics>bbEndGraphics</a> <a href=#bbgraphics>bbGraphics</a>
EndRem
Function Graphics3D(width,height,depth=0,mode=0)="bbGraphics3D"

Rem
bbdoc: <p> Enables or disables hardware dithering.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True to enable dithering</td></tr>
</table>
</p>
<p>
Only displays configured to use 16 bit color depth benefit from
dithering which attempts to reduce the course shading that lower
color resolutions often suffer.
</p>
<p>
The default is True.
</p>
EndRem
Function Dither(enable)="bbDither"

Rem
bbdoc: <p> Enables or disables w-buffering.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True
</table>
</p>
<p>
Often, 16 bit color depths on common graphics cards will result
in less accurate 16 bit depth buffers being used by the 3D
hardware.
</p>
<p>
W buffering is an alternative to Z buffering that is useful
for increasing depth sorting accuracy with such displays
where the accuracy of sorting distant pixels is reduced
in favour of closer pixels.
</p>
<p>
See the <a href=#bbcamerarange>bbCameraRange</a> command for more information
on contolling depth buffer performance
</p>
<p>
Defaults to True for 16 bit color mode.
</p>
See Also: <a href=#bbcamerarange>bbCameraRange</a>
EndRem
Function WBuffer(enable)="bbWBuffer"

Rem
bbdoc: <p> Enables or disables fullscreen antialiasing.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True to enable fullscreen antialiasing</td></tr>
</table>
</p>
<p>
Fullscreen antialiasing is a technique used to smooth out the entire screen,
so that jagged lines are made less noticeable.
</p>
<p>
AA rendering options can also be overridden by the user and are often ignored
by the graphics driver.
</p>
<p>
Any AntiAlias setting should be made optional to the user as it may have
a serious impact on the performance of your software on their system.
</p>
<p>
Default is False.
</p>
EndRem
Function AntiAlias(enable)="bbAntiAlias"

Rem
bbdoc: <p> Enables or disables wireframe rendering.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True to enable wireframe rendering</td></tr>
</table>
</p>
<p>
Enabling wire frame rendering will cause <a href=#bbrenderworld>bbRenderWorld</a> to output
only outlines of the polygons that make up the scene.
</p>
<p>
Default is False.
</p>
EndRem
Function Wireframe(enable)="bbWireFrame"

Rem
bbdoc: <p> Enables or disables hardware multitexturing.
about:
<table class="arg">
<tr><td class=argname>enable</td><td class=argvalue>True to enable hardware multitexturing</td></tr>
</table>
</p>
<p>
Hardware multitexturing is the process of rendering
multiple textures on a single surface using the
display hardware's multiple pixel pipes if available.
</p>
<p>
Providing the user of your software the option to
disable hardware multitexturing in favour of the
slower multipass mode may allow them to avoid
certain rendering bugs that exist in older graphics
card drivers.
</p>
<p>
Default is true.
</p>
EndRem
Function HWMultiTex(enable)="bbHWMultiTex"

Rem
bbdoc: <p> All visible entities in the World are rendered on each enabled camera to the <a href=#bbbackbuffer>bbBackBuffer</a> of the current <a href=#bbgraphics3d>bbGraphics3D</a> display device.
about:
<table class="arg">
<tr><td class=argname>tween#</td><td class=argvalue>optional value to render between updates</td></tr>
</table>
</p>
<p>
The area of the <a href=#bbgraphics3d>bbGraphics3D</a> display each camera renders
to is specified with the <a href=#bbcameraviewport>bbCameraViewport</a> command.
</p>
<p>
A camera will not render if its <a href=#bbcameraprojmode>bbCameraProjMode</a> has
been set to 0 or it has not been hidden due to a call
to the <a href=#bbhideentity>bbHideEntity</a> command.
</p>
<p>
A tween value of 0 will render all entities in the same
state they were when <a href=#bbcaptureworld>bbCaptureWorld</a> was last called and
a tween value of 1 (the default) will render all entities in their
current state.
</p>
<p>
The use of tweening allows you to render more than one
frame per game logic update, while still keeping the
display smooth. See <a href=#bbcaptureworld>bbCaptureWorld</a> for more information
regarding the use of tweening in Blitz3D.
</p>
<p>
Render tweening is an advanced technique, and it is not
necessary for normal use. See the castle demo  included in
the mak (nickname of Mark Sibly, author of Blitz3D) directory
of the Blitz3D samples section for a demonstration of render
tweening.
</p>
See Also: <a href=#bbgraphics3d>bbGraphics3D</a> <a href=#bbcaptureworld>bbCaptureWorld</a> <a href=#bbcameraviewport>bbCameraViewport</a> <a href=#bbcameraprojmode>bbCameraProjMode</a> <a href=#bbtrisrendered>bbTrisRendered</a>
EndRem
Function RenderWorld(tween#=1.0)="bbRenderWorld"

Rem
bbdoc: <p> Updates all animation in the world and updates all entity positions based on recent movements and the collision controls in place.
about:
<table class="arg">
<tr><td class=argname>anim_speed#</td><td class=argvalue>a master control for animation speed. Defaults to 1.</td></tr>
</table>
</p>
<p>
The optional <b>anim_speed</b> parameter allows control of the animation
speed of all entities at once. A value of 1 will animate entities
at their usual animation  speed, a value of 2 will animate entities
at double their animation speed etc.
</p>
<p>
See the chapter on <a href=#bbcollisions>bbCollisions</a> for more details on how entity
movement and collisions work in Blitz3D.
</p>
See Also: <a href=#bbanimate>bbAnimate</a> <a href=#bbcollisions>bbCollisions</a>
EndRem
Function UpdateWorld(anim_speed#=1.0)="bbUpdateWorld"

Rem
bbdoc: <p> Creates a snapshot of the world including the position, rotation, scale and alpha of all entities in the world.
about:
</p>
<p>
The <a href=#bbrenderworld>bbRenderWorld</a> command is capable of rendering frames
between the world as captured by <a href=#bbcaptureworld>bbCaptureWorld</a> and
the world in its current state by using the optional
<a href=#bbrenderworld>bbRenderWorld</a> <b>tween</b> parameter.
</p>
<p>
Often a game is designed to update its controls and
physics at a low frequency such as 10 times per second
in order to reduce network and processor requirements.
</p>
<p>
Calling <a href=#bbcaptureworld>bbCaptureWorld</a> after such a game update allows
the display loop to fill the gaps between game updates
with a smooth transition of frames rendered at various
periods between the time of the last <a href=#bbcaptureworld>bbCaptureWorld</a> and
the time of the most recent <a href=#bbupdateworld>bbUpdateWorld</a>.
</p>
<p class="hint">
The position of individual vertices are not captured
by the CaptureWorld command and so VertexCoords
based animation must be tweened manually.
</p>
See Also: <a href=#bbrenderworld>bbRenderWorld</a> <a href=#bbcaptureentity>bbCaptureEntity</a>
EndRem
Function CaptureWorld()="bbCaptureWorld"

Rem
bbdoc: <p> Clears all entities, brushes and / or textures from system memory.
about:
<table class="arg">
<tr><td class=argname>entities</td><td class=argvalue>True
<tr><td class=argname>brushes</td><td class=argvalue>True
<tr><td class=argname>textures</td><td class=argvalue>True
</table>
</p>
<p>
As soon as a resource is freed due to a call to <a href=#bbclearworld>bbClearWorld</a> its
handle must never be used again.
</p>
<p>
Trying to do so  will cause the fatal &quot;Entity Does Not Exist&quot;
or similar runtime error.
</p>
<p>
This command is useful for when a game level has finished and you
wish to load a different level with new entities, brushes and
textures.
</p>
See Also: <a href=#bbfreeentity>bbFreeEntity</a> <a href=#bbfreebrush>bbFreeBrush</a> <a href=#bbfreetexture>bbFreeTexture</a>
EndRem
Function ClearWorld(entities=True,brushes=True,textures=True)="bbClearWorld"

Rem
bbdoc: <p> Returns the number of triangles rendered during the most recent <a href=#bbrenderworld>bbRenderWorld</a>.
about:
</p>
<p>
The triangle count of a scene is an important resource and errors
in such things as a 3D file's level of detail can slow down
even the fastest computer.
</p>
<p>
Always make sure the models you are loading are built for
game use and not movie production, the later a likely cause
of poorly performing programs.
</p>
See Also: <a href=#bbrenderworld>bbRenderWorld</a>
EndRem
Function TrisRendered()="bbTrisRendered"

Rem
bbdoc: <p> Returns the handle of a newly created camera entity.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>parent entity of camera</td></tr>
</table>
</p>
<p>
<a href=#bbrenderworld>bbRenderWorld</a> uses the camera entities in the world
to render to the display. At least one camera is
required for <a href=#bbrenderworld>bbRenderWorld</a> to draw anything to the
display.
</p>
<p>
<a href=#bbcameraviewport>bbCameraViewport</a> may be used to modify the region of
the display onto which the camera renders. The default
viewport of a new camera is a region that covers
the entire display.
</p>
<p>
Multiple cameras may be used for split screen,
overlay and picture in picture style effects.
</p>
<p>
The <a href=#bbentityorder>bbEntityOrder</a> command can be used to control
the order in which multiple cameras are rendered,
see also CameraClsMode and CameraViewport which
are 2 other commands useful when setting up a
multi-camera enviroment.
</p>
<p>
The optional <b>parent</b> parameter attaches the new camera
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbrenderworld>bbRenderWorld</a> <a href=#bbcameraviewport>bbCameraViewPort</a>
EndRem
Function CreateCamera(parent=0)="bbCreateCamera"

Rem
bbdoc: <p> Sets the camera viewport position and size.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>x coordinate of top left hand corner of viewport</td></tr>
<tr><td class=argname>y</td><td class=argvalue>y coordinate of top left hand corner of viewport</td></tr>
<tr><td class=argname>width</td><td class=argvalue>width of viewport</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of viewport</td></tr>
</table>
</p>
<p>
The camera viewport is the  area of the 2D screen that the
3D graphics as viewed by the camera are displayed in.
</p>
<p>
Setting the camera viewport allows you to achieve
split-screen, overlays and rear-view mirror effects.
</p>
<p>
The world is rendered in a viewport such that the
camera's horizontal scale is preserved and the vertical
preserves the aspect ratio.
</p>
<p>
In situations in which one camera is overlaid ontop
another such as a game's scanner or user interface, the
<a href=#bbentityorder>bbEntityOrder</a> command can be used to modify the
order in which viewports are rendered.
</p>
See Also: <a href=#bbcreatecamera>bbCreateCamera</a> <a href=#bbentityorder>bbEntityOrder</a> <a href=#bbscaleentity>bbScaleEntity</a>
EndRem
Function CameraViewport(camera,x,y,width,height)="bbCameraViewport"

Rem
bbdoc: <p> Sets camera clear mode.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>cls_color</td><td class=argvalue>False
<tr><td class=argname>cls_zbuffer</td><td class=argvalue>False
</table>
</p>
<p>
By default each camera contributing a view to the
<a href=#bbrenderworld>bbRenderWorld</a> command will clear both the color and
depth buffers before rendering every entity in view.
A False argument for either the cls_color or
cls_zbuffer parameters modifies the specified
camera's behavior in this respect.
</p>
<p>
Overlay cameras often disable the automatic clearing
of the color buffer so that the scene rendered already
by the main camera appears behind the overlay viewport.
</p>
<p>
The advanced technique of multiple pass rendering
where layers such as shadows and haze are rendered
using multiple calls to <a href=#bbrenderworld>bbRenderWorld</a> before a single
<a href=#bbflip>bbFlip</a> often require cameras where both color
and depth buffer clearing is disabled.
</p>
See Also: <a href=#bbrenderworld>bbRenderWorld</a> <a href=#bbcameraclscolor>bbCameraClsColor</a>
EndRem
Function CameraClsMode(camera,cls_color,cls_zbuffer)="bbCameraClsMode"

Rem
bbdoc: <p> Sets camera background color.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>red</td><td class=argvalue>red value of camera background color</td></tr>
<tr><td class=argname>green</td><td class=argvalue>green value of camera background color</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>blue value of camera background color</td></tr>
</table>
</p>
<p>
Defaults to 0,0,0 (black).
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information on combining
red, green and blue values to define colors.
</p>
See Also: <a href=#bbcolor>bbColor</a> <a href=#bbclscolor>bbClsColor</a>
EndRem
Function CameraClsColor(camera,red#,green#,blue#)="bbCameraClsColor"

Rem
bbdoc: <p> Sets camera range.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>near</td><td class=argvalue>distance in front of camera that 3D objects start being drawn</td></tr>
<tr><td class=argname>far</td><td class=argvalue>distance in front of camera that 3D object stop being drawn</td></tr>
</table>
</p>
<p>
Defaults to 1,1000.
</p>
<p>
The distance parameters used in <a href=#bbcamerarange>bbCameraRange</a> define two planes.
</p>
<p>
The near plane will clip any objects that come too close to the
camera while the far plane will ensure the camera does not render
objects that are too far away (a common cause of slowdown
in games).
</p>
<p>
Fog can be used to soften the transition when objects approach
a <a href=#bbcamerarange>bbCameraRange</a>'s <b>far</b> distance, see the <a href=#bbcamerafogrange>bbCameraFogRange</a> command
for more details.
</p>
<p>
The distance between <b>near</b> and <b>far</b> also affects the precision
of the depth buffer which is used to determine which pixels from
which polygon are drawn when they overlap or even intersect.
</p>
<p>
See the <a href=#bbwbuffer>bbWBuffer</a> command for another command that can
affect depth buffer performance.
</p>
See Also: <a href=#bbcamerafogrange>bbCameraFogRange</a> <a href=#bbwbuffer>bbWBuffer</a>
EndRem
Function CameraRange(camera,near#,far#)="bbCameraRange"

Rem
bbdoc: <p> Sets zoom factor for a camera
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>zoom#</td><td class=argvalue>zoom factor of camera</td></tr>
</table>
Defaults to 1.0.
</p>
<p>
Values between 0.01 and 1.0 causes objects to look
smaller. Zoom values larger than 1.0 cause objects
to appear larger.
</p>
See Also: <a href=#bbcameraprojmode>bbCameraProjMode</a>
EndRem
Function CameraZoom(camera,zoom#)="bbCameraZoom"

Rem
bbdoc: <p> Sets the camera projection mode.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>projection mode</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>PROJ_NONE</td><td class=data>0</td><td class=data>No projection - disables camera (faster than HideEntity)</td></tr>
<tr><td class=data>PROJ_PERSPECTIVE</td><td class=data>1</td><td class=data>Perspective projection (default)</td></tr>
<tr><td class=data>PROJ_ORTHO</td><td class=data>2</td><td class=data>Orthographic projection</td></tr>
</table>
<p>
Standard perspective projection uses a zoom variable to make
objects further away from the camera appear smaller.
</p>
<p>
In contrast, orthographic projection involves a camera with
infinite zoom where the disatance from camera does not affect
the size an object is viewed. Orthographic projection is
also known as isometric projection.
</p>
<p>
The <a href=#bbcamerazoom>bbCameraZoom</a> of an orthorgaphic camera instead affects
the scale of graphics rendered with orthographic projection.
</p>
<p class="hint">
Unfortunately Blitz3D <a href=#bbterrains>bbTerrains</a> are not compatible with
orthographic projection due to the real time level of
detail algorithm used.
</p>
EndRem
Function CameraProjMode(camera,mode)="bbCameraProjMode"

Rem
bbdoc: <p> Sets the camera fog mode.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>camera mode</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Description</th></tr>
<tr><td class=data>0</td><td class=data>No fog (default)</td></tr>
<tr><td class=data>1</td><td class=data>Linear fog</td></tr>
</table>
<p>
This will enable/disable fogging, a technique  used to gradually fade
out graphics the further they are away from the camera.  This can be used
to avoid 'pop-up', the moment at which 3D objects suddenly appear on the
horizon which itself is controlled by the <b>far</b> parameter of the
<a href=#bbcamerarange>bbCameraRange</a> command.
</p>
<p>
The default fog color is black and the default fog range
is 1-1000. Change these values with the <a href=#bbcamerafogcolor>bbCameraFogColor</a>
and <a href=#bbcamerafogrange>bbCameraFogRange</a> commands respectively.
</p>
<p>
Each camera can have its own fog mode, for multiple on-screen
fog effects.
</p>
See Also: <a href=#bbcamerafogcolor>bbCameraFogColor</a> <a href=#bbcamerafogrange>bbCameraFogRange</a> <a href=#bbcamerarange>bbCameraRange</a>
EndRem
Function CameraFogMode(camera,mode)="bbCameraFogMode"

Rem
bbdoc: <p> Sets camera fog color.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>red</td><td class=argvalue>red value of value</td></tr>
<tr><td class=argname>green</td><td class=argvalue>green value of fog</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>blue value of fog</td></tr>
</table>
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information about
combining red, green and blue values to define
colors in Blitz3D.
</p>
See Also: <a href=#bbcamerafogmode>bbCameraFogMode</a> <a href=#bbcamerafogrange>bbCameraFogRange</a>
EndRem
Function CameraFogColor(camera,red#,green#,blue#)="bbCameraFogColor"

Rem
bbdoc: <p> Sets camera fog range.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>near#</td><td class=argvalue>distance in front of camera that fog starts</td></tr>
<tr><td class=argname>far#</td><td class=argvalue>distance in front of camera that fog ends</td></tr>
</table>
</p>
<p>
The <b>near</b> parameter specifies at what distance in front of the
camera specified that the fogging effect will start.
</p>
<p>
The <b>far</b> parameter specifies at what distance in front of the
camera that the fogging effect will end. All pixels rendered
beyond this point will be completely faded to the fog color.
</p>
See Also: <a href=#bbcamerafogcolor>bbCameraFogColor</a>
EndRem
Function CameraFogRange(camera,near#,far#)="bbCameraFogRange"

Rem
bbdoc: <p> Projects the world coordinate x,y,z on to the 2D screen.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>world coordinate x</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>world coordinate y</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>world coordinate z</td></tr>
</table>
</p>
<p>
Use the <a href=#bbprojectedx>bbProjectedX</a>, <a href=#bbprojectedy>bbProjectedY</a> and <a href=#bbprojectedz>bbProjectedZ</a> functions
to determine the pixel location on the camera's viewport and its
distance from the camera the global position specified would
be rendered at.
</p>
<p>
<a href=#bbcameraproject>bbCameraProject</a> is useful for positioning 2D lines or text
relative to the world positions of corresponding entity
or verticy locations.
</p>
See Also: <a href=#bbprojectedx>bbProjectedX</a> <a href=#bbprojectedy>bbProjectedY</a> <a href=#bbprojectedz>bbProjectedZ</a>
EndRem
Function CameraProject(camera,x#,y#,z#)="bbCameraProject"

Rem
bbdoc: <p> Returns the viewport x coordinate of the most recently executed <a href=#bbcameraproject>bbCameraProject</a> command.
about:
</p>
See Also: <a href=#bbcameraproject>bbCameraProject</a>
EndRem
Function ProjectedX#()="bbProjectedX"

Rem
bbdoc: <p> Returns the viewport y coordinate of the most recently executed <a href=#bbcameraproject>bbCameraProject</a> command.
about:
</p>
See Also: <a href=#bbcameraproject>bbCameraProject</a>
EndRem
Function ProjectedY#()="bbProjectedY"

Rem
bbdoc: <p> Returns the viewport z coordinate of the most recently executed CameraProject command
about:
This value corresponds
to the distance into the screen the point is located after
a <a href=#bbcameraproject>bbCameraProject</a> transforms a global point into the
camera's viewport space.
</p>
See Also: <a href=#bbcameraproject>bbCameraProject</a>
EndRem
Function ProjectedZ#()="bbProjectedZ"

Rem
bbdoc: <p> Returns true if the specified entity is visible to the specified camera.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
</table>
</p>
<p>
If the entity is a mesh, its bounding box will be checked for visibility.
</p>
<p>
For all other types of entities, only their centre position will be checked.
</p>
<p class="hint">
For animated meshes it is important their bounding box allow for all
possible frames of animation for EntityInView to function correctly.
</p>
EndRem
Function EntityInView(entity,camera)="bbEntityInView"

Rem
bbdoc: <p> Sets the ambient light color.
about:
<table class="arg">
<tr><td class=argname>red#</td><td class=argvalue>red ambient light value</td></tr>
<tr><td class=argname>green#</td><td class=argvalue>green ambient light value</td></tr>
<tr><td class=argname>blue#</td><td class=argvalue>blue ambient light value</td></tr>
</table>
</p>
<p>
Ambient light is added to all surfaces during a <a href=#bbrenderworld>bbRenderWorld</a>.
</p>
<p>
Ambient light has no position or direction and hence does not
contribute to the shading of surfaces just their overall brightness.
</p>
<p>
See <a href=#bbcreatelight>bbCreateLight</a> for how to add lights that provide 3D shading.
</p>
<p>
The red, green and blue values should be in the range 0..255.
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information about combining
red, green and blue values to describe specific colors.
</p>
<p>
The default ambient light color is 127,127,127.
</p>
See Also: <a href=#bbcreatelight>bbCreateLight</a>
EndRem
Function AmbientLight(red#,green#,blue#)="bbAmbientLight"

Rem
bbdoc: <p> Creates a light emitting entity.
about:
<table class="arg">
<tr><td class=argname>light_type</td><td class=argvalue>type of light</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity of light</td></tr>
</table>
</p>
<p>
By creating a light with the <a href=#bbcreatelight>bbCreateLight</a> function
surfaces in range of the light have additional
light added to their color based on the angle the
surface is to the light and the diffuse and specular
properties of the surface.
</p>
<p>
The optional <b>light_type</b> parameter allows you to specify
from one of the following light types:
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>LIGHT_DIRECTIONAL</td><td class=data>1</td><td class=data>Specific directional with infinite range and no position.</td></tr>
<tr><td class=data>LIGHT_POINT</td><td class=data>2</td><td class=data>Specific range and position.</td></tr>
<tr><td class=data>LIGHT_SPOT</td><td class=data>3</td><td class=data>Specific range position and angle.</td></tr>
</table>
<p>
Point lights radiate light evenly from a single point
while spot lights create a cone of light emitting
from a single point aligned to the light entitys'
current orientation.
</p>
<p>
A directional light is useful for emulating light
sources like the sun where it is so distant and has
such a large range it is simpler to reference only
the angle of its shine.
</p>
<p>
The optional <b>parent</b> parameter attaches the new light
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
<p>
Typically an outdoor daytime scene will require a single
directional light entity set to an appropriate angle and
brightness, see <a href=#bbrotateentity>bbRotateEntity</a> and <a href=#bbcreatelight>bbCreateLight</a> for more
information. Adjustments to <a href=#bbambientlight>bbAmbientLight</a> are helpful
for replicating the effect the entire sky is having on
the amount of light in the world.
</p>
<p>
For nighttime and indoor scenes, a combination of point
and spot light entities can be controlled in each room
for dramatic shading and mood.
</p>
<p>
See <a href=#bbbrushshininess>bbBrushShininess</a> and <a href=#bbentityshininess>bbEntityShininess</a> for more
information about the use of specular lighting.
</p>
<p class="hint">
Due to hardware limitations no single location
in the world should be in the range and hence
affected by more than a total of 8 lights.
</p>
<p>
Unlike point and spot lights, directional lights
have infinite range and so their position is ignored
and are always included in the lighting
calculations during <a href=#bbrenderworld>bbRenderWorld</a>.
</p>
See Also: <a href=#bblightrange>bbLightRange</a> <a href=#bblightcolor>bbLightColor</a> <a href=#bblightconeangles>bbLightConeAngles</a> <a href=#bbambientlight>bbAmbientLight</a>
EndRem
Function CreateLight(light_type=0,parent=0)="bbCreateLight"

Rem
bbdoc: <p> Sets a light's maximum effective distance.
about:
<table class="arg">
<tr><td class=argname>light</td><td class=argvalue>point or spot light entity</td></tr>
<tr><td class=argname>range#</td><td class=argvalue>range of light</td></tr>
</table>
</p>
<p>
The default range of a light is 1000.0.
</p>
See Also: <a href=#bbcreatelight>bbCreateLight</a> <a href=#bblightcolor>bbLightColor</a> <a href=#bblightconeangles>bbLightConeAngles</a>
EndRem
Function LightRange(light,range#)="bbLightRange"

Rem
bbdoc: <p> Sets the color and brightness of a light.
about:
<table class="arg">
<tr><td class=argname>light</td><td class=argvalue>light handle</td></tr>
<tr><td class=argname>red</td><td class=argvalue>red value of light</td></tr>
<tr><td class=argname>green</td><td class=argvalue>green value of light</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>blue value of light</td></tr>
</table>
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information on combining
red, green and blue values to define colors.
</p>
<p>
Values of 255,255,255 sets a light to emit bright white light.
</p>
<p>
A value of black or 0,0,0 effectively disables a light.
</p>
<p>
Values of less than 0 can be used to remove light from a
scene. This is  known as 'negative lighting', and is useful
for shadow effects.
</p>
See Also: <a href=#bbcreatelight>bbCreateLight</a> <a href=#bblightrange>bbLightRange</a> <a href=#bblightconeangles>bbLightConeAngles</a>
EndRem
Function LightColor(light,red#,green#,blue#)="bbLightColor"

Rem
bbdoc: <p> Sets the 'cone' angle for a SpotLight.
about:
<table class="arg">
<tr><td class=argname>light</td><td class=argvalue>light handle</td></tr>
<tr><td class=argname>inner_angle#</td><td class=argvalue>inner angle of cone in degrees</td></tr>
<tr><td class=argname>outer_angle#</td><td class=argvalue>outer angle of cone in degrees</td></tr>
</table>
</p>
<p>
The default light cone angles setting is 0,90.
</p>
See Also: <a href=#bbcreatelight>bbCreateLight</a> <a href=#bblightrange>bbLightRange</a> <a href=#bblightcolor>bbLightColor</a>
EndRem
Function LightConeAngles(light,inner_angle#,outer_angle#)="bbLightConeAngles"

Rem
bbdoc: <p> Creates a pivot entity.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> entity of new pivot</td></tr>
</table>
</p>
<p>
Pivots have position, scale and orientation but no geometry
and so are always invisible themselves.
</p>
<p>
Pivots make useful parent entities where they can be used
to control the visibility, position and orientation of
their children.
</p>
<p>
Pivots are also used for the bones when loading animated
b3d files with the <a href=#bbloadanimmesh>bbLoadAnimMesh</a> command.
</p>
<p>
The optional <b>parent</b> parameter attaches the new pivot
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbentityparent>bbEntityParent</a> <a href=#bbloadanimmesh>bbLoadAnimMesh</a>
EndRem
Function CreatePivot(parent=0)="bbCreatePivot"

Rem
bbdoc: <p> Creates a geometric cube, a mesh the shape of a square box.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> entity of a new cube</td></tr>
</table>
</p>
<p>
The new cube extends from  -1,-1,-1 to +1,+1,+1.
</p>
<p>
Creation of cubes, cylinders and cones are great
for placeholders during initial program development
when a game's art resources may only be in their
planning stages.
</p>
<p>
The optional <b>parent</b> parameter attaches the new cube
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
<p class="hint">
Parenting a semitransparent cube to an object to
visually represent its <a href=#bbentitybox>bbEntityBox</a> collision settings
is often useful when fine tuning object collisions.
</p>
See Also: <a href=#bbscalemesh>bbScaleMesh</a> <a href=#bbcreatesphere>bbCreateSphere</a> <a href=#bbcreatecylinder>bbCreateCylinder</a> <a href=#bbcreatecone>bbCreateCone</a>
EndRem
Function CreateCube(parent=0)="bbCreateCube"

Rem
bbdoc: <p> Creates a geometric sphere, a mesh the shape of a round ball.
about:
<table class="arg">
<tr><td class=argname>segments</td><td class=argvalue>sphere detail. Defaults to 8.</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity of new sphere</td></tr>
</table>
</p>
<p>
The sphere will be centred  at 0,0,0 and will have a radius of 1.
</p>
<p>
The optional segements value affects how many triangles are used
in the resulting mesh:
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Triangles</th><th class=data>Comment</th></tr>
<tr><td class=data>8</td><td class=data>224</td><td class=data>Bare minimum amount of polygons for a sphere</td></tr>
<tr><td class=data>16</td><td class=data>960</td><td class=data>Smooth looking sphere at medium-far distances</td></tr>
<tr><td class=data>32</td><td class=data>3968</td><td class=data>Smooth sphere at close distances</td></tr>
</table>
<p>
The optional <b>parent</b> parameter attaches the new sphere
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbscalemesh>bbScaleMesh</a> <a href=#bbcreatecube>bbCreateCube</a> <a href=#bbcreatecylinder>bbCreateCylinder</a> <a href=#bbcreatecone>bbCreateCone</a>
EndRem
Function CreateSphere(segments=8,parent=0)="bbCreateSphere"

Rem
bbdoc: <p> Creates a mesh entity the shape of a cylinder with optional ends.
about:
<table class="arg">
<tr><td class=argname>segments</td><td class=argvalue>cylinder detail. Defaults to 8.</td></tr>
<tr><td class=argname>solid</td><td class=argvalue>True
<tr><td class=argname>parent</td><td class=argvalue>parent entity of cylinder</td></tr>
</table>
</p>
<p>
The cylinder will  be centred at 0,0,0 and will have a radius of 1.
</p>
<p>
The segments value must be in the range 3-100 inclusive and results
in cylinders with the following triangle counts:
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Triangles</th><th class=data>Comment</th></tr>
<tr><td class=data>3</td><td class=data>8</td><td class=data>A prism</td></tr>
<tr><td class=data>8</td><td class=data>28</td><td class=data>Bare minimum amount of polygons for a cylinder</td></tr>
<tr><td class=data>16</td><td class=data>60</td><td class=data>Smooth cylinder at medium-far distances</td></tr>
<tr><td class=data>32</td><td class=data>124</td><td class=data>Smooth cylinder at close distances </td></tr>
</table>
<p>
The optional <b>parent</b> parameter attaches the new cylinder
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbscalemesh>bbScaleMesh</a> <a href=#bbcreatecube>bbCreateCube</a> <a href=#bbcreatesphere>bbCreateSphere</a> <a href=#bbcreatecone>bbCreateCone</a>
EndRem
Function CreateCylinder(segments=8,solid=True,parent=0)="bbCreateCylinder"

Rem
bbdoc: <p> Creates a mesh entity the shape of a cone with optional base.
about:
<table class="arg">
<tr><td class=argname>segments</td><td class=argvalue>cone detail. Defaults to 8.</td></tr>
<tr><td class=argname>solid</td><td class=argvalue>True
<tr><td class=argname>parent</td><td class=argvalue>parent entity of cone</td></tr>
</table>
</p>
<p>
The cone will be centred  at 0,0,0 and the base of the cone will have a
radius of 1.
</p>
<p>
The segments value has a range 3-100 inclusive and results
in cones with the following triangle counts:
</p>
<table class="data">
<tr><th class=data>Value</th><th class=data>Triangles</th><th class=data>Description</th></tr>
<tr><td class=data>4</td><td class=data>6</td><td class=data>A pyramid</td></tr>
<tr><td class=data>8</td><td class=data>14</td><td class=data>Bare minimum amount of polygons for a cone</td></tr>
<tr><td class=data>16</td><td class=data>30</td><td class=data>Smooth cone at medium-far distances</td></tr>
<tr><td class=data>32</td><td class=data>62</td><td class=data>Smooth cone at close distances </td></tr>
</table>
<p>
The optional <b>parent</b> parameter attaches the new cone
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbcreatecube>bbCreateCube</a> <a href=#bbcreatesphere>bbCreateSphere</a> <a href=#bbcreatecylinder>bbCreateCylinder</a>
EndRem
Function CreateCone(segments=8,solid=True,parent=0)="bbCreateCone"

Rem
bbdoc: <p> Creates a geometric plane, a flat surface with zero height that extends infinitely in the x and z axis.
about:
<table class="arg">
<tr><td class=argname>divisions</td><td class=argvalue>sub divisions of plane in the range 1-16. The default value is 1.</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity of plane</td></tr>
</table>
</p>
<p>
The optional <b>divisions</b> parameter determines how many sub divisions of
polygons the viewable area of the plane will be rendered with which
is important when their are point and spot lights contributing to the
lighting of a plane's surface.
</p>
<p>
Due to its inifinite nature a plane is not a mesh based entity
so unlike <a href=#bbcreatecube>bbCreateCube</a>, <a href=#bbcreatesphere>bbCreateSphere</a>, <a href=#bbcreatecylinder>bbCreateCylinder</a> and
<a href=#bbcreatecone>bbCreateCone</a>, mesh based commands must not be used on planes.
</p>
<p>
The optional <b>parent</b> parameter attaches the new plane
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbcreatemirror>bbCreateMirror</a>
EndRem
Function CreatePlane(divisions=1,parent=0)="bbCreatePlane"

Rem
bbdoc: <p> Creates a mirror entity which is an invisible plane with a surface that reflects all visible geometry when rendered.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>parent entity of mirror</td></tr>
</table>
</p>
<p>
The optional <b>parent</b> parameter attaches the new mirror
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
<p>
See <a href=#bbcreateplane>bbCreatePlane</a> for more information about the size and shape of a
mirror's geometry.
</p>
See Also: <a href=#bbcreateplane>bbCreatePlane</a>
EndRem
Function CreateMirror(parent=0)="bbCreateMirror"

Rem
bbdoc: <p> Returns a duplicate or clone of the specified entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>Entity to duplicate</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>Entity that will act as parent to the copy.</td></tr>
</table>
</p>
<p>
Surfaces of mesh based entities are not duplicated but
shared with the clone returned by <a href=#bbcopyentity>bbCopyEntity</a>. Use
the <a href=#bbcopymesh>bbCopyMesh</a> command to duplicate a mesh
entity with unique surfaces.
</p>
<p>
The optional <b>parent</b> parameter attaches the new clone
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
<p class="hint">
CopyEntity is fater than repeatedly calling LoadEntity
and will save on memory.
</p>
See Also: <a href=#bbentityparent>bbEntityParent</a> <a href=#bbcopymesh>bbCopyMesh</a>
EndRem
Function CopyEntity(entity,parent=0)="bbCopyEntity"

Rem
bbdoc: <p> Load a texture from an image file and returns the texture's handle.
about:
<table class="arg">
<tr><td class=argname>file$</td><td class=argvalue>filename of image file to be used as texture</td></tr>
<tr><td class=argname>flags</td><td class=argvalue>optional texture flags</td></tr>
</table>
</p>
<p>
Supported file formats include BMP, PNG, TGA, JPG and DDS.
</p>
<p>
Only PNG, TGA and specific DDS formats support an alpha channel
which provides per pixel transparency information.
</p>
<p>
See <a href=#bbcreatetexture>bbCreateTexture</a> for more detailed descriptions of the texture flags and
the <a href=#bbtexturefilter>bbTextureFilter</a> command for an alternative method of setting the texture
flags of a loaded texture based on the texture file's name.
</p>
<p class="hint">
Since Blitz3D version 1.97 <a href=#bbloadtexture>bbLoadTexture</a> also supports the loading of DDS
textures. This texture format uses the DXTC compression algorithm which
allows the textures to remain compressed on the video card which can
reduce the video RAM requirements of a program. The buffers of DXTC
compressed textures are not available meaning locking, drawing, reading
or writing to them will fail.
</p>
See Also: <a href=#bbloadanimtexture>bbLoadAnimTexture</a> <a href=#bbcreatetexture>bbCreateTexture</a> <a href=#bbtexturefilter>bbTextureFilter</a> <a href=#bbfreetexture>bbFreeTexture</a>
EndRem
Function LoadTexture(file$z,flags=1)="bbLoadTexture"

Rem
bbdoc: <p> Loads an animated texture from an image file and returns the texture's handle.
about:
<table class="arg">
<tr><td class=argname>file$</td><td class=argvalue>name of image file with animation frames laid out in left-right, top-to-bottom order</td></tr>
<tr><td class=argname>flags</td><td class=argvalue>optional texture flags</td></tr>
<tr><td class=argname>frame_width</td><td class=argvalue>width of each animation frame in pixels</td></tr>
<tr><td class=argname>frame_height</td><td class=argvalue>height of each animation frame in pixels</td></tr>
<tr><td class=argname>first_frame</td><td class=argvalue>the first frame to be loaded, where 0 is the top left frame in the imagefile</td></tr>
<tr><td class=argname>frame_count</td><td class=argvalue>the number of frames to load</td></tr>
</table>
</p>
<p>
Supported file formats include BMP, PNG, TGA, JPG and DDS.
</p>
<p>
Only PNG, TGA and specific formats of DDS support an alpha channel
which provides per pixel transparency information.
</p>
<p>
See <a href=#bbcreatetexture>bbCreateTexture</a> for more detailed descriptions of the texture flags and
the <a href=#bbtexturefilter>bbTextureFilter</a> command for an alternative method of setting the texture
flags of a loaded texture based on the texture file's name.
</p>
<p>
The frame_width, frame_height, first_frame and frame_count
parameters determine how Blitz will separate the image file into individual
animation frames.
</p>
<p>
The frames must be drawn in similar sized rectangles
arranged from left to right, top to bottom on the
image source.
</p>
See Also: <a href=#bbloadtexture>bbLoadTexture</a> <a href=#bbcreatetexture>bbCreateTexture</a> <a href=#bbtexturefilter>bbTextureFilter</a> <a href=#bbfreetexture>bbFreeTexture</a>
EndRem
Function LoadAnimTexture(file$z,flags,frame_width,frame_height,first_frame,frame_count)="bbLoadAnimTexture"

Rem
bbdoc: <p> Creates a texture and returns its handle.
about:
<table class="arg">
<tr><td class=argname>width</td><td class=argvalue>width of texture</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of texture</td></tr>
<tr><td class=argname>flags</td><td class=argvalue>combination of texture flags listed</td></tr>
<tr><td class=argname>frames</td><td class=argvalue>no of frames texture will have. Defaults to 1.</td></tr>
</table>
</p>
<p>
Width and height are the pixel dimensions of the texture.
</p>
<p>
Note that the size of the actual texture created may be
different from the width and height requested due to the
limitations of various designs of 3D hardware.
</p>
<p>
The optional <b>flags</b> parameter allows you to apply
certain effects to the texture:
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>TX_COLOR</td><td class=data>1</td><td class=data>Color (default)</td></tr>
<tr><td class=data>TX_ALPHA</td><td class=data>2</td><td class=data>Alpha</td></tr>
<tr><td class=data>TX_MASKED</td><td class=data>4</td><td class=data>Masked</td></tr>
<tr><td class=data>TX_MIP</td><td class=data>8</td><td class=data>Mipmapped</td></tr>
<tr><td class=data>TX_CLAMPU</td><td class=data>16</td><td class=data>Clamp U</td></tr>
<tr><td class=data>TX_CLAMPV</td><td class=data>32</td><td class=data>Clamp V</td></tr>
<tr><td class=data>TX_SPHERE</td><td class=data>64</td><td class=data>Spherical reflection map</td></tr>
<tr><td class=data>TX_CUBIC</td><td class=data>128</td><td class=data>Cubic environment map</td></tr>
<tr><td class=data>TX_VRAM</td><td class=data>256</td><td class=data>Store texture in vram</td></tr>
<tr><td class=data>TX_HIGHCOLOR</td><td class=data>512</td><td class=data>Force the use of high color textures</td></tr>
</table>
<p>
Flags can be added to combine two or more effects, e.g. 3 (1+2) = texture
with color and alpha maps.
</p>
<p>
Color - color map, what you see is what you get.
</p>
<p>
Alpha - alpha channel. If an image contains an alpha map, this will be used to
make certain areas of the texture transparent. Otherwise, the color map
will  be used as an alpha map. With alpha maps, the dark areas always
equal high-transparency,  light areas equal low-transparency.
</p>
<p>
Masked - all areas of a texture colored Black (0,0,0) will be treated
as 100% transparent and not be drawn. Unlike alpha textures, masked
textures can make use of the zbuffer making them faster and less prone
to depth sorting issues.
</p>
<p>
Mipmapped - low detail versions of the texture are generated for use
at various distances resulting in both smoother filtering and higher
performance rendering.
</p>
<p>
Clamp U - Disables texture wrapping / repeating in the horizontal axis.
</p>
<p>
Clamp V - Disables texture wrapping / repeating in the vertical axis.
</p>
<p>
Spherical environment map - a form of environment mapping. This works by
taking a single image, and then applying it to a 3D mesh in such a way
that the image appears to be reflected. When used with a texture that
contains light sources, it can give some meshes such as a teapot a
shiny appearance.
</p>
<p>
Cubic environment map - a form of environment mapping. Cube mapping is
similar to spherical mapping, except it uses six images each representing
a particular 'face' of an imaginary cube, to give the appearance of an
image that perfectly reflects its surroundings.
</p>
<p>
When creating cubic environment maps with the CreateTexture command,
cubemap textures must be square 'power of 2' sizes. See the <a href=#bbsetcubeface>bbSetCubeFace</a>
command for information on how to then draw to the cubemap.
</p>
<p>
When loading cubic environments maps into Blitz using LoadTexture, all
six images relating to the six faces of the cube must be contained within
the one texture, and be laid out in a horizontal strip in the following
order - left, forward, right, backward, up, down.
</p>
<p>
The images comprising the cubemap must all be power of two sizes.
</p>
<p>
Please note that not some older graphics cards do not support cubic mapping.
</p>
<p>
In order to find out if a user's graphics card can support it, use
<a href=#bbgfxdrivercaps3d>bbGfxDriverCaps3D</a> .
</p>
<p>
See <a href=#bbsetcubeface>bbSetCubeFace</a> and <a href=#bbsetcubemode>bbSetCubeMode</a> for more information about using cube
mapping in Blitz3D.
</p>
<p>
Store texture in vram - In some circumstances, this makes for much faster
dynamic textures - ie. when using CopyRect between two textures. When
drawing to cube maps in real-time, it is preferable to use this flag.
</p>
<p>
Force the use of high color textures in low bit depth graphics modes.
This is useful for when you are in 16-bit color mode, and wish to
create/load textures with the alpha flag - it should give better results.
</p>
<p>
Once you have created a texture, use SetBuffer TextureBuffer to draw to it.
</p>
<p>
However, to display 2D graphics on a texture, it is usually quicker to draw
to an image and then copy it to the texturebuffer, and to display 3D
graphics on a texture, your only option is to copy from the backbuffer to
the texturebuffer.
</p>
See Also: <a href=#bbloadtexture>bbLoadTexture</a> <a href=#bbloadanimtexture>bbLoadAnimTexture</a>
EndRem
Function CreateTexture(width,height,flags=0,frames=1)="bbCreateTexture"

Rem
bbdoc: <p> Frees a texture's resources from memory.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
</table>
</p>
<p>
Freeing a texture means you will not be able to use it again; however,
entities already textured with it will not lose the texture.
</p>
EndRem
Function FreeTexture(texture)="bbFreeTexture"

Rem
bbdoc: <p> Sets the blending mode for a texture.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle.</td></tr>
<tr><td class=argname>blend</td><td class=argvalue>blend mode of texture.</td></tr>
</table>
</p>
<p>
The texture blend mode determines how the texture will blend with the
texture or polygon surface 'below' it.
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>TX_BLEND_NONE</td><td class=data>0</td><td class=data>Do not blend</td></tr>
<tr><td class=data>TX_BLEND_ALPHA</td><td class=data>1</td><td class=data>No blend or Alpha (alpha when texture loaded with alpha flag - not recommended  for multitexturing - see below)</td></tr>
<tr><td class=data>TX_BLEND_MULT</td><td class=data>2</td><td class=data>Multiply (default)</td></tr>
<tr><td class=data>TX_BLEND_ADD</td><td class=data>3</td><td class=data>Add</td></tr>
<tr><td class=data>TX_BLEND_DOT3</td><td class=data>4</td><td class=data>Dot3</td></tr>
<tr><td class=data>TX_BLEND_MULT2</td><td class=data>5</td><td class=data>Multiply x 2</td></tr>
</table>
<p>
Each of the blend modes are identical to their <a href=#bbentityblend>bbEntityBlend</a> counterparts.
</p>
<p>
Texture blending in Blitz3D begins with the highest order
texture (the one with the highest index) and blends with
the next indexed texture:
</p>
<p>
Texture 2 will blend with texture 1.
</p>
<p>
Texture 1 will blend with texture 0.
</p>
<p>
Texture 0 will blend with the polygons of the entity it is applied to.
</p>
<p>
And so on...
</p>
<p>
See the <a href=#bbbrushtexture>bbBrushTexture</a> and <a href=#bbentitytexture>bbEntityTexture</a> commands for setting
the index number of a texture.
</p>
<p class="hint">
In the case of multitexturing (more than one texture applied to an entity),
it is not recommended you blend textures that have been loaded with the
alpha flag, as this can cause unpredictable results on a variety of different
graphics cards.
</p>
See Also: <a href=#bbentityblend>bbEntityBlend</a> <a href=#bbentitytexture>bbEntityTexture</a> <a href=#bbbrushblend>bbBrushBlend</a> <a href=#bbbrushtexture>bbBrushTexture</a>
EndRem
Function TextureBlend(texture,blend)="bbTextureBlend"

Rem
bbdoc: <p> Sets the texture coordinate mode for a texture.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>coords</td><td class=argvalue>coordinate set (0 or 1)</td></tr>
</table>
</p>
<p>
This determines where the UV values used to look up a texture come from.
</p>
<table class="data">
<tr><th class=data>Coords</th><th class=data>Description</th></tr>
<tr><td class=data>0</td><td class=data>UV coordinates are from first UV set in vertices (default)</td></tr>
<tr><td class=data>1</td><td class=data>UV coordinates are from second UV set in vertices</td></tr>
</table>
EndRem
Function TextureCoords(texture,coords)="bbTextureCoords"

Rem
bbdoc: <p> Scales a texture by an absolute amount.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>u_scale#</td><td class=argvalue>u scale</td></tr>
<tr><td class=argname>v_scale#</td><td class=argvalue>v scale</td></tr>
</table>
</p>
<p>
Effective immediately on all instances of the texture being used.
</p>
EndRem
Function ScaleTexture(texture,u_scale#,v_scale#)="bbScaleTexture"

Rem
bbdoc: <p> Positions a texture at an absolute position.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>u_position#</td><td class=argvalue>u position of texture</td></tr>
<tr><td class=argname>v_position#</td><td class=argvalue>v position of texture</td></tr>
</table>
</p>
<p>
Positioning a texture is useful for performing scrolling texture effects,
such as for water etc.
</p>
EndRem
Function PositionTexture(texture,u_position#,v_position#)="bbPositionTexture"

Rem
bbdoc: <p> Rotates a texture.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>angle#</td><td class=argvalue>absolute angle of texture rotation</td></tr>
</table>
</p>
<p>
This will have an immediate effect on all instances of the texture being used.
</p>
<p>
Rotating a texture is useful for performing swirling texture effects, such as
for smoke etc.
</p>
EndRem
Function RotateTexture(texture,angle#)="bbRotateTexture"

Rem
bbdoc: <p> Returns the width of a texture in pixels.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
</table>
</p>
EndRem
Function TextureWidth(texture)="bbTextureWidth"

Rem
bbdoc: <p> Returns the height of a texture in pixels.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
</table>
</p>
EndRem
Function TextureHeight(texture)="bbTextureHeight"

Rem
bbdoc: <p> Returns the handle of a texture's drawing buffer.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>optional texture frame</td></tr>
</table>
</p>
<p>
This can be used with <a href=#bbsetbuffer>bbSetBuffer</a> to perform 2D drawing operations to
the texture, although it's usually faster to draw to an image, and
then copy the  image buffer across to the texture buffer using <a href=#bbcopyrect>bbCopyRect</a>.
</p>
<p>
You cannot render 3D to a texture buffer as <a href=#bbrenderworld>bbRenderWorld</a> only works with
a graphic display's back buffer. To display 3D graphics on a texture, use
<a href=#bbcopyrect>bbCopyRect</a> to copy the contents of the back buffer to a texture buffer
after the call to <a href=#bbrenderworld>bbRenderWorld</a>
</p>
EndRem
Function TextureBuffer(texture,frame=0)="bbTextureBuffer"

Rem
bbdoc: <p> Returns a texture's absolute filename.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>a valid texture handle</td></tr>
</table>
</p>
<p>
To find out just the name of the texture, you will need to strip
the path information from the string returned by <a href=#bbtexturename>bbTextureName</a>.
</p>
See Also: <a href=#bbgetbrushtexture>bbGetBrushTexture</a>
EndRem
Function bbTextureName$z(texture)="bbTextureName"

Rem
bbdoc: <p> Returns the texture that is applied to the specified brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>optional index of texture applied to brush, from 0..7. Defaults to 0.</td></tr>
</table>
</p>
<p>
The optional <b>index</b> parameter allows you to specify which particular
texture you'd like returning, if there are more than one textures
applied to a brush.
</p>
<p>
You should release the texture returned by GetBrushTexture after use
to prevent leaks! Use <a href=#bbfreetexture>bbFreeTexture</a> to do this.
</p>
<p>
To find out the name of the texture, use <a href=#bbtexturename>bbTextureName</a>.
</p>
See Also: <a href=#bbtexturename>bbTextureName</a> <a href=#bbfreetexture>bbFreeTexture</a> <a href=#bbgetentitybrush>bbGetEntityBrush</a> <a href=#bbgetsurfacebrush>bbGetSurfaceBrush</a>
EndRem
Function GetBrushTexture(brush,index=0)="bbGetBrushTexture"

Rem
bbdoc: <p> Adds a texture filter.
about:
<table class="arg">
<tr><td class=argname>match_text$</td><td class=argvalue>text that, if found in texture filename, will activate certain filters</td></tr>
<tr><td class=argname>flags</td><td class=argvalue>filter texture flags</td></tr>
</table>
</p>
<p>
Any texture files subsequently loaded with <a href=#bbloadtexture>bbLoadTexture</a>, <a href=#bbloadanimtexture>bbLoadAnimTexture</a> or
as the result of <a href=#bbloadmesh>bbLoadMesh</a> or <a href=#bbloadanimmesh>bbLoadAnimMesh</a> that contain the text match_text$
in their filename will inherit the specified flags.
</p>
<table class="data">
<tr><th class=data>Flag</th><th class=data>Value</th><th class=data>Description </th></tr>
<tr><td class=data>TX_COLOR</td><td class=data>1</td><td class=data>Color (default)</td></tr>
<tr><td class=data>TX_ALPHA</td><td class=data>2</td><td class=data>Alpha</td></tr>
<tr><td class=data>TX_MASKED</td><td class=data>4</td><td class=data>Masked</td></tr>
<tr><td class=data>TX_MIP</td><td class=data>8</td><td class=data>Mipmapped</td></tr>
<tr><td class=data>TX_CLAMPU</td><td class=data>16</td><td class=data>Clamp U</td></tr>
<tr><td class=data>TX_CLAMPV</td><td class=data>32</td><td class=data>Clamp V</td></tr>
<tr><td class=data>TX_SPHERE</td><td class=data>64</td><td class=data>Spherical reflection map</td></tr>
<tr><td class=data>TX_CUBIC</td><td class=data>128</td><td class=data>Cubic environment map</td></tr>
<tr><td class=data>TX_VRAM</td><td class=data>256</td><td class=data>Store texture in vram</td></tr>
<tr><td class=data>TX_HIGHCOLOR</td><td class=data>512</td><td class=data>Force the use of high color textures</td></tr>
</table>
<p>
See <a href=#bbcreatetexture>bbCreateTexture</a> for more information on texture flags.
</p>
<p>
By default, the following texture filter is used:
</p>
<p>
TextureFilter &quot;&quot;,1+8
</p>
<p>
This means that all loaded textures will have color and be mipmapped by default.
</p>
See Also: <a href=#bbcleartexturefilters>bbClearTextureFilters</a> <a href=#bbloadtexture>bbLoadTexture</a> <a href=#bbloadanimtexture>bbLoadAnimTexture</a> <a href=#bbloadmesh>bbLoadMesh</a> <a href=#bbloadanimmesh>bbLoadAnimMesh</a>
EndRem
Function TextureFilter(match_text$z,flags)="bbTextureFilter"

Rem
bbdoc: <p> Clears the current texture filter list.
about:
</p>
<p>
This command must follow any call to Graphics3D which resets the systems
texture flags to their default values which are Color and MipMapped. See
the <a href=#bbtexturefilter>bbTextureFilter</a> command for more information.
</p>
See Also: <a href=#bbtexturefilter>bbTextureFilter</a> <a href=#bbloadtexture>bbLoadTexture</a>
EndRem
Function ClearTextureFilters()="bbClearTextureFilters"

Rem
bbdoc: <p> Selects a cube face for direct rendering to a texture.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>a cubemap type texture</td></tr>
<tr><td class=argname>face</td><td class=argvalue>face of cube to select 0..5</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Face</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>CUBEFACE_LEFT</td><td class=data>0</td><td class=data>left (negative X) face</td></tr>
<tr><td class=data>CUBEFACE_FRONT</td><td class=data>1</td><td class=data>forward (positive Z) face - this is the default.</td></tr>
<tr><td class=data>CUBEFACE_RIGHT</td><td class=data>2</td><td class=data>right (positive X) face</td></tr>
<tr><td class=data>CUBEFACE_BACK</td><td class=data>3</td><td class=data>backward (negative Z) face</td></tr>
<tr><td class=data>CUBEFACE_TOP</td><td class=data>4</td><td class=data>up (positive Y) face</td></tr>
<tr><td class=data>CUBEFACE_BOTTOM</td><td class=data>5</td><td class=data>down (negative Y) face</td></tr>
</table>
<p>
This command should only be used when you wish to draw directly to a
cubemap texture in real-time.
</p>
<p>
Otherwise, just loading a pre-rendered cubemap with a flag of 128 will suffice.
</p>
<p>
To understand how this command works exactly it is important to recognise
that Blitz treats cubemap textures slightly differently to how it treats
other textures. Here's how it works:
</p>
<p>
A cubemap texture in Blitz actually consists of six images, each of which
must be square 'power' of two size - e.g. 32, 64, 128 etc. Each corresponds
to a particular cube face. These images are stored internally by Blitz, and
the texture handle that is returned by LoadTexture/CreateTexture when
specifying the cubemap flag, only provides access to one of these six
images at once (by default the first one, or '1' face).
</p>
<p>
This is why, when loading a cubemap texture into Blitz using
LoadTexture, all the six cubemap images must be laid out in a specific order
(0-5, as described above), in a horizontal strip. Then Blitz takes this
texture and internally converts it into six separate images.
</p>
<p>
So seeing as the texture handle returned by <a href=#bbcreatetexture>bbCreateTexture</a> / <a href=#bbloadtexture>bbLoadTexture</a>
only provides access to one of these images at once (no. 1 by default),
how do we get access to the other five images? This is where <a href=#bbsetcubeface>bbSetCubeFace</a>
comes in.
</p>
<p>
It will tell Blitz that whenever you next draw to a cubemap texture, to draw
to the particular image representing the face you have specified with the
<b>face</b> parameter.
</p>
<p>
Now you have the ability to draw to a cubemap in real-time.
</p>
<p>
To give you some idea of how this works in code, see the example included
in the online help. It works by rendering six different views
and copying them to the cubemap texture buffer, using <a href=#bbsetcubeface>bbSetCubeFace</a> to specify
which particular cubemap image should be drawn to.
</p>
<p>
All rendering to a texture buffer affects the currently
selected face. Do not change the selected cube face while a buffer is locked.
</p>
<p>
Finally, you may wish to combine the vram 256 flag with the cubic mapping
flag when drawing to cubemap textures for faster access.
</p>
See Also: <a href=#bbcreatetexture>bbCreateTexture</a> <a href=#bbloadtexture>bbLoadTexture</a> <a href=#bbsetcubemode>bbSetCubeMode</a>
EndRem
Function SetCubeFace(texture,face)="bbSetCubeFace"

Rem
bbdoc: <p> Set the rendering mode of a cubemap texture.
about:
<table class="arg">
<tr><td class=argname>texture</td><td class=argvalue>a valid texture handle</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>the rendering mode of the cubemap texture:</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>CUBEMODE_SPECULAR</td><td class=data>1</td><td class=data>Specular (default) </td></tr>
<tr><td class=data>CUBEMODE_DIFFUSE</td><td class=data>2</td><td class=data>Diffuse</td></tr>
<tr><td class=data>CUBEMODE_3</td><td class=data>Refraction</td></tr>
</table>
<p>
The available rendering modes are as follows:
</p>
<p>
Specular (default) - use this to give your cubemapped
objects a shiny effect.
</p>
<p>
Diffuse - use this to give your cubemapped objects a
non-shiny, realistic lighting effect.
</p>
<p>
Refraction - Good for 'cloaking device' style effects.
</p>
See Also: <a href=#bbcreatetexture>bbCreateTexture</a> <a href=#bbloadtexture>bbLoadTexture</a> <a href=#bbsetcubeface>bbSetCubeFace</a>
EndRem
Function SetCubeMode(texture,mode)="bbSetCubeMode"

Rem
bbdoc: <p> Creates a brush with an optional color that can be used with the <a href=#bbpaintentity>bbPaintEntity</a> and <a href=#bbpaintsurface>bbPaintSurface</a> commands.
about:
<table class="arg">
<tr><td class=argname>red</td><td class=argvalue>brush red value</td></tr>
<tr><td class=argname>green</td><td class=argvalue>brush green value</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>brush blue value</td></tr>
</table>
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information on combining
red, green and blue values to define colors. The brush will
default to White if no color is specified.
</p>
<p>
A brush is a collection of properties including color, alpha,
shininess, textures, blend mode and rendering effects.
</p>
<p>
All the properties of a brush are assigned to an entity or
particular surface with the <a href=#bbpaintentity>bbPaintEntity</a>, <a href=#bbpaintmesh>bbPaintMesh</a> and
<a href=#bbpaintsurface>bbPaintSurface</a> commands.
</p>
<p>
Painting an entity with a brush can be more efficient than
setting its individual properties with individual calls
to <a href=#bbentitycolor>bbEntityColor</a>, <a href=#bbentityfx>bbEntityFX</a>, <a href=#bbentityalpha>bbEntityAlpha</a> etc.
</p>
<p>
Brushes are required in order to modify the equivalent
surface properties of meshes that when combined with the
entity properties result in the final rendering properties
of the surface. See <a href=#bbpaintsurface>bbPaintSurface</a> for more information.
</p>
See Also: <a href=#bbloadbrush>bbLoadBrush</a> <a href=#bbpaintentity>bbPaintEntity</a> <a href=#bbpaintmesh>bbPaintMesh</a> <a href=#bbpaintsurface>bbPaintSurface</a>
EndRem
Function CreateBrush(red#=255,green#=255,blue#=255)="bbCreateBrush"

Rem
bbdoc: <p> Creates a brush and loads and assigns a single texture to it with the specified texture properties.
about:
<table class="arg">
<tr><td class=argname>texture_file$</td><td class=argvalue>filename of texture</td></tr>
<tr><td class=argname>flags</td><td class=argvalue>optional texture flags</td></tr>
<tr><td class=argname>u_scale</td><td class=argvalue>optional texture horizontal scale</td></tr>
<tr><td class=argname>v_scale</td><td class=argvalue>optional texture vertical scale</td></tr>
</table>
</p>
<p>
See the <a href=#bbcreatetexture>bbCreateTexture</a> command for a discussion of the various texture
flags and their effects and the <a href=#bbscaletexture>bbScaleTexture</a> command for more information
on texture scales.
</p>
See Also: <a href=#bbcreatebrush>bbCreateBrush</a> <a href=#bbcreatetexture>bbCreateTexture</a>
EndRem
Function LoadBrush(texture_file$z,flags=1,u_scale#=1,v_scale#=1)="bbLoadBrush"

Rem
bbdoc: <p> Frees up a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
</table>
</p>
See Also: <a href=#bbfreetexture>bbFreeTexture</a> <a href=#bbfreeentity>bbFreeEntity</a> <a href=#bbclearworld>bbClearWorld</a>
EndRem
Function FreeBrush(brush)="bbFreeBrush"

Rem
bbdoc: <p> Modifies the color of a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>red</td><td class=argvalue>red value of brush</td></tr>
<tr><td class=argname>green</td><td class=argvalue>green value of brush</td></tr>
<tr><td class=argname>blue</td><td class=argvalue>blue value of brush</td></tr>
</table>
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information on combining
red, green and blue values to define colors.
</p>
<p>
Please note that if <a href=#bbentityfx>bbEntityFX</a> or <a href=#bbbrushfx>bbBrushFX</a> flag 2 is being used,
brush color will have no effect and vertex colors will be used
instead.
</p>
See Also: <a href=#bbentitycolor>bbEntityColor</a>
EndRem
Function BrushColor(brush,red#,green#,blue#)="bbBrushColor"

Rem
bbdoc: <p> Sets the alpha level of a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>alpha#</td><td class=argvalue>alpha level of brush</td></tr>
</table>
</p>
<p>
The alpha# value should be in the range 0.0 to 1.0.
</p>
<p>
The default brush alpha setting is 1.0.
</p>
<p>
The alpha level is how transparent an entity is.
</p>
<p>
A value of 1 will mean the  entity is non-transparent, i.e. opaque.
</p>
<p>
A value of 0 will mean the entity is  completely transparent, i.e. invisible.
</p>
<p>
Values between 0 and 1 will cause varying amount of transparency
accordingly, useful for imitating the look of objects such as glass
and ice.
</p>
<p>
A <a href=#bbbrushalpha>bbBrushAlpha</a> value of 0 is especially useful as Blitz3D will
not render surfaces painted with such a brush, but will still
involve the entities in collision tests.
</p>
See Also: <a href=#bbentityalpha>bbEntityAlpha</a>
EndRem
Function BrushAlpha(brush,alpha#)="bbBrushAlpha"

Rem
bbdoc: <p> Sets the blending mode for a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>blend</td><td class=argvalue>blend mode</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>BLEND_NONE</td><td class=data>0</td><td class=data>inherit surface blend mode</td></tr>
<tr><td class=data>BLEND_ALPHA</td><td class=data>1</td><td class=data>averages colors based on transparancy (default)</td></tr>
<tr><td class=data>BLEND_MULT</td><td class=data>2</td><td class=data>multiplies colors together</td></tr>
<tr><td class=data>BLEND_ADD</td><td class=data>3</td><td class=data>adds colors together</td></tr>
</table>
See Also: <a href=#bbentityblend>bbEntityBlend</a>
EndRem
Function BrushBlend(brush,blend)="bbBrushBlend"

Rem
bbdoc: <p> Sets miscellaneous effects for a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>fx</td><td class=argvalue>effects flags</td></tr>
</table>
</p>
<p>
Flags can be added to combine two or more effects. For example,
specifying a flag of 3 (1+2) will result in  a full-bright
vertex-colored brush.
</p>
<table class="data">
<tr><th class=data>Flag</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>BRUSHFX_NONE</td><td class=data>0</td><td class=data>Nothing (default)</td></tr>
<tr><td class=data>BRUSHFX_FULLBRIGHT</td><td class=data>1</td><td class=data>FullBright</td></tr>
<tr><td class=data>BRUSHFX_VERTEXCOLOR</td><td class=data>2</td><td class=data>EnableVertexColors</td></tr>
<tr><td class=data>BRUSHFX_FLATSHADED</td><td class=data>4</td><td class=data>FlatShaded</td></tr>
<tr><td class=data>BRUSHFX_NOFOG</td><td class=data>8</td><td class=data>DisableFog</td></tr>
<tr><td class=data>BRUSHFX_DOUBLESIDED</td><td class=data>16</td><td class=data>DoubleSided</td></tr>
<tr><td class=data>BRUSHFX_VERTEXALPHA</td><td class=data>32</td><td class=data>EnableVertexAlpha</td></tr>
</table>
<p>
See the <a href=#bbentityfx>bbEntityFX</a> command for details on the meaning of each flag.
</p>
See Also: <a href=#bbentityfx>bbEntityFX</a>
EndRem
Function BrushFX(brush,fx)="bbBrushFX"

Rem
bbdoc: <p> Sets the shininess (specularity) of a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>shininess#</td><td class=argvalue>shininess of brush</td></tr>
</table>
</p>
<p>
The shininess# value should be  in the range 0-1. The default shininess
setting is 0.
</p>
<p>
Shininess is how much brighter certain areas of an object will appear to
be when a light is shone directly at them.
</p>
<p>
Setting a shininess value of 1 for a medium to high poly sphere, combined
with the creation of a light shining in the direction of it, will give it
the appearance of a shiny snooker ball.
</p>
See Also: <a href=#bbentityshininess>bbEntityShininess</a>
EndRem
Function BrushShininess(brush,shininess#)="bbBrushShininess"

Rem
bbdoc: <p> Assigns a texture to a brush.
about:
<table class="arg">
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>texture frame. Defaults to 0.</td></tr>
<tr><td class=argname>index</td><td class=argvalue>brush texture layer. Defaults to 0.</td></tr>
</table>
</p>
<p>
The optional <b>frame</b> parameter specifies which  animation
frame, if any exist, should be assigned to the brush.
</p>
<p>
The optional <b>index</b> parameter specifies the texture layer
that the texture should  be assigned to.
</p>
<p>
Brushes have up to eight texture layers, 0-7 inclusive.
</p>
See Also: <a href=#bbentitytexture>bbEntityTexture</a>
EndRem
Function BrushTexture(brush,texture,frame=0,index=0)="bbBrushTexture"

Rem
bbdoc: <p> Returns a new brush with the same properties as is currently applied to the specified entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
See the <a href=#bbgetsurfacebrush>bbGetSurfaceBrush</a> function for capturing the properties
of a particualar entities surface which are combined with the
entity properties returned with GetEntityBrush() when Blitz3D
actually renders the surface.
</p>
<p>
Use the <a href=#bbfreebrush>bbFreeBrush</a> command when the newly created brush is no
longer needed.
</p>
<p>
See the <a href=#bbgetbrushtexture>bbGetBrushTexture</a> and <a href=#bbtexturename>bbTextureName</a> functions for
retrieving details of the brushes texture properties.
</p>
See Also: <a href=#bbgetsurfacebrush>bbGetSurfaceBrush</a> <a href=#bbfreebrush>bbFreeBrush</a> <a href=#bbgetbrushtexture>bbGetBrushTexture</a> <a href=#bbtexturename>bbTextureName</a>
EndRem
Function GetEntityBrush(entity)="bbGetEntityBrush"

Rem
bbdoc: <p> Returns a new brush with the same properties as is currently applied to the specified surface.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
</table>
</p>
<p>
See the <a href=#bbgetentitybrush>bbGetEntityBrush</a> command for capturing entitities default
surface properties.
</p>
<p>
Use the <a href=#bbfreebrush>bbFreeBrush</a> command when the newly created brush is no
longer needed.
</p>
<p>
See the <a href=#bbgetbrushtexture>bbGetBrushTexture</a> and <a href=#bbtexturename>bbTextureName</a> functions for
retrieving details of the brushes texture properties.
</p>
See Also: <a href=#bbgetentitybrush>bbGetEntityBrush</a> <a href=#bbfreebrush>bbFreeBrush</a> <a href=#bbgetsurface>bbGetSurface</a> <a href=#bbgetbrushtexture>bbGetBrushTexture</a> <a href=#bbtexturename>bbTextureName</a>
EndRem
Function GetSurfaceBrush(surface)="bbGetSurfaceBrush"

Rem
bbdoc: <p> Returns the number of 3D compatible modes available on the selected 3D graphics card, and configures the table of information returned by <a href=#bbgfxmodewidth>bbGfxModeWidth</a>, <a href=#bbgfxmodeheight>bbGfxModeHeight</a> and <a href=#bbgfxmodedepth>bbGfxModeDepth</a> functions.
about:
</p>
<p>
Use instead of CountGfxModes() to enumerate the available 3D capable
resolutions available for use with the <a href=#bbgraphics3d>bbGraphics3D</a> command.
</p>
See Also: <a href=#bbgfxmodewidth>bbGfxModeWidth</a> <a href=#bbgfxmodeheight>bbGfxModeHeight</a> <a href=#bbgfxmodedepth>bbGfxModeDepth</a> <a href=#bbgraphics3d>bbGraphics3D</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a> <a href=#bbcountgfxmodes>bbCountGfxModes</a>
EndRem
Function CountGfxModes3D()="bbCountGfxModes3D"

Rem
bbdoc: <p> Returns True if the specified graphics mode is 3D-capable.
about:
<table class="arg">
<tr><td class=argname>mode</td><td class=argvalue>graphics mode number from 1 .. CountGfxModes ()</td></tr>
</table>
</p>
<p>
This function has been superceeded by the use of <a href=#bbcountgfxmodes3d>bbCountGfxModes3D</a>()
which removes any non-3D capable modes from the available
mode list.
</p>
See Also: <a href=#bbcountgfxmodes3d>bbCountGfxModes3D</a>
EndRem
Function GfxMode3D(mode)="bbGfxMode3D"

Rem
bbdoc: <p> Returns True <a href=#bbgraphics3d>bbGraphics3D</a> in windowed display mode.
about:
</p>
<p>
This function should be used before calling <a href=#bbgraphics3d>bbGraphics3D</a> involving
a windowed display.
</p>
<p>
Older generation graphics cards may only support 3D &quot;in a window&quot;
if the desktop is set to a specific color depth if at all.
</p>
See Also: <a href=#bbgraphics3d>bbGraphics3D</a> <a href=#bbgfxmode3dexists>bbGfxMode3DExists</a> <a href=#bbgfxdriver3d>bbGfxDriver3D</a>
EndRem
Function Windowed3D()="bbWindowed3D"

Rem
bbdoc: <p> Returns True the specified resolution.
about:
<table class="arg">
<tr><td class=argname>width</td><td class=argvalue>width of screen resolution</td></tr>
<tr><td class=argname>height</td><td class=argvalue>height of screen resolution</td></tr>
<tr><td class=argname>depth</td><td class=argvalue>color depth of screen. 0 = any color depth is OK</td></tr>
</table>
</p>
<p>
Use the <a href=#bbgfxmode3dexists>bbGfxMode3DExists</a> command to avoid a possible &quot;Unable
to set Graphics mode&quot; runtime error when calling <a href=#bbgraphics3d>bbGraphics3D</a>
which occurs if the user's computer is unable to support 3D
graphics displays at the specified resolution.
</p>
<p>
See <a href=#bbcountgfxmodes3d>bbCountGfxModes3D</a> for an alternative method of ensuring
the 3D driver supports certain resolution requirements.
</p>
See Also: <a href=#bbgraphics3d>bbGraphics3D</a> <a href=#bbwindowed3d>bbWindowed3D</a> <a href=#bbgfxdriver3d>bbGfxDriver3D</a>
EndRem
Function GfxMode3DExists(width,height,depth)="bbGfxMode3DExists"

Rem
bbdoc: <p> Returns True if the specified graphics driver is 3D-capable.
about:
<table class="arg">
<tr><td class=argname>driver</td><td class=argvalue>display driver number to check, from 1 to CountGfxDrivers ()</td></tr>
</table>
</p>
<p>
The graphics driver usually corresponds to the number of monitors
connected to the user's system.
</p>
<p>
If GfxDriver3D returns False the specifed driver will be unable
to support any 3D modes and should not be selected with the
<a href=#bbsetgfxdriver>bbSetGfxDriver</a> command.
</p>
<p>
See <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a> for more information on multiple monitor systems.
</p>
See Also: <a href=#bbcountgfxdrivers>bbCountGfxDrivers</a> <a href=#bbsetgfxdriver>bbSetGfxDriver</a> <a href=#bbgfxdrivercaps3d>bbGfxDriverCaps3D</a>
EndRem
Function GfxDriver3D(driver)="bbGfxDriver3D"

Rem
bbdoc: <p> Returns the 'caps level' of the current graphics driver
about:
Values are:
</p>
<table class="data">
<tr><th class=data>Level</th><th class=data>Description</th></tr>
<tr><td class=data>100</td><td class=data>Card supports all 'standard' Blitz3D operations.</td></tr>
<tr><td class=data>110</td><td class=data>Card supports all standard ops plus cubic environment mapping.</td></tr>
</table>
<p class="hint">
The program must already have configured the 3D display by
successfully calling <a href=#bbgraphics3d>bbGraphics3D</a> before calling this function.
</p>
See Also: <a href=#bbcreatetexture>bbCreateTexture</a> <a href=#bbgraphics3d>bbGraphics3D</a>
EndRem
Function GfxDriverCaps3D()="bbGfxDriverCaps3D"

Rem
bbdoc: <p> Returns the number of hardware texturing units available.
about:
</p>
<p>
The result of <a href=#bbhwtexunits>bbHWTexUnits</a> is only of interest as a basic
performance indicator of the current graphics driver as
Blitz3D uses multipass rendering techniques when hardware
texturing units are not available.
</p>
<p>
See the <a href=#bbbrushtexture>bbBrushTexture</a> command for more information about
working with multitextured surfaces.
</p>
See Also: <a href=#bbbrushtexture>bbBrushTexture</a>
EndRem
Function HWTexUnits()="bbHWTexUnits"

Rem
bbdoc: <p> Returns the yaw value of a vector.
about:
<table class="arg">
<tr><td class=argname>x#</td><td class=argvalue>x vector length</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y vector length</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z vector length</td></tr>
</table>
</p>
<p>
Yaw is a common name for rotation around the Y axis or in this
instance the compass heading in degrees if z is north and x is west.
</p>
See Also: <a href=#bbvectorpitch>bbVectorPitch</a> <a href=#bbentityyaw>bbEntityYaw</a>
EndRem
Function VectorYaw#(x#,y#,z#)="bbVectorYaw"

Rem
bbdoc: <p> Returns the pitch value of a vector.
about:
<table class="arg">
<tr><td class=argname>x#</td><td class=argvalue>x vector length</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y vector length</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z vector length</td></tr>
</table>
</p>
<p>
Pitch is a common name for rotation around the X axis or in this
instance the angle the vector is raised if y is up and the distance
x,z is forwards.
</p>
See Also: <a href=#bbvectoryaw>bbVectorYaw</a> <a href=#bbentitypitch>bbEntityPitch</a>
EndRem
Function VectorPitch#(x#,y#,z#)="bbVectorPitch"

Rem
bbdoc: <p> Transforms a point between coordinate systems.
about:
<table class="arg">
<tr><td class=argname>x#</td><td class=argvalue>x coordinate of a point in 3d space</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y coordinate of a point in 3d space</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z coordinate of a point in 3d space</td></tr>
<tr><td class=argname>source_entity</td><td class=argvalue>handle of source entity, or 0 for 3d world</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>handle of destination entity, or 0 for 3d world</td></tr>
</table>
</p>
<p>
After using <a href=#bbtformpoint>bbTFormPoint</a> the new coordinates can be
read with <a href=#bbtformedx>bbTFormedX</a>(), <a href=#bbtformedy>bbTFormedY</a>() and <a href=#bbtformedz>bbTFormedZ</a>().
</p>
<p>
See <a href=#bbentityx>bbEntityX</a>() for details about local coordinates.
</p>
<p>
Consider a sphere built with <a href=#bbcreatesphere>bbCreateSphere</a>().
</p>
<p>
The 'north pole' is at (0,1,0).
</p>
<p>
At first, local and global coordinates
are the same. However, as the sphere is moved,
turned and scaled the global coordinates
of the north pole change but it's always at
(0,1,0) in the sphere's local space.
</p>
See Also: <a href=#bbtformedx>bbTFormedX</a> <a href=#bbtformedy>bbTFormedY</a> <a href=#bbtformedz>bbTFormedZ</a> <a href=#bbtformvector>bbTFormVector</a> <a href=#bbtformnormal>bbTFormNormal</a>
EndRem
Function TFormPoint(x#,y#,z#,source_entity,dest_entity)="bbTFormPoint"

Rem
bbdoc: <p> Transforms a vector between coordinate systems.
about:
<table class="arg">
<tr><td class=argname>x#</td><td class=argvalue>x component of a vector in 3d space</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y component of a vector in 3d space</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z component of a vector in 3d space</td></tr>
<tr><td class=argname>source_entity</td><td class=argvalue>handle of source entity, or 0 for 3d world</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>handle of destination entity, or 0 for 3d world</td></tr>
</table>
</p>
<p>
After using <a href=#bbtformvector>bbTFormVector</a> the components of the resulting
vector can be read with <a href=#bbtformedx>bbTFormedX</a>(), <a href=#bbtformedy>bbTFormedY</a>() and
<a href=#bbtformedz>bbTFormedZ</a>().
</p>
<p>
Similar to <a href=#bbtformpoint>bbTFormPoint</a>, but operates on a vector. A vector
can be thought of as the 'displacement relative to current
location'.
</p>
<p>
For example, the vector (1,2,3) means one step to the right,
two steps up and three steps forward.
</p>
<p>
This is analogous to PositionEntity and MoveEntity.
</p>
See Also: <a href=#bbtformedx>bbTFormedX</a> <a href=#bbtformedy>bbTFormedY</a> <a href=#bbtformedz>bbTFormedZ</a> <a href=#bbtformpoint>bbTFormPoint</a> <a href=#bbtformnormal>bbTFormNormal</a>
EndRem
Function TFormVector(x#,y#,z#,source_entity,dest_entity)="bbTFormVector"

Rem
bbdoc: <p> Transforms a normal between coordinate systems
about:
<table class="arg">
<tr><td class=argname>x#</td><td class=argvalue>x component of a vector in 3d space</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y component of a vector in 3d space</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z component of a vector in 3d space</td></tr>
<tr><td class=argname>source_entity</td><td class=argvalue>handle of source entity, or 0 for 3d world</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>handle of destination entity, or 0 for 3d world</td></tr>
</table>
After
using <a href=#bbtformnormal>bbTFormNormal</a> the components of the result can be
read with <a href=#bbtformedx>bbTFormedX</a>(), <a href=#bbtformedy>bbTFormedY</a>()  and <a href=#bbtformedz>bbTFormedZ</a>().
</p>
<p>
After the transformation the new vector is
'normalized', meaning it is scaled to have length 1.
</p>
See Also: <a href=#bbtformedx>bbTFormedX</a> <a href=#bbtformedy>bbTFormedY</a> <a href=#bbtformedz>bbTFormedZ</a> <a href=#bbtformpoint>bbTFormPoint</a> <a href=#bbtformvector>bbTFormVector</a>
EndRem
Function TFormNormal(x#,y#,z#,source_entity,dest_entity)="bbTFormNormal"

Rem
bbdoc: <p> Returns the X component of the most recent <a href=#bbtformpoint>bbTFormPoint</a>, <a href=#bbtformvector>bbTFormVector</a> or <a href=#bbtformnormal>bbTFormNormal</a> operation.
about:
</p>
See Also: <a href=#bbtformedy>bbTFormedY</a> <a href=#bbtformedz>bbTFormedZ</a> <a href=#bbtformpoint>bbTFormPoint</a> <a href=#bbtformvector>bbTFormVector</a> <a href=#bbtformnormal>bbTFormNormal</a>
EndRem
Function TFormedX#()="bbTFormedX"

Rem
bbdoc: <p> Returns the Y component of the most recent <a href=#bbtformpoint>bbTFormPoint</a>, <a href=#bbtformvector>bbTFormVector</a> or <a href=#bbtformnormal>bbTFormNormal</a> operation.
about:
</p>
See Also: <a href=#bbtformedx>bbTFormedX</a> <a href=#bbtformedz>bbTFormedZ</a> <a href=#bbtformpoint>bbTFormPoint</a> <a href=#bbtformvector>bbTFormVector</a> <a href=#bbtformnormal>bbTFormNormal</a>
EndRem
Function TFormedY#()="bbTFormedY"

Rem
bbdoc: <p> Returns the Z component of the most recent <a href=#bbtformpoint>bbTFormPoint</a>, <a href=#bbtformvector>bbTFormVector</a> or <a href=#bbtformnormal>bbTFormNormal</a> operation.
about:
</p>
See Also: <a href=#bbtformedx>bbTFormedX</a> <a href=#bbtformedy>bbTFormedY</a> <a href=#bbtformpoint>bbTFormPoint</a> <a href=#bbtformvector>bbTFormVector</a> <a href=#bbtformnormal>bbTFormNormal</a>
EndRem
Function TFormedZ#()="bbTFormedZ"

Rem
bbdoc: <p> Position an entity at the position defined by the 3D coordinate (x,y,z) either relative to its parent position and orientation or optionally in world coordinates.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity to be positioned</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x co-ordinate that entity will be positioned at</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y co-ordinate that entity will be positioned at</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z co-ordinate that entity will be positioned at</td></tr>
<tr><td class=argname>global</td><td class=argvalue>False
</table>
</p>
<p>
In Blitz3D an entity typically faces towards the +z axis,
the y axis is the height of the entity and its left /
right position is the x axis.
</p>
<p>
In particular all entities including cameras are created
so the x axis points right, the y axis up and the
z axis forwards.
</p>
<p>
A child entity (one that is created with another as
its parent) will by default position itself in it's
parent's space unless the optional global of
<a href=#bbpositionentity>bbPositionEntity</a> is set to True in which case the
entity is positioned relative to the global axis
not its parent.
</p>
<p>
To move an entity a relative amount in respect to
its current position see the <a href=#bbmoveentity>bbMoveEntity</a>
and <a href=#bbtranslateentity>bbTranslateEntity</a> commands.
</p>
<p>
See the <a href=#bbupdateworld>bbUpdateWorld</a> command for details regarding
the effect of any collisions that may occur due to
the requested repositioning.
</p>
See Also: <a href=#bbentityx>bbEntityX</a> <a href=#bbmoveentity>bbMoveEntity</a> <a href=#bbtranslateentity>bbTranslateEntity</a> <a href=#bbupdateworld>bbUpdateWorld</a>
EndRem
Function PositionEntity(entity,x#,y#,z#,globalspace=0)="bbPositionEntity"

Rem
bbdoc: <p> Moves an entity relative to its current position and orientation.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity to be moved</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x amount that entity will be moved by</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y amount that entity will be moved by</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z amount that entity will be moved by</td></tr>
</table>
</p>
<p>
Typically the x,y,z values for a 'Z facing model' are:
</p>
<table class="data">
<tr><th class=data>Axis</th><th class=data>Direction</th></tr>
<tr><td class=data>X</td><td class=data>Right Left</td></tr>
<tr><td class=data>Y</td><td class=data>Up Down</td></tr>
<tr><td class=data>Z</td><td class=data>Forward Backwards </td></tr>
</table>
<p>
For movement that ignores the entities orientation see the
<a href=#bbtranslateentity>bbTranslateEntity</a> command.
</p>
<p>
To position an entity at an absolute location in parent
or world space see the <a href=#bbpositionentity>bbPositionEntity</a> command.
</p>
<p>
See the <a href=#bbupdateworld>bbUpdateWorld</a> command for details regarding
the effect of any collisions that may occur due to
the requested repositioning.
</p>
See Also: <a href=#bbentityx>bbEntityX</a> <a href=#bbtranslateentity>bbTranslateEntity</a> <a href=#bbpositionentity>bbPositionEntity</a> <a href=#bbupdateworld>bbUpdateWorld</a>
EndRem
Function MoveEntity(entity,x#,y#,z#)="bbMoveEntity"

Rem
bbdoc: <p> Translates an entity relative to its current position in the direction specified in either parent or global space
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity to be translated</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x amount that entity will be translated by</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y amount that entity will be translated by</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z amount that entity will be translated by</td></tr>
<tr><td class=argname>global</td><td class=argvalue>False
</table>
The direction vector by default is interpreted
as being in parent space.
</p>
<p>
<a href=#bbtranslateentity>bbTranslateEntity</a> is an alternative to <a href=#bbmoveentity>bbMoveEntity</a>
when an entity must be moved in a global direction
such as straight down for gravity.
</p>
<p>
Unlike <a href=#bbmoveentity>bbMoveEntity</a> an entities orientation is ignored
in the resulting calculation.
</p>
<p>
To move an entity with coordinates that represent
a vector relative to its own orientation use the
<a href=#bbmoveentity>bbMoveEntity</a> command.
</p>
<p>
See the <a href=#bbupdateworld>bbUpdateWorld</a> command for details regarding
the effect of any collisions that may occur due to
the requested repositioning.
</p>
See Also: <a href=#bbmoveentity>bbMoveEntity</a> <a href=#bbpositionentity>bbPositionEntity</a> <a href=#bbpositionmesh>bbPositionMesh</a> <a href=#bbupdateworld>bbUpdateWorld</a>
EndRem
Function TranslateEntity(entity,x#,y#,z#,globalspace=0)="bbTranslateEntity"

Rem
bbdoc: <p> Returns the X component of the entities current position in local or optionally global space.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>global</td><td class=argvalue>True
</table>
</p>
<p>
The X axis is tradionally the left to right axis in Blitz3D
space when facing towards Z either from the parents point
of view or optionally from the center of the world.
</p>
See Also: <a href=#bbentityy>bbEntityY</a> <a href=#bbentityz>bbEntityZ</a>
EndRem
Function EntityX#(entity,globalspace=0)="bbEntityX"

Rem
bbdoc: <p> Returns the Y component of the entities current position in local or optionally global space.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>handle of Loaded or Created Entity</td></tr>
<tr><td class=argname>global</td><td class=argvalue>True
</table>
</p>
<p>
The Y axis is tradionally the down to up axis in Blitz3D
space when facing towards Z either from the parents point
of view or optionally from the center of the world.
</p>
See Also: <a href=#bbentityx>bbEntityX</a> <a href=#bbentityz>bbEntityZ</a>
EndRem
Function EntityY#(entity,globalspace=0)="bbEntityY"

Rem
bbdoc: <p> Returns the Z component of the entities current position in local or optionally global space.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>handle of Loaded or Created Entity</td></tr>
<tr><td class=argname>global</td><td class=argvalue>True
</table>
</p>
<p>
The Z axis is tradionally the from behind to infront axis
in Blitz3D space from the parents current point of view
or optionally from the center of the world.
</p>
See Also: <a href=#bbentityx>bbEntityX</a> <a href=#bbentityy>bbEntityY</a>
EndRem
Function EntityZ#(entity,globalspace=0)="bbEntityZ"

Rem
bbdoc: <p> Rotates an entity relative to its parent's orientation or if specified in relation to the global axis.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of the entity to be rotated</td></tr>
<tr><td class=argname>pitch#</td><td class=argvalue>angle in degrees of rotation around x</td></tr>
<tr><td class=argname>yaw#</td><td class=argvalue>angle in degrees of rotation around y</td></tr>
<tr><td class=argname>roll#</td><td class=argvalue>angle in degrees of rotation around z</td></tr>
<tr><td class=argname>global</td><td class=argvalue>True
</table>
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Rotation Axis</th><th class=data>Description</th></tr>
<tr><td class=data>Pitch</td><td class=data>Around x axis</td><td class=data>Equivalent to tilting forward/backwards</td></tr>
<tr><td class=data>Yaw</td><td class=data>Around y axis</td><td class=data> Equivalent to turning left/right</td></tr>
<tr><td class=data>Roll</td><td class=data>Around z axis</td><td class=data> Equivalent to tilting left/right</td></tr>
</table>
<p>
See the <a href=#bbturnentity>bbTurnEntity</a> command for rotating entities starting
from their current position.
</p>
See Also: <a href=#bbturnentity>bbTurnEntity</a> <a href=#bbrotatemesh>bbRotateMesh</a>
EndRem
Function RotateEntity(entity,pitch#,yaw#,roll#,globalspace=0)="bbRotateEntity"

Rem
bbdoc: <p> Turns an entity relative to its current rotatation.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity to be rotated</td></tr>
<tr><td class=argname>pitch#</td><td class=argvalue>angle in degrees that entity will be pitched</td></tr>
<tr><td class=argname>yaw#</td><td class=argvalue>angle in degrees that entity will be yawed</td></tr>
<tr><td class=argname>roll#</td><td class=argvalue>angle in degrees that entity will be rolled</td></tr>
<tr><td class=argname>global</td><td class=argvalue>True
</table>
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Rotation Axis</th><th class=data>Description</th></tr>
<tr><td class=data>Pitch</td><td class=data>Around x axis</td><td class=data>Equivalent to tilting forward/backwards</td></tr>
<tr><td class=data>Yaw</td><td class=data>Around y axis</td><td class=data> Equivalent to turning left/right</td></tr>
<tr><td class=data>Roll</td><td class=data>Around z axis</td><td class=data> Equivalent to tilting left/right</td></tr>
</table>
<p>
Unlike <a href=#bbrotateentity>bbRotateEntity</a> the <b>pitch</b>, <b>yaw</b> and <b>roll</b> rotations are applied
to the object starting from its current rotation.
</p>
See Also: <a href=#bbrotateentity>bbRotateEntity</a> <a href=#bbpointentity>bbPointEntity</a>
EndRem
Function TurnEntity(entity,pitch#,yaw#,roll#,globalspace=0)="bbTurnEntity"

Rem
bbdoc: <p> Points one entity at another by adjusting its pitch and yaw rotations.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>target</td><td class=argvalue>target entity handle</td></tr>
<tr><td class=argname>roll#</td><td class=argvalue>roll angle of entity</td></tr>
</table>
</p>
<p>
The optional <b>roll</b> parameter allows you to specify a
rotation around the z axis to complete the rotation.
</p>
<p>
Use the <a href=#bbaligntovector>bbAlignToVector</a> command for aiming an entity
(typically its z axis) using a specified alignment
vector and smoothing rate.
</p>
<p class="hint">
Invisible pivot entities make useful targets for pointing
an entity towards any arbitrary direction.
</p>
See Also: <a href=#bbaligntovector>bbAlignToVector</a>
EndRem
Function PointEntity(entity,target,roll#=0)="bbPointEntity"

Rem
bbdoc: <p> Aligns an entity axis to a vector.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>vector_x#</td><td class=argvalue>vector x</td></tr>
<tr><td class=argname>vector_y#</td><td class=argvalue>vector y</td></tr>
<tr><td class=argname>vector_z#</td><td class=argvalue>vector z</td></tr>
<tr><td class=argname>axis</td><td class=argvalue>axis of entity that will be aligned to vector</td></tr>
<tr><td class=argname>rate#</td><td class=argvalue>rate at which entity is aligned from current orientation to vector orientation.</td></tr>
</table>
</p>
<p>
Rate should be in the range 0 to 1, 0.1 for smooth transition and 1.0 for 'snap'
transition. Defaults to 1.0.
</p>
<table class="data">
<tr><th class=data>Axis</th><th class=data>Description</th></tr>
<tr><td class=data>1</td><td class=data>X axis</td></tr>
<tr><td class=data>2</td><td class=data>Y axis</td></tr>
<tr><td class=data>3</td><td class=data>Z axis</td></tr>
</table>
<p>
The <a href=#bbaligntovector>bbAlignToVector</a> command offers an advanced alternative to the
<a href=#bbrotateentity>bbRotateEntity</a>, <a href=#bbturnentity>bbTurnEntity</a> and <a href=#bbpointentity>bbPointEntity</a> commands. <a href=#bbaligntovector>bbAlignToVector</a>
provides a method of steering entities by turning them so a
specified axis aligns to a precalculated directions in an optionally
smooth manner.
</p>
See Also: <a href=#bbrotateentity>bbRotateEntity</a> <a href=#bbturnentity>bbTurnEntity</a> <a href=#bbpointentity>bbPointEntity</a>
EndRem
Function AlignToVector(entity,vector_x#,vector_y#,vector_z#,axis,rate#=1.0)="bbAlignToVector"

Rem
bbdoc: <p> Returns the roll angle of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity that will have roll angle returned</td></tr>
<tr><td class=argname>global</td><td class=argvalue>true if the roll angle returned should be relative to 0 rather than a parent entities  roll angle. False by default.</td></tr>
</table>
</p>
<p>
The roll angle is also the z angle
of an entity.
</p>
EndRem
Function EntityRoll#(entity,globalspace=0)="bbEntityRoll"

Rem
bbdoc: <p> Returns the yaw angle of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity that will have yaw angle returned</td></tr>
<tr><td class=argname>global</td><td class=argvalue>true if the yaw angle returned should be relative to 0 rather than a parent entities yaw angle. False by default.</td></tr>
</table>
</p>
<p>
The yaw angle is also the y angle of an entity.
</p>
EndRem
Function EntityYaw#(entity,globalspace=0)="bbEntityYaw"

Rem
bbdoc: <p> Returns the pitch angle of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of entity that will have pitch angle returned</td></tr>
<tr><td class=argname>global</td><td class=argvalue>true if the pitch angle returned should be relative to 0 rather than a parent entities pitch angle. False by default.</td></tr>
</table>
</p>
<p>
The pitch angle is also the x angle of an entity.
</p>
EndRem
Function EntityPitch#(entity,globalspace=0)="bbEntityPitch"

Rem
bbdoc: <p> Returns the value of an element from within an entities transformation matrix.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>row</td><td class=argvalue>matrix row index</td></tr>
<tr><td class=argname>column</td><td class=argvalue>matrix column index</td></tr>
</table>
</p>
<p>
The transformation matrix is what is used by Blitz internally
to position, scale and rotate entities.
</p>
<p>
GetMatElement is intended for
use by advanced users only.
</p>
EndRem
Function GetMatElement#(entity,row,column)="bbGetMatElement"

Rem
bbdoc: <p> Scales the size of an entity a scalar amount in each axis.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>name of the entity to be scaled</td></tr>
<tr><td class=argname>x_scale#</td><td class=argvalue>x scalar value</td></tr>
<tr><td class=argname>y_scale#</td><td class=argvalue>y scalar value</td></tr>
<tr><td class=argname>z_scale#</td><td class=argvalue>z scalar value</td></tr>
<tr><td class=argname>global</td><td class=argvalue>True means relative to world not parent's scale</td></tr>
</table>
</p>
<p>
The values 1,1,1 are the default scale of a newly created
entity which has no affect on the entity size.
</p>
<p>
A scalar values of 2 will double the size of an entity in the
specified axis, 0.5 will halve the size.
</p>
<p>
Negative scalar values invert that entities axis and may
result in reversed facing surfaces.
</p>
<p>
A global value of False is default and multiplies the specified
scale with the entity parent's scale. A global value of True
ignores the scale of the parent.
</p>
<p class="hint">
A scale value of 0,0,0 should be avoided as it can produce
dramatic performance problems on some computers due to the
infinite nature of the surface normals it produces.
</p>
See Also: <a href=#bbscalemesh>bbScaleMesh</a> <a href=#bbfitmesh>bbFitMesh</a>
EndRem
Function ScaleEntity(entity,x_scale#,y_scale#,z_scale#,globalspace=0)="bbScaleEntity"

Rem
bbdoc: <p> Attaches an entity to a parent.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity handle</td></tr>
<tr><td class=argname>global</td><td class=argvalue>true for the child entity to retain its global position  and orientation. Defaults to true.</td></tr>
</table>
</p>
<p>
Parent may be 0, in which case the entity  will have no parent.
</p>
EndRem
Function EntityParent(entity,parent,globalspace=True)="bbEntityParent"

Rem
bbdoc: <p> Returns an entity's parent.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
EndRem
Function GetParent(entity)="bbGetParent"

Rem
bbdoc: <p> Returns the number of children of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
EndRem
Function CountChildren(entity)="bbCountChildren"

Rem
bbdoc: <p> Returns a particular child of a specified entity based on a valid index which should be in the range 1...CountChildren(  entity ) inclusive.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of child entity.</td></tr>
</table>
</p>
See Also: <a href=#bbcountchildren>bbCountChildren</a> <a href=#bbfindchild>bbFindChild</a>
EndRem
Function GetChild(entity,index)="bbGetChild"

Rem
bbdoc: <p> Searches all the children and descendants of those children for an entity with a name matching child_name$.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>child_name$</td><td class=argvalue>child name to find within entity</td></tr>
</table>
</p>
<p>
Returns the handle of the first entity with a matching name or 0 if none
found.
</p>
See Also: <a href=#bbentityname>bbEntityName</a> <a href=#bbnameentity>bbNameEntity</a> <a href=#bbgetchild>bbGetChild</a>
EndRem
Function FindChild(entity,child_name$z)="bbFindChild"

Rem
bbdoc: <p> Shows an entity
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
Very
much the opposite of HideEntity.
</p>
<p>
Once an entity has been hidden using <a href=#bbhideentity>bbHideEntity</a>,  use <a href=#bbshowentity>bbShowEntity</a> to make
it visible and involved in collisions again.
</p>
<p>
Note that ShowEntity has no effect if the enitities' parent object
is hidden.
</p>
<p>
Entities are shown by default after creating/loading them,
so you should  only need to use ShowEntity after using HideEntity.
</p>
<p>
ShowEntity affects the specified entity only - child entities are not affected.
</p>
EndRem
Function ShowEntity(entity)="bbShowEntity"

Rem
bbdoc: <p> Hides an entity, so that it is no longer visible, and is no longer involved  in collisions.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
The main purpose of hide entity is to allow
you to create entities  at the beginning of a program, hide them, then copy
them and show as necessary  in the main game. This is more efficient than
creating entities mid-game.
</p>
<p>
If you wish to hide an entity so that it
is no longer visible but still involved  in collisions, then use EntityAlpha
0 instead.  This will make an entity completely transparent.
</p>
<p>
HideEntity
affects the specified entity and all of its child entities, if  any exist.
</p>
EndRem
Function HideEntity(entity)="bbHideEntity"

Rem
bbdoc: <p> Enables auto fading for an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>near#</td><td class=argvalue>distance from camera when entity begins to fade</td></tr>
<tr><td class=argname>far#</td><td class=argvalue>distance from camera entity becomes completely invisible</td></tr>
</table>
</p>
<p>
<a href=#bbentityautofade>bbEntityAutoFade</a> causes an entities alpha level to be adjusted at
distances between near and far to create a 'fade-in' effect.
</p>
See Also: <a href=#bbentityalpha>bbEntityAlpha</a>
EndRem
Function EntityAutoFade(entity,near#,far#)="bbEntityAutoFade"

Rem
bbdoc: <p> Sets the drawing order for an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>order</td><td class=argvalue>order that entity will be drawn in</td></tr>
</table>
</p>
<p>
An order value of 0 will mean the  entity is drawn normally.
A value greater than 0 will mean that entity is drawn  first, behind everything
else. A value less than 0 will mean the entity is drawn  last, in front
of everything else.
</p>
<p>
Setting an entities order to non-0 also disables
z-buffering for the entity,  so should be only used for simple, convex entities
like skyboxes, sprites etc.
</p>
<p>
EntityOrder affects the specified entity
but none of its child entities,  if any exist.
</p>
EndRem
Function EntityOrder(entity,order)="bbEntityOrder"

Rem
bbdoc: <p> FreeEntity will free up the internal resources associated with a particular entity and remove it from the scene.
about:
<table class="arg">
<tr><td class=argname>EntityHandle</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
Handle must be valid entity hanlde such as returned by
function such as CreateCube(), CreateLight(), LoadMesh() etc.
</p>
<p>
This command will also free all children entities parented
to the entity.
</p>
<p>
See the <a href=#bbclearworld>bbClearWorld</a> command for freeing all entities with
a single call.
</p>
<p class="hint">
Any references to the entity or its children become
invalid after a call to <a href=#bbfreeentity>bbFreeEntity</a> so care should be
taken as any subsquent use of a handle to a freed
entity will cause a runtime error.
</p>
See Also: <a href=#bbfreetexture>bbFreeTexture</a> <a href=#bbfreebrush>bbFreeBrush</a> <a href=#bbclearworld>bbClearWorld</a>
EndRem
Function FreeEntity(EntityHandle)="bbFreeEntity"

Rem
bbdoc: <p> Sets the color of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>red#</td><td class=argvalue>red value of entity</td></tr>
<tr><td class=argname>green#</td><td class=argvalue>green value of entity</td></tr>
<tr><td class=argname>blue#</td><td class=argvalue>blue value of entity</td></tr>
</table>
</p>
<p>
See the <a href=#bbcolor>bbColor</a> command for more information on combining
red, green and blue values to define colors.
</p>
<p>
The <a href=#bbpaintentity>bbPaintEntity</a> command can also be used to set the color
properties of individual entities.
</p>
<p>
The <a href=#bbpaintsurface>bbPaintSurface</a> command is used to set the color properties
of the individual surfaces of a mesh.
</p>
<p class="hint">
The final render color of a surface of an entity mesh is calculated
by multiplying the entity color with the surface color.
</p>
See Also: <a href=#bbpaintentity>bbPaintEntity</a> <a href=#bbpaintsurface>bbPaintSurface</a> <a href=#bbentityalpha>bbEntityAlpha</a>
EndRem
Function EntityColor(entity,red#,green#,blue#)="bbEntityColor"

Rem
bbdoc: <p> Sets the alpha or translucent level of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>alpha#</td><td class=argvalue>alpha level of entity</td></tr>
</table>
</p>
<p>
The <b>alpha</b> value should be between 0.0 and 1.0 which
correspond to the range from transparent
(effectively invisible) to totally opaque:
</p>
<table class="data">
<tr><th class=data>Alpha Value</th><th class=data>Effect</th></tr>
<tr><td class=data>0.0</td><td class=data>invisible</td></tr>
<tr><td class=data>0.25</td><td class=data>very transparent</td></tr>
<tr><td class=data>0.50</td><td class=data>semi transparent</td></tr>
<tr><td class=data>0.75</td><td class=data>slightly transparent</td></tr>
<tr><td class=data>1.00</td><td class=data>completely opaque</td></tr>
</table>
<p>
Unlike <a href=#bbhideentity>bbHideEntity</a> an entity made invisible with
an <b>alpha</b> of 0.0 still participates in any collisions.
</p>
<p>
The default <b>alpha</b> level of an entity is 1.0.
</p>
<p>
Use the <a href=#bbbrushalpha>bbBrushAlpha</a> and <a href=#bbpaintsurface>bbPaintSurface</a> commands for
affecting transparency on a surface by surface basis.
</p>
See Also: <a href=#bbentityautofade>bbEntityAutoFade</a> <a href=#bbbrushalpha>bbBrushAlpha</a> <a href=#bbpaintentity>bbPaintEntity</a> <a href=#bbpaintsurface>bbPaintSurface</a> <a href=#bb>bb</a>
EndRem
Function EntityAlpha(entity,alpha#)="bbEntityAlpha"

Rem
bbdoc: <p> Sets the shininess (specularity index) of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>shininess#</td><td class=argvalue>shininess of entity</td></tr>
</table>
</p>
<p>
The shininess# value should be a floating point number in the
range 0.0-1.0. The default shininess setting is 0.0.
</p>
<p>
Shininess is the extra brightness that appears on a surface
when it is oriented to reflect light directly towards the
camera.
</p>
<p>
A low <b>shininess</b> produces a dull non reflective surface while
a high <b>shininess</b> approaching 1.0 will make a surface appear
polished and shiny.
</p>
<p>
Use the <a href=#bbbrushshininess>bbBrushShininess</a> and <a href=#bbpaintsurface>bbPaintSurface</a> commands for
affecting shininess on a surface by surface basis.
</p>
See Also: <a href=#bbbrushshininess>bbBrushShininess</a>
EndRem
Function EntityShininess(entity,shininess#)="bbEntityShininess"

Rem
bbdoc: <p> Applies a texture to an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>texture</td><td class=argvalue>texture handle</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>frame of texture. Defaults to 0.</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index number of texture. Should be in the range to 0-7. Defaults  to 0.</td></tr>
</table>
</p>
<p>
The optional <b>frame</b> parameter specifies  which texture
animation frame should be used as the texture.
</p>
<p>
The <b>index</b> parameter specifies an optional texturing channel
when using multitexturing. See the <a href=#bbtextureblend>bbTextureBlend</a> command for
more details on mixing multiple textures on the same surface.
</p>
<p>
Texturing requires the use of a valid texture returned by
the <a href=#bbcreatetexture>bbCreateTexture</a> or <a href=#bbloadtexture>bbLoadTexture</a> functions and a mesh based
entity with texturing coordinates assigned to its vertices.
</p>
<p class="hint">
Primitives created with <a href=#bbcreatecube>bbCreateCube</a>, <a href=#bbcreateplane>bbCreatePlane</a>,
<a href=#bbcreatesphere>bbCreateSphere</a> etc. contain texturing information known
as UV coordinates. Howeever model files and surfaces
created programatically may be missing this information
and will consequently fail to display textures correctly
on their surfaces.
</p>
See Also: <a href=#bbloadtexture>bbLoadTexture</a> <a href=#bbbrushtexture>bbBrushTexture</a> <a href=#bbvertextexcoords>bbVertexTexCoords</a>
EndRem
Function EntityTexture(entity,texture,frame=0,index=0)="bbEntityTexture"

Rem
bbdoc: <p> Sets the blending mode of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>blend</td><td class=argvalue>blend mode of the entity.</td></tr>
</table>
</p>
<p>
A blending mode determines the way in which the color and
alpha (RGBA) on an entity's surface (source) is combined
with the color of the background (destination) during rendering.
</p>
<p>
The possible blend modes are:
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>BLEND_ALPHA</td><td class=data>1</td><td class=data>Combines <b>alpha</b> amount of src with 1-<b>alpha</b> of dest</td><td class=data>most things</td></tr>
<tr><td class=data>BLEND_MULT</td><td class=data>2</td><td class=data>Blends src color with dest</td><td class=data>lightmaps</td></tr>
<tr><td class=data>BLEND_ADD</td><td class=data>Adds src color to dest</td><td class=data>explosions lasers etc.</td></tr>
</table>
<p>
Alpha - blends the pixels according to the Alpha value. This is
roughly done to the formula:
</p>
<p>
Rr = ( An * Rn ) + ( ( 1.0 - An ) * Ro )
</p>
<p>
Gr = ( An * Gn ) + ( ( 1.0 - An ) * Go )
</p>
<p>
Br = ( An * Bn ) + ( ( 1.0 - An ) * Bo )
</p>
<p>
Where R = Red, G = Green, B = Blue, n = new pixel color values,
r = resultant color values, o = old pixel color values.
</p>
<p>
Alpha blending is the default blending mode and is used
with most world objects.
</p>
<p>
Multiply - darkens the underlying pixels. If you think of each RGB value as
being on a scale from 0% to 100%, where 0 = 0% and 255 = 100%, the multiply
blend mode will multiply the red, green and blue values individually together
in order to get the new RGB value, roughly according to:
</p>
<p>
Rr = ( ( Rn / 255.0 ) * ( Ro / 255.0 ) ) * 255.0
</p>
<p>
Gr = ( ( Gn / 255.0 ) * ( Go / 255.0 ) ) * 255.0
</p>
<p>
Br = ( ( Bn / 255.0 ) * ( Bo / 255.0 ) ) * 255.0
</p>
<p>
The alpha value has no effect with multiplicative blending.
</p>
<p>
Blending a RGB value of 255, 255, 255 will make no difference, while an
RGB value of 128, 128, 128 will darken the pixels by a factor of 2 and an
RGB value of 0, 0, 0 will completely blacken out the resultant pixels.
</p>
<p>
An RGB value of 0, 255, 255 will remove the red component of the underlying
pixel while leaving the other color values untouched.
</p>
<p>
Multiply blending is most often used for lightmaps, shadows or anything else
that needs to 'darken' the resultant pixels.
</p>
<p>
Add - additive blending will add the new color values to the old, roughly
according to:
</p>
<p>
Rr = ( Rn * An ) + Ro
</p>
<p>
Gr = ( Gn * An ) + Go
</p>
<p>
Br = ( Bn * An ) + Bo
</p>
<p>
The resultant RGB values are clipped out at 255, meaning
that multiple additive effects can quickly cause visible
banding from smooth gradients.
</p>
<p>
Additive blending is extremely useful for effects such as
laser shots and fire.
</p>
See Also: <a href=#bbbrushblend>bbBrushBlend</a> <a href=#bbtextureblend>bbTextureBlend</a> <a href=#bbentityalpha>bbEntityAlpha</a>
EndRem
Function EntityBlend(entity,blend)="bbEntityBlend"

Rem
bbdoc: <p> Sets miscellaneous effects for an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>fx</td><td class=argvalue>fx flags</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Flag</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>FX_NONE</td><td class=data>0</td><td class=data>Nothing (default)</td></tr>
<tr><td class=data>FX_FULLBRIGHT</td><td class=data>1</td><td class=data>FullBright</td></tr>
<tr><td class=data>FX_VERTEXCOLOR</td><td class=data>2</td><td class=data>EnableVertexColors</td></tr>
<tr><td class=data>FX_FLATSHADED</td><td class=data>4</td><td class=data>FlatShaded</td></tr>
<tr><td class=data>FX_NOFOG</td><td class=data>8</td><td class=data>DisableFog</td></tr>
<tr><td class=data>FX_DOUBLESIDED</td><td class=data>16</td><td class=data>DoubleSided</td></tr>
<tr><td class=data>FX_VERTEXALPHA</td><td class=data>32</td><td class=data>EnableVertexAlpha</td></tr>
</table>
<p>
Flags can be added to combine two or more effects.
</p>
<p>
For example, specifying a flag of 3 (1+2) will result in both
FullBright and EnableVertexColor effects to be enabled for all
the surfaces of the specified entity.
</p>
<p>
See <a href=#bbbrushfx>bbBrushFX</a> and <a href=#bbpaintsurface>bbPaintSurface</a> for details on controlling
FX on a surface by surface basis.
</p>
<p>
FullBright - disables standard diffuse and specular lighting
caclulations during rendering so surface appears at 100%
brightness.
</p>
<p>
EnableVertexColors - vertex color information is used
instead of surface colors when using vertex lighting
techniques.
</p>
<p>
FlatShaded - uses lighting information from first vertex of
each triangle instead of interpolating between all three as
per default smooth shading.
</p>
<p>
DisableFog - disables fogging calulations.
</p>
<p>
DoubleSided- disables the back face culling method making
both front facing and back facing sides of a surfaces
visible.
</p>
<p>
EnableVertexAlpha - ensures the surface is treated as transparent
by the Blitz3D rendering pipeline.
</p>
See Also: <a href=#bbbrushfx>bbBrushFX</a> <a href=#bbvertexcolor>bbVertexColor</a>
EndRem
Function EntityFX(entity,fx)="bbEntityFX"

Rem
bbdoc: <p> Paints an entity with a brush.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
</table>
</p>
<p>
<a href=#bbpaintentity>bbPaintEntity</a> applies all the surface rendering properties
including color, alpha, texture, fx and blending modes
to the entity specified.
</p>
<p>
See the <a href=#bbcreatebrush>bbCreateBrush</a> function for details about creating
a brush.
</p>
<p>
Use the <a href=#bbpaintmesh>bbPaintMesh</a> command to set all the surface properties
of a mesh entity and <a href=#bbpaintsurface>bbPaintSurface</a> for modifying rendering
attributes on a particular surface.
</p>
<p>
See the <a href=#bbentitycolor>bbEntityColor</a> command for information about how
entity and surface properties are combined by the Blitz3D
rendering pipeline.
</p>
See Also: <a href=#bbentitycolor>bbEntityColor</a> <a href=#bbcreatebrush>bbCreateBrush</a> <a href=#bbloadbrush>bbLoadBrush</a> <a href=#bbpaintmesh>bbPaintMesh</a> <a href=#bbpaintsurface>bbPaintSurface</a>
EndRem
Function PaintEntity(entity,brush)="bbPaintEntity"

Rem
bbdoc: <p> Configures method and response for collisions between two entities of the specified collision types.
about:
<table class="arg">
<tr><td class=argname>src_type</td><td class=argvalue>entity type to be checked for collisions.</td></tr>
<tr><td class=argname>dest_type</td><td class=argvalue>entity type to be collided with.</td></tr>
<tr><td class=argname>detectionmethod</td><td class=argvalue>collision detection method.</td></tr>
<tr><td class=argname>response</td><td class=argvalue>what the source entity does when a collision occurs.</td></tr>
</table>
</p>
<p>
The <b>method</b> parameter can be one of the following:
</p>
<table class="data">
<tr><th class=data>Method</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>COLLIDE_SPHERESPHERE</td><td class=data>1</td><td class=data>Ellipsoid-to-ellipsoid collisions</td></tr>
<tr><td class=data>COLLIDE_SPHEREPOLY</td><td class=data>2</td><td class=data>Ellipsoid-to-polygon collisions</td></tr>
<tr><td class=data>COLLIDE_SPHEREBOX</td><td class=data>3</td><td class=data>Ellipsoid-to-box collisions</td></tr>
</table>
<p>
The <b>response</b> parameter can be one of the following:
</p>
<table class="data">
<tr><th class=data>Response</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>COLLIDE_STOP</td><td class=data>1</td><td class=data>source entity halts at point of collision</td></tr>
<tr><td class=data>COLLIDE_SLIDE1</td><td class=data>2</td><td class=data>slide source entity along the collision plane</td></tr>
<tr><td class=data>COLLIDE_SLIDE2</td><td class=data>3</td><td class=data>same as slide1 but y component ignored</td></tr>
</table>
<p>
After calling <a href=#bbupdateworld>bbUpdateWorld</a> the <a href=#bbcountcollisions>bbCountCollisions</a>
command can be used to detect collisions incurred
by each entity and information about each of those
collisions is returned by functions such as
<a href=#bbentitycollided>bbEntityCollided</a>, <a href=#bbcollisionx>bbCollisionX</a>, <a href=#bbcollisionnx>bbCollisionNX</a> etc.
</p>
<p class="hint">
A series of calls to the <a href=#bbcollisions>bbCollisions</a> command is usually
only required during a game's initialization and not
every game loop as <a href=#bbcollisions>bbCollisions</a> settings remain effective
until a call to <a href=#bbclearcollisions>bbClearCollisions</a> or a call to <a href=#bbcollisions>bbCollisions</a>
with matching <b>source</b> and <b>target</b> entity types overwrites
the existing method and reponse settings.
</p>
See Also: <a href=#bbentitybox>bbEntityBox</a> <a href=#bbentityradius>bbEntityRadius</a> <a href=#bbcollisions>bbCollisions</a> <a href=#bbentitytype>bbEntityType</a> <a href=#bbresetentity>bbResetEntity</a>
EndRem
Function Collisions(src_type,dest_type,detectionmethod,response)="bbCollisions"

Rem
bbdoc: <p> Clears the internal collision behavior table.
about:
</p>
<p>
Whenever a <a href=#bbcollisions>bbCollisions</a> command is used to enable collisions
between two different entity types, an entry is added to
an internal collision behavior table used by the <a href=#bbupdateworld>bbUpdateWorld</a>
command.
</p>
<p>
<a href=#bbclearcollisions>bbClearCollisions</a> clears the internal collision behavior
table and has no affect on current entity collision state.
</p>
See Also: <a href=#bbcollisions>bbCollisions</a> <a href=#bbupdateworld>bbUpdateWorld</a> <a href=#bbresetentity>bbResetEntity</a>
EndRem
Function ClearCollisions()="bbClearCollisions"

Rem
bbdoc: <p> Sets the collision type for an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>collision_type</td><td class=argvalue>collision type of entity. Must be in the range 0-999.</td></tr>
<tr><td class=argname>recursive</td><td class=argvalue>true to apply collision type to entity's children. Defaults to false.</td></tr>
</table>
</p>
<p>
A collision_type value of 0 indicates that no collision checking will
occur with that entity.
</p>
<p>
A collision value of 1-999 enables collision checking for the specified
entity and optionally all its children.
</p>
<p>
The <a href=#bbupdateworld>bbUpdateWorld</a> command uses the currently active <a href=#bbcollisions>bbCollisions</a> rules
to perform various collision responses for the overlapping of entities
that have a corresponding <a href=#bbentitytype>bbEntityType</a>.
</p>
See Also: <a href=#bbcollisions>bbCollisions</a> <a href=#bbgetentitytype>bbGetEntityType</a> <a href=#bbentitybox>bbEntityBox</a> <a href=#bbentityradius>bbEntityRadius</a>
EndRem
Function EntityType(entity,collision_type,recursive=0)="bbEntityType"

Rem
bbdoc: <p> Returns the collision type of an entity as set by the EntityType command.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
See Also: <a href=#bbentitytype>bbEntityType</a> <a href=#bbentitybox>bbEntityBox</a> <a href=#bbentityradius>bbEntityRadius</a> <a href=#bbcollisions>bbCollisions</a> <a href=#bbresetentity>bbResetEntity</a>
EndRem
Function GetEntityType(entity)="bbGetEntityType"

Rem
bbdoc: <p> Resets the collision state of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
See Also: <a href=#bbentitybox>bbEntityBox</a> <a href=#bbentityradius>bbEntityRadius</a> <a href=#bbcollisions>bbCollisions</a> <a href=#bbentitytype>bbEntityType</a> <a href=#bbgetentitytype>bbGetEntityType</a>
EndRem
Function ResetEntity(entity)="bbResetEntity"

Rem
bbdoc: <p> Sets the radius of an entity's collision sphere or if a <b>y_radius</b> is specified the dimenstions of a collision ellipsoid.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>x_radius#</td><td class=argvalue>x radius of entity's collision ellipsoid</td></tr>
<tr><td class=argname>y_radius#</td><td class=argvalue>y radius of entity's collision ellipsoid</td></tr>
</table>
</p>
<p>
An entity radius should be set for all entities
involved in ellipsoidal collisions.
</p>
<p>
All entity types used as source entities in the
<a href=#bbcollisions>bbCollisions</a> table (as collisions are always
ellipsoid-to-something), and any destination entity
types specified in method 1 type <a href=#bbcollisions>bbCollisions</a>
entries (ellipsoid-to-ellipsoid collisions)
require an <a href=#bbentityradius>bbEntityRadius</a>.
</p>
See Also: <a href=#bbentitybox>bbEntityBox</a> <a href=#bbcollisions>bbCollisions</a> <a href=#bbentitytype>bbEntityType</a>
EndRem
Function EntityRadius(entity,x_radius#,y_radius#=0)="bbEntityRadius"

Rem
bbdoc: <p> Sets the dimensions of an entity's collision box.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle#</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x position of entity's collision box</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y position of entity's collision box</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z position of entity's collision box</td></tr>
<tr><td class=argname>width#</td><td class=argvalue>width of entity's collision box</td></tr>
<tr><td class=argname>height#</td><td class=argvalue>height of entity's collision box</td></tr>
<tr><td class=argname>depth#</td><td class=argvalue>depth of entity's collision box</td></tr>
</table>
</p>
<p>
Any entity types featured as the destination of
type 3 <a href=#bbcollisions>bbCollisions</a> (ellipsoid to box) require
an <a href=#bbentitybox>bbEntityBox</a> to define their collision space.
</p>
See Also: <a href=#bbentityradius>bbEntityRadius</a> <a href=#bbcollisions>bbCollisions</a> <a href=#bbentitytype>bbEntityType</a>
EndRem
Function EntityBox(entity,x#,y#,z#,width#,height#,depth#)="bbEntityBox"

Rem
bbdoc: <p> Returns the handle of the entity of the specified type that collided with the specified entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>src_type</td><td class=argvalue>type of entity</td></tr>
</table>
</p>
<p>
Usually the <a href=#bbcountcollisions>bbCountCollisions</a> function is used after an
<a href=#bbupdateworld>bbUpdateWorld</a> with each collision being processed individually
with the collision specific <a href=#bbcollisionx>bbCollisionX</a>, <a href=#bbcollisiony>bbCollisionY</a>, <a href=#bbcollisionz>bbCollisionZ</a>,
<a href=#bbcollisionnx>bbCollisionNX</a>, <a href=#bbcollisionny>bbCollisionNY</a>, <a href=#bbcollisionnz>bbCollisionNZ</a>, <a href=#bbcountcollisions>bbCountCollisions</a>,
<a href=#bbentitycollided>bbEntityCollided</a>, <a href=#bbcollisiontime>bbCollisionTime</a>, <a href=#bbcollisionentity>bbCollisionEntity</a>, <a href=#bbcollisionsurface>bbCollisionSurface</a>
and <a href=#bbcollisiontriangle>bbCollisionTriangle</a> functions.
</p>
<p>
<a href=#bbentitycollided>bbEntityCollided</a> provides a simple alternative in situations
where a simple True or False collision result is required
in regards to the specified entity type.
</p>
See Also: <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bb>bb</a>
EndRem
Function EntityCollided(entity,src_type)="bbEntityCollided"

Rem
bbdoc: <p> Returns how many collisions an entity was involved in during the last UpdateWorld.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
The <a href=#bbcountcollisions>bbCountCollisions</a> function returns the maximum index value
that should be used when fetching collision specific data
such as returned by the <a href=#bbcollisionx>bbCollisionX</a>, <a href=#bbcollisiony>bbCollisionY</a>, <a href=#bbcollisionz>bbCollisionZ</a>,
<a href=#bbcollisionnx>bbCollisionNX</a>, <a href=#bbcollisionny>bbCollisionNY</a>, <a href=#bbcollisionnz>bbCollisionNZ</a>, <a href=#bbcountcollisions>bbCountCollisions</a>,
<a href=#bbentitycollided>bbEntityCollided</a>, <a href=#bbcollisiontime>bbCollisionTime</a>, <a href=#bbcollisionentity>bbCollisionEntity</a>, <a href=#bbcollisionsurface>bbCollisionSurface</a>
and <a href=#bbcollisiontriangle>bbCollisionTriangle</a> functions.
</p>
See Also: <a href=#bbupdateworld>bbUpdateWorld</a> <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CountCollisions(entity)="bbCountCollisions"

Rem
bbdoc: <p> Returns the world x coordinate of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index should  be in the range 1...CountCollisions( entity ) inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionX#(entity,index)="bbCollisionX"

Rem
bbdoc: <p> Returns the world y coordinate of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index should  be in the range 1...CountCollisions( entity ) inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionY#(entity,index)="bbCollisionY"

Rem
bbdoc: <p> Returns the world z coordinate of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index should  be in the range 1...CountCollisions( entity ) inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionZ#(entity,index)="bbCollisionZ"

Rem
bbdoc: <p> Returns the x component of the normal of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index  should be in the range 1...CountCollisions(  entity ) inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionNX#(entity,index)="bbCollisionNX"

Rem
bbdoc: <p> Returns the y component of the normal of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index  should be in the range 1...CountCollisions( entity ) inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionNY#(entity,index)="bbCollisionNY"

Rem
bbdoc: <p> Returns the z component of the normal of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index  should be in the range 1...CountCollisions( entity ) inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionNZ#(entity,index)="bbCollisionNZ"

Rem
bbdoc: <p> Returns the time at which the specified collision occured
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
A time of 0.0 means
the collision ocurred at the beginning of the update period, a time of 1.0 means
the collision ocurred at the end of the period. If the collision ocurred half way
between the entities old position and its new a time of 0.5 will be returned.
</p>
<p>
Index should be in the range 1...CountCollisions( entity ) inclusive representing
which collision from the most previous UpdateWorld.
</p>
<p>
See the <a href=#bbupdateworld>bbUpdateWorld</a> command for more information on working with Blitz3D
collisions.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionTime#(entity,index)="bbCollisionTime"

Rem
bbdoc: <p> Returns the other entity involved in a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index should  be in the range 1...CountCollisions( entity  ), inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionEntity(entity,index)="bbCollisionEntity"

Rem
bbdoc: <p> Returns the handle of the surface belonging to the specified entity that was closest to the point of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index should be in  the range 1...CountCollisions( entity ), inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionSurface(entity,index)="bbCollisionSurface"

Rem
bbdoc: <p> Returns the index number of the triangle belonging to the specified entity that was closest to the point of a particular collision.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of collision</td></tr>
</table>
</p>
<p>
Index should be in the range 1...CountCollisions( entity ), inclusive.
</p>
See Also: <a href=#bbcollisionx>bbCollisionX</a> <a href=#bbcollisiony>bbCollisionY</a> <a href=#bbcollisionz>bbCollisionZ</a> <a href=#bbcollisionnx>bbCollisionNX</a> <a href=#bbcollisionny>bbCollisionNY</a> <a href=#bbcollisionnz>bbCollisionNZ</a> <a href=#bbcountcollisions>bbCountCollisions</a> <a href=#bbentitycollided>bbEntityCollided</a> <a href=#bbcollisiontime>bbCollisionTime</a> <a href=#bbcollisionentity>bbCollisionEntity</a> <a href=#bbcollisionsurface>bbCollisionSurface</a> <a href=#bbcollisiontriangle>bbCollisionTriangle</a>
EndRem
Function CollisionTriangle(entity,index)="bbCollisionTriangle"

Rem
bbdoc: <p> Sets the pick mode for an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>pick_geometry</td><td class=argvalue>type of geometry used for picking</td></tr>
<tr><td class=argname>obscurer</td><td class=argvalue>False to make entity transparent</td></tr>
</table>
</p>
<p>
The obscurer option if True
entities during an EntityVisible call. Defaults to True.
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>PICK_NONE</td><td class=data>0</td><td class=data>Unpickable (default)</td></tr>
<tr><td class=data>PICK_SPHERE</td><td class=data>1</td><td class=data>Sphere (EntityRadius is used)</td></tr>
<tr><td class=data>PICK_POLY</td><td class=data>2</td><td class=data>Polygon</td></tr>
<tr><td class=data>PICK_BOX</td><td class=data>3</td><td class=data>Box (EntityBox is used)</td></tr>
</table>
<p>
The optional <b>obscurer</b> parameter is used with EntityVisible to determine
just what can get in the way of the line-of-sight between 2 entities.
</p>
<p>
This allows some entities to be pickable using the other pick commands,
but to be ignored (i.e. 'transparent') when using EntityVisible.
</p>
<p class="hint">
A valid mesh entity is required for Polygon type picking.
Use Sphere or Box type picking for all other entity classes
including sprites, terrains, pivots etc.
</p>
See Also: <a href=#bbentitypick>bbEntityPick</a> <a href=#bblinepick>bbLinePick</a> <a href=#bbcamerapick>bbCameraPick</a> <a href=#bbentitypickmode>bbEntityPickMode</a>
EndRem
Function EntityPickMode(entity,pick_geometry,obscurer=True)="bbEntityPickMode"

Rem
bbdoc: <p> Returns the first pickable entity along the line defined by the end coordinates (x,y,z) and (x+dx,y+dy,z+dz).
about:
<table class="arg">
<tr><td class=argname>x#</td><td class=argvalue>x coordinate of start of line pick</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y coordinate of start of line pick</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z coordinate of start of line pick</td></tr>
<tr><td class=argname>dx#</td><td class=argvalue>distance x of line pick</td></tr>
<tr><td class=argname>dy#</td><td class=argvalue>distance y of line pick</td></tr>
<tr><td class=argname>dz#</td><td class=argvalue>distance z of line pick</td></tr>
<tr><td class=argname>radius</td><td class=argvalue>radius of line pick</td></tr>
</table>
</p>
<p>
Use the <a href=#bbentitypickmode>bbEntityPickMode</a> command to make an entity
pickable.
</p>
See Also: <a href=#bbentitypick>bbEntityPick</a> <a href=#bblinepick>bbLinePick</a> <a href=#bbcamerapick>bbCameraPick</a> <a href=#bbentitypickmode>bbEntityPickMode</a>
EndRem
Function LinePick(x#,y#,z#,dx#,dy#,dz#,radius#=0)="bbLinePick"

Rem
bbdoc: <p> Returns the nearest pickable entity 'infront' of the specified entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>range#</td><td class=argvalue>range of pick area around entity</td></tr>
</table>
</p>
<p>
The scale of the <b>range</b> parameter is affected by the
scale of the entity and affects the maximum distance
of the pick.
</p>
<p>
Use the <a href=#bbentitypickmode>bbEntityPickMode</a> command to make an entity
pickable.
</p>
See Also: <a href=#bbentitypickmode>bbEntityPickMode</a> <a href=#bblinepick>bbLinePick</a> <a href=#bbcamerapick>bbCameraPick</a> <a href=#bbentitypickmode>bbEntityPickMode</a>
EndRem
Function EntityPick(entity,range#)="bbEntityPick"

Rem
bbdoc: <p> Returns the nearest pickable entity occupying the specified viewport coordinates or 0 if none.
about:
<table class="arg">
<tr><td class=argname>camera</td><td class=argvalue>camera handle</td></tr>
<tr><td class=argname>viewport_x#</td><td class=argvalue>2D viewport coordinate</td></tr>
<tr><td class=argname>viewport_y#</td><td class=argvalue>2D viewport coordinate</td></tr>
</table>
</p>
<p>
Use the <a href=#bbentitypickmode>bbEntityPickMode</a> command to make an entity
pickable.
</p>
<p>
The <a href=#bbcamerapick>bbCameraPick</a> function is a useful way for detecting
the entity being drawn at the specified screen location
in particular when that location is the point at
<a href=#bbmousex>bbMouseX</a>,<a href=#bbmousey>bbMouseY</a>.
</p>
See Also: <a href=#bbentitypick>bbEntityPick</a> <a href=#bblinepick>bbLinePick</a> <a href=#bbcamerapick>bbCameraPick</a> <a href=#bbentitypickmode>bbEntityPickMode</a> <a href=#bbentityinview>bbEntityInView</a>
EndRem
Function CameraPick(camera,viewport_x#,viewport_y#)="bbCameraPick"

Rem
bbdoc: <p> Returns the world X coordinate at which the most recently picked entity was picked.
about:
</p>
<p>
The coordinate ( <a href=#bbpickedx>bbPickedX</a>(), <a href=#bbpickedy>bbPickedY</a>(), <a href=#bbpickedz>bbPickedZ</a>() ) is
the exact point in world space at which the current
<a href=#bbpickedentity>bbPickedEntity</a>() was picked with either the <a href=#bbcamerapick>bbCameraPick</a>,
<a href=#bbentitypick>bbEntityPick</a> or <a href=#bblinepick>bbLinePick</a> functions.
</p>
See Also: <a href=#bbpickedy>bbPickedY</a> <a href=#bbpickedz>bbPickedZ</a>
EndRem
Function PickedX#()="bbPickedX"

Rem
bbdoc: <p> Returns the world Y coordinate at which the most recently picked entity was picked.
about:
</p>
<p>
The coordinate ( <a href=#bbpickedx>bbPickedX</a>(), <a href=#bbpickedy>bbPickedY</a>(), <a href=#bbpickedz>bbPickedZ</a>() ) is
the exact point in world space at which the current
<a href=#bbpickedentity>bbPickedEntity</a>() was picked with either the <a href=#bbcamerapick>bbCameraPick</a>,
<a href=#bbentitypick>bbEntityPick</a> or <a href=#bblinepick>bbLinePick</a> functions.
</p>
See Also: <a href=#bbpickedx>bbPickedX</a> <a href=#bbpickedz>bbPickedZ</a>
EndRem
Function PickedY#()="bbPickedY"

Rem
bbdoc: <p> Returns the world Z coordinate at which the most recently picked entity was picked.
about:
</p>
<p>
The coordinate ( <a href=#bbpickedx>bbPickedX</a>(), <a href=#bbpickedy>bbPickedY</a>(), <a href=#bbpickedz>bbPickedZ</a>() ) is
the exact point in world space at which the current
<a href=#bbpickedentity>bbPickedEntity</a>() was picked with either the <a href=#bbcamerapick>bbCameraPick</a>,
<a href=#bbentitypick>bbEntityPick</a> or <a href=#bblinepick>bbLinePick</a> functions.
</p>
See Also: <a href=#bbpickedx>bbPickedX</a> <a href=#bbpickedy>bbPickedY</a>
EndRem
Function PickedZ#()="bbPickedZ"

Rem
bbdoc: <p> Returns the X component of the surface normal at the point which the most recently picked entity was picked.
about:
</p>
See Also: <a href=#bbpickedny>bbPickedNY</a> <a href=#bbpickednz>bbPickedNZ</a>
EndRem
Function PickedNX()="bbPickedNX"

Rem
bbdoc: <p> Returns the Y component of the surface normal at the point which the most recently picked entity was picked.
about:
</p>
See Also: <a href=#bbpickednx>bbPickedNX</a> <a href=#bbpickednz>bbPickedNZ</a>
EndRem
Function PickedNY()="bbPickedNY"

Rem
bbdoc: <p> Returns the Z component of the surface normal at the point which the most recently picked entity was picked.
about:
</p>
See Also: <a href=#bbpickednx>bbPickedNX</a> <a href=#bbpickedny>bbPickedNY</a>
EndRem
Function PickedNZ()="bbPickedNZ"

Rem
bbdoc: <p> Returns a value between 0.0 and 1.0 representing the distance along the <a href=#bblinepick>bbLinePick</a> at which the most recently picked entity was picked.
about:
</p>
EndRem
Function PickedTime()="bbPickedTime"

Rem
bbdoc: <p> Returns the entity 'picked' by the most recently executed Pick command.
about:
</p>
<p>
Returns 0 if no entity was picked.
</p>
EndRem
Function PickedEntity()="bbPickedEntity"

Rem
bbdoc: <p> Returns the handle of the surface that was 'picked' by the most recently executed Pick command.
about:
</p>
EndRem
Function PickedSurface()="bbPickedSurface"

Rem
bbdoc: <p> Returns the index number of the triangle that was 'picked' by the most recently  executed Pick command.
about:
</p>
EndRem
Function PickedTriangle()="bbPickedTriangle"

Rem
bbdoc: <p> Returns a new mesh entity loaded from a .X, .3DS or .B3D file.
about:
<table class="arg">
<tr><td class=argname>filename$</td><td class=argvalue>name of the file containing the model to load</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> entity</td></tr>
</table>
</p>
<p>
Any hierarchy and animation information is ignored.
</p>
<p>
Use the <a href=#bbloadanimmesh>bbLoadAnimMesh</a> function to load both mesh, hierarchy
and animation information.
</p>
<p>
The optional <b>parent</b> parameter attaches the new mesh
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
<p>
The .b3d file format is the native file format of Blitz3D
and supports features such as multitexturing, weighted
bone skinning and hierachial animation.
</p>
<p>
See the <a href=#bbblitz3d file format>bbBlitz3D File Format</a> chapter for more information.
</p>
See Also: <a href=#bbloadanimmesh>bbLoadAnimMesh</a> <a href=#bbloadermatrix>bbLoaderMatrix</a> <a href=#bbblitz3d file format>bbBlitz3D File Format</a>
EndRem
Function LoadMesh(filename$z,parent=0)="bbLoadMesh"

Rem
bbdoc: <p> Returns the root of an entity hierachy loaded from the specified file.
about:
<table class="arg">
<tr><td class=argname>filename$</td><td class=argvalue>name of the file containing the model to load.</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>optional entity to act as parent to the loaded mesh.</td></tr>
</table>
</p>
<p>
Unlike <a href=#bbloadmesh>bbLoadMesh</a>, <a href=#bbloadanimmesh>bbLoadAnimMesh</a> may result in the creation of many
mesh and pivot entities depending on what it finds in the specified
file.
</p>
<p>
The optional <b>parent</b> parameter attaches the new entity hierachy
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for more
details on the effects of entity parenting.
</p>
<p>
See the <a href=#bbanimate>bbAnimate</a> command for activating any animation that may
be included in the file.
</p>
<p>
Locate child entities within an entity hierarchy by using the
<a href=#bbfindchild>bbFindChild</a>() and <a href=#bbgetchild>bbGetChild</a> functions.
</p>
<p>
See the <a href=#bbblitz3d file format>bbBlitz3D File Format</a> for more information on Blitz3D's
native file format and its support for multitexturing, weighted
bone skinning and hierachial animation.
</p>
See Also: <a href=#bbloadmesh>bbLoadMesh</a> <a href=#bbloadermatrix>bbLoaderMatrix</a> <a href=#bbanimate>bbAnimate</a> <a href=#bbfindchild>bbFindChild</a> <a href=#bbgetchild>bbGetChild</a> <a href=#bbblitz3d file format>bbBlitz3D File Format</a>
EndRem
Function LoadAnimMesh(filename$z,parent=0)="bbLoadAnimMesh"

Rem
bbdoc: <p> Sets a transformation matrix to be applied to specified file types when loaded.
about:
<table class="arg">
<tr><td class=argname>file_extension$</td><td class=argvalue>file extension of 3d file</td></tr>
<tr><td class=argname>xx#</td><td class=argvalue>1,1 element of 3x3 matrix</td></tr>
<tr><td class=argname>xy#</td><td class=argvalue>2,1 element of 3x3 matrix</td></tr>
<tr><td class=argname>xz#</td><td class=argvalue>3,1 element of 3x3 matrix</td></tr>
<tr><td class=argname>yx#</td><td class=argvalue>1,2 element of 3x3 matrix</td></tr>
<tr><td class=argname>yy#</td><td class=argvalue>2,2 element of 3x3 matrix</td></tr>
<tr><td class=argname>yz#</td><td class=argvalue>3,2 element of 3x3 matrix</td></tr>
<tr><td class=argname>zx#</td><td class=argvalue>1,3 element of 3x3 matrix</td></tr>
<tr><td class=argname>zy#</td><td class=argvalue>2,3 element of 3x3 matrix</td></tr>
<tr><td class=argname>zz#</td><td class=argvalue>3,3 element of 3x3 matrix</td></tr>
</table>
</p>
<p>
When geometric models loaded from file with the <a href=#bbloadmesh>bbLoadMesh</a>
and <a href=#bbloadanimmesh>bbLoadAnimMesh</a> functions have been created in a different
coordinate system a <a href=#bbloadermatrix>bbLoaderMatrix</a> transformation can be
used to correct the geometry at the time of loading.
</p>
<p>
By default, the following loader matrices are used:
</p>
<p>
LoaderMatrix &quot;x&quot;,1,0,0,0,1,0,0,0,1 ; no change in coord system
</p>
<p>
LoaderMatrix &quot;3ds&quot;,1,0,0,0,0,1,0,1,0 ; swap y/z axis'
</p>
<p>
You can use LoaderMatrix to flip meshes/animations if necessary,
eg:
</p>
<p>
LoaderMatrix &quot;x&quot;,-1,0,0,0,1,0,0,0,1  ; flip x-cords for &quot;.x&quot; files
</p>
<p>
LoaderMatrix &quot;3ds&quot;,-1,0,0,0,0,-1,0,1,0  ; swap y/z, negate x/z for &quot;.3ds&quot; files
</p>
See Also: <a href=#bbloadmesh>bbLoadMesh</a> <a href=#bbloadanimmesh>bbLoadAnimMesh</a>
EndRem
Function LoaderMatrix(file_extension$z,xx#,xy#,xz#,yx#,yy#,yz#,zx#,zy#,zz#)="bbLoaderMatrix"

Rem
bbdoc: <p> Creates a copy of a mesh entity and returns the newly-created mesh's handle.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>handle of mesh to be copied</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>handle of entity to be made parent of mesh</td></tr>
</table>
</p>
<p>
The optional <b>parent</b> parameter attaches the new copy
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for more
details on the effects of entity parenting.
</p>
<p>
The difference between <a href=#bbcopymesh>bbCopyMesh</a> and <a href=#bbcopyentity>bbCopyEntity</a> is that
<a href=#bbcopymesh>bbCopyMesh</a> makes a copy of all the surfaces whereas
the result of a <a href=#bbcopyentity>bbCopyEntity</a> shares any surfaces with its
template.
</p>
<p>
A mesh copy can also be created using a combination of the
<a href=#bbcreatemesh>bbCreateMesh</a> and <a href=#bbaddmesh>bbAddMesh</a> commands.
</p>
See Also: <a href=#bbcopyentity>bbCopyEntity</a> <a href=#bbcreatemesh>bbCreateMesh</a> <a href=#bbaddmesh>bbAddMesh</a>
EndRem
Function CopyMesh(mesh,parent=0)="bbCopyMesh"

Rem
bbdoc: <p> Creates a 'blank' mesh entity and returns its handle.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> entity for new mesh</td></tr>
</table>
</p>
<p>
When a mesh is first created it has no surfaces, vertices or
triangles associated with it.
</p>
<p>
To add geometry to a mesh, use the <a href=#bbaddmesh>bbAddMesh</a> command to copy
surfaces from other meshes or new surfaces can be added with the
<a href=#bbcreatesurface>bbCreateSurface</a>() function with vertices and triangles being
added to that surface using the <a href=#bbaddvertex>bbAddVertex</a> and <a href=#bbaddtriangle>bbAddTriangle</a>
commands.
</p>
<p>
The optional <b>parent</b> parameter attaches the new mesh
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbaddmesh>bbAddMesh</a> <a href=#bbcreatesurface>bbCreateSurface</a> <a href=#bbaddvertex>bbAddVertex</a> <a href=#bbaddtriangle>bbAddTriangle</a>
EndRem
Function CreateMesh(parent=0)="bbCreateMesh"

Rem
bbdoc: <p> Adds copies of all source_mesh's surfaces to the dest_mesh entities surface list.
about:
<table class="arg">
<tr><td class=argname>source_mesh</td><td class=argvalue>source mesh handle</td></tr>
<tr><td class=argname>dest_mesh</td><td class=argvalue>destination mesh handle</td></tr>
</table>
</p>
See Also: <a href=#bbcreatemesh>bbCreateMesh</a>
EndRem
Function AddMesh(source_mesh,dest_mesh)="bbAddMesh"

Rem
bbdoc: <p> Flips all the triangles in a mesh.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
</table>
</p>
<p>
<a href=#bbflipmesh>bbFlipMesh</a> reverses the order of vertices for each triangle effectively
making it face the opposite direction.
</p>
<p>
Triangles that all face the wrong way is a common error when loading
external meshes and the <a href=#bbflipmesh>bbFlipMesh</a> command is a useful correction
if an alternative <a href=#bbloadermatrix>bbLoaderMatrix</a> solution can not be found.
</p>
<p>
<a href=#bbflipmesh>bbFlipMesh</a> is also useful for turning primitives created by <a href=#bbcreatesphere>bbCreateSphere</a>,
<a href=#bbcreatecylinder>bbCreateCylinder</a> and <a href=#bbcreatecone>bbCreateCone</a> inside out.
</p>
<p>
See the <a href=#bbentityfx>bbEntityFX</a> command for treating the triangles of a mesh as double
sided instead.
</p>
See Also: <a href=#bbloadermatrix>bbLoaderMatrix</a> <a href=#bbentityfx>bbEntityFX</a> <a href=#bbbrushfx>bbBrushFX</a>
EndRem
Function FlipMesh(mesh)="bbFlipMesh"

Rem
bbdoc: <p> Paints a mesh with a brush.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
</table>
</p>
<p>
Color, texture, shininess, fx and blend mode properties are copied from
the brush to each of the entity's surfaces.
</p>
<p>
Use the <a href=#bbpaintsurface>bbPaintSurface</a> command to paint individual surfaces.
</p>
<p>
See the <a href=#bbcreatebrush>bbCreateBrush</a>() function for more information about setting up a
brush with which to paint entities and individual surfaces.
</p>
See Also: <a href=#bbcreatebrush>bbCreateBrush</a> <a href=#bbpaintentity>bbPaintEntity</a> <a href=#bbpaintsurface>bbPaintSurface</a>
EndRem
Function PaintMesh(mesh,brush)="bbPaintMesh"

Rem
bbdoc: <p> Adds the effect of a specified point light to the color of all vertices.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>red#</td><td class=argvalue>mesh red value</td></tr>
<tr><td class=argname>green#</td><td class=argvalue>mesh green value</td></tr>
<tr><td class=argname>blue#</td><td class=argvalue>mesh blue value</td></tr>
<tr><td class=argname>range#</td><td class=argvalue>optional light range</td></tr>
<tr><td class=argname>light_x#</td><td class=argvalue>optional light x position</td></tr>
<tr><td class=argname>light_y#</td><td class=argvalue>optional light y position</td></tr>
<tr><td class=argname>light_z#</td><td class=argvalue>optional light z position</td></tr>
</table>
</p>
<p>
If the range parameter is omitted it is assumed to be 0 and all vertices
are lit equally. If the optional position parameters are omitted the
light is assumed to be at the local origin (coordinate 0,0,0).
</p>
<p>
See the <a href=#bbentityfx>bbEntityFX</a> command for selecting EnableVertexColors which must
be active for the results of LightMesh to be visible.
</p>
<p>
Because <a href=#bblightmesh>bbLightMesh</a> is an additive operation and vertex colors default
to white, negative white can be applied initially to reset all vertex
colors to black:
</p>
<pre>
</pre>
See Also: <a href=#bbentityfx>bbEntityFX</a> <a href=#bbbrushfx>bbBrushFX</a>
EndRem
Function LightMesh(mesh,red#,green#,blue#,range#=0,light_x#=0,light_y#=0,light_z#=0)="bbLightMesh"

Rem
bbdoc: <p> Scales and translates all vertices of a mesh so that the mesh occupies the specified box.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x position of mesh</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y position ofmesh</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z position of mesh</td></tr>
<tr><td class=argname>width#</td><td class=argvalue>width of mesh</td></tr>
<tr><td class=argname>height#</td><td class=argvalue>height of mesh</td></tr>
<tr><td class=argname>depth#</td><td class=argvalue>depth of mesh</td></tr>
<tr><td class=argname>uniform</td><td class=argvalue>optional, True to scale all axis the same amount</td></tr>
</table>
</p>
<p>
The <b>uniform</b> parameter defaults to false.
</p>
<p>
A <b>uniform</b> fit will scale the size of the mesh evenly in
each axis until the mesh fits in the dimensions specified
retaining the mesh's original aspect ratio.
</p>
<p class="hint">
A width, height or depth of 0 should never be used
if the geometry of the mesh is to remain intact, use
a value near 0 instead to &quot;flatten&quot; a mesh.
</p>
See Also: <a href=#bbscalemesh>bbScaleMesh</a> <a href=#bbscaleentity>bbScaleEntity</a>
EndRem
Function FitMesh(mesh,x#,y#,z#,width#,height#,depth#,uniform=0)="bbFitMesh"

Rem
bbdoc: <p> Scales all vertices of a mesh by the specified scaling factors.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>x_scale#</td><td class=argvalue>x scale of mesh</td></tr>
<tr><td class=argname>y_scale#</td><td class=argvalue>y scale of mesh</td></tr>
<tr><td class=argname>z_scale#</td><td class=argvalue>z scale of mesh</td></tr>
</table>
</p>
See Also: <a href=#bbfitmesh>bbFitMesh</a> <a href=#bbscaleentity>bbScaleEntity</a>
EndRem
Function ScaleMesh(mesh,x_scale#,y_scale#,z_scale#)="bbScaleMesh"

Rem
bbdoc: <p> Rotates all vertices of a mesh by the specified rotation.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>pitch#</td><td class=argvalue>pitch of mesh</td></tr>
<tr><td class=argname>yaw#</td><td class=argvalue>yaw of mesh</td></tr>
<tr><td class=argname>roll#</td><td class=argvalue>roll of mesh</td></tr>
</table>
</p>
<p>
Rotation is in degrees where 360` is a complete rotation
and the axis of each rotation is as follows:
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Rotation Axis</th><th class=data>Description</th></tr>
<tr><td class=data>Pitch</td><td class=data>around x axis</td><td class=data>equivalent to tilting forward/backwards.</td></tr>
<tr><td class=data>Yaw</td><td class=data>around y axis</td><td class=data> equivalent to turning left/right.</td></tr>
<tr><td class=data>Roll</td><td class=data>around z axis</td><td class=data> equivalent to tilting left/right.</td></tr>
</table>
See Also: <a href=#bbrotateentity>bbRotateEntity</a> <a href=#bbturnentity>bbTurnEntity</a>
EndRem
Function RotateMesh(mesh,pitch#,yaw#,roll#)="bbRotateMesh"

Rem
bbdoc: <p> Translates the position of all mesh vertices using the specified direction vector.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x direction</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y direction</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z direction</td></tr>
</table>
</p>
See Also: <a href=#bbpositionentity>bbPositionEntity</a> <a href=#bbmoveentity>bbMoveEntity</a> <a href=#bbtranslateentity>bbTranslateEntity</a>
EndRem
Function PositionMesh(mesh,x#,y#,z#)="bbPositionMesh"

Rem
bbdoc: <p> Recalculates all normals in a mesh.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
</table>
</p>
<p>
This is necessary for correct lighting if you are building
or modifying meshes and have not set surface normals
manually using the <a href=#bbvertexnormal>bbVertexNormal</a> commands
or a mesh has been loaded from a model file with
bad or missing vertex normal data.
</p>
See Also: <a href=#bbvertexnormal>bbVertexNormal</a>
EndRem
Function UpdateNormals(mesh)="bbUpdateNormals"

Rem
bbdoc: <p> Returns true if the specified meshes are currently intersecting.
about:
<table class="arg">
<tr><td class=argname>mesh_a</td><td class=argvalue>mesh_a handle</td></tr>
<tr><td class=argname>mesh_b</td><td class=argvalue>mesh_b handle</td></tr>
</table>
</p>
<p>
This  is a fairly slow routine - use with discretion...
</p>
<p>
This command is  currently the only  polygon-&gt;polygon collision checking
routine available in Blitz3D.
</p>
EndRem
Function MeshesIntersect(mesh_a,mesh_b)="bbMeshesIntersect"

Rem
bbdoc: <p> Returns the width of a mesh
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
</table>
This is calculated by the actual vertex
positions and so the scale of the entity (set by ScaleEntity) will not have
an effect on the resultant width. Mesh operations, on the other hand, will
effect the result.
</p>
See Also: <a href=#bbmeshheight>bbMeshHeight</a> <a href=#bbmeshdepth>bbMeshDepth</a>
EndRem
Function MeshWidth#(mesh)="bbMeshWidth"

Rem
bbdoc: <p> Returns the height of a mesh.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
</table>
This is calculated by the actual vertex positions and so the scale of the
entity (set by ScaleEntity) will not have an effect on the resultant height.
Mesh operations, on the other hand, will effect the result.
</p>
See Also: <a href=#bbmeshwidth>bbMeshWidth</a> <a href=#bbmeshdepth>bbMeshDepth</a>
EndRem
Function MeshHeight#(mesh)="bbMeshHeight"

Rem
bbdoc: <p> Returns the depth of a mesh
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
</table>
This is calculated by the actual vertex positions
and so the scale of the entity (set by ScaleEntity) will not have an effect
on the resultant depth. Mesh operations, on the other hand, will effect
the result.
</p>
See Also: <a href=#bbmeshwidth>bbMeshWidth</a> <a href=#bbmeshheight>bbMeshHeight</a>
EndRem
Function MeshDepth#(mesh)="bbMeshDepth"

Rem
bbdoc: <p> This command allows the adjustment of the culling box used by the Blitz3D renderer when deciding if the mesh is outside the view of a camera.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>x</td><td class=argvalue>x position of far bottom left corner of bounding box</td></tr>
<tr><td class=argname>y</td><td class=argvalue>y position of far bottom left corner of bounding box</td></tr>
<tr><td class=argname>z</td><td class=argvalue>z position of far bottom left corner of bounding box</td></tr>
<tr><td class=argname>w</td><td class=argvalue>width of bounding box</td></tr>
<tr><td class=argname>h</td><td class=argvalue>height of bounding box</td></tr>
<tr><td class=argname>d</td><td class=argvalue>depth of bounding box</td></tr>
</table>
</p>
<p>
The culling box of a mesh is automatically calculated,
however in some instances an animated mesh may
stretch beyond this region resulting in it visually
popping out of view incorrectly. The <a href=#bbmeshcullbox>bbMeshCullBox</a>
command allows a meshed culling box to be manually
adjusted to correct this problem.
</p>
See Also: <a href=#bbloadanimmesh>bbLoadAnimMesh</a>
EndRem
Function MeshCullBox(mesh,x#,y#,z#,w#,h#,d#)="bbMeshCullBox"

Rem
bbdoc: <p> Returns the number of surfaces in a mesh.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
</table>
</p>
<p>
Surfaces are sections of a mesh with their own rendering
properties.
</p>
<p>
A mesh may contain none, one or many such surfaces. The
vertices and triangles of a mesh actually belong to a particular
surface of that mesh in Blitz3d.
</p>
See Also: <a href=#bbgetsurface>bbGetSurface</a> <a href=#bbpaintsurface>bbPaintSurface</a>
EndRem
Function CountSurfaces(mesh)="bbCountSurfaces"

Rem
bbdoc: <p> Returns the handle of the surface attached to the specified mesh and with  the specified index number.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of surface</td></tr>
</table>
</p>
<p>
Index should be in the range 1...CountSurfaces( mesh ), inclusive.
</p>
<p>
You need to 'get a surface', i.e. get its handle, in order to be able to
then use that particular surface with other commands.
</p>
<p class="hint">
Often mesh surfaces in loaded models are not equivalent to how they
were built in a modelling program due to optimzations and possible extra
edge vertices added by the Blitz3D loader. See the <a href=#bbfindsurface>bbFindSurface</a>
command for an alternative method of locating a particular surface
based on the brush properties used to create it.
</p>
See Also: <a href=#bbcountsurfaces>bbCountSurfaces</a> <a href=#bbfindsurface>bbFindSurface</a>
EndRem
Function GetSurface(mesh,index)="bbGetSurface"

Rem
bbdoc: <p> Creates a surface attached to a mesh and returns the surface's handle.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>brush</td><td class=argvalue>optional brush handle</td></tr>
</table>
</p>
<p>
Surfaces are sections of mesh which are then used
to attach triangles to. You  must have at least one surface per mesh in
order to create a visible mesh.
</p>
<p>
Multiple surfaces can be used per mesh when color and texture properties
vary in different sections of the same mesh.
</p>
<p>
Splitting a mesh up into lots of sections allows  you to affect those sections
individually, which can be a lot more useful than if all the surfaces are
combined into just a single surface. Single surface meshes however often
have the advantage of being faster to render.
</p>
See Also: <a href=#bbpaintsurface>bbPaintSurface</a>
EndRem
Function CreateSurface(mesh,brush=0)="bbCreateSurface"

Rem
bbdoc: <p> Paints a surface with a brush.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
</table>
</p>
<p>
This has the effect of instantly altering  the visible appearance of that
particular surface, i.e. section of mesh, assuming  the brush's properties
are different to what was applied to the surface before.
</p>
<p>
See the <a href=#bbpaintentity>bbPaintEntity</a> command for more information about how
entity properties are combined with surface properties in the
Blitz3D rendering pipeline.
</p>
See Also: <a href=#bbpaintentity>bbPaintEntity</a> <a href=#bbpaintmesh>bbPaintMesh</a>
EndRem
Function PaintSurface(surface,brush)="bbPaintSurface"

Rem
bbdoc: <p> Removes all vertices and / or triangles from a surface.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>clear_verts</td><td class=argvalue>True
<tr><td class=argname>clear_triangles</td><td class=argvalue>True
</table>
</p>
<p>
The two optional parameters <b>clear_verts</b> and <b>clear_triangles</b> default
to True
</p>
See Also: <a href=#bbaddvertex>bbAddVertex</a> <a href=#bbaddtriangle>bbAddTriangle</a>
EndRem
Function ClearSurface(surface,clear_verts,clear_triangles=0)="bbClearSurface"

Rem
bbdoc: <p> Attempts to find a surface attached to the specified mesh and created with properties similar to those in the specified brush.
about:
<table class="arg">
<tr><td class=argname>mesh</td><td class=argvalue>mesh handle</td></tr>
<tr><td class=argname>brush</td><td class=argvalue>brush handle</td></tr>
</table>
</p>
<p>
Returns the surface handle if found or 0 if not.
</p>
See Also: <a href=#bbcountsurfaces>bbCountSurfaces</a> <a href=#bbgetsurface>bbGetSurface</a>
EndRem
Function FindSurface(mesh,brush)="bbFindSurface"

Rem
bbdoc: <p> Returns the index of a new vertex added to the specified surface.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x coordinate of vertex</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y coordinate of vertex</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z coordinate of vertex</td></tr>
<tr><td class=argname>u#</td><td class=argvalue>u texture coordinate of vertex</td></tr>
<tr><td class=argname>v#</td><td class=argvalue>v texture coordinate of vertex</td></tr>
<tr><td class=argname>w#</td><td class=argvalue>w texture coordinate of vertex</td></tr>
</table>
</p>
<p>
The <b>x</b>, <b>y</b> and <b>z</b> parameters are the geometric coordinates of the new
vertex, and <b>u</b>, <b>v</b>, and <b>w</b> are texture mapping coordinates.
</p>
<p>
By creating three vertices on a specific surface, their three index values can
then be used with <a href=#bbaddtriangle>bbAddTriangle</a> to create a simple triangle mesh.
</p>
<p>
The same vertices can be used as the corner of multiple triangles which is
useful when creating surfaces with smooth edges.
</p>
<p>
Multiple vertices in the same position are often required when the
two sides of a sharp edge have different surface normals or there is
a seem in the texture coordinates. Such situations require unique
vertices per face such as the cube created with <a href=#bbcreatecube>bbCreateCube</a> which
has 24 vertices not 8 in its single surface.
</p>
<p>
See the <a href=#bbvertextexcoords>bbVertexTexCoords</a> command for more details on the optional u,v,w
texture coordinates. The <b>u</b>, <b>v</b> and <b>w</b> parameters, if specified, effect
both texture coordinate sets (0 and 1).
</p>
<p>
When adding a vertex its default color is 255,255,255,255.
</p>
See Also: <a href=#bbaddtriangle>bbAddTriangle</a> <a href=#bbvertexcoords>bbVertexCoords</a> <a href=#bbvertexcolor>bbVertexColor</a> <a href=#bbvertexnormal>bbVertexNormal</a> <a href=#bbvertextexcoords>bbVertexTexCoords</a>
EndRem
Function AddVertex(surface,x#,y#,z#,u#=0,v#=0,w#=1)="bbAddVertex"

Rem
bbdoc: <p> Returns the index of a new triangle added to the specified surface.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>v0</td><td class=argvalue>index number of first vertex of triangle</td></tr>
<tr><td class=argname>v1</td><td class=argvalue>index number of second vertex of triangle</td></tr>
<tr><td class=argname>v2</td><td class=argvalue>index number of third vertex of triangle</td></tr>
</table>
</p>
<p>
The three vertex indexes define the points in clockwise order of
a single sided triangle that is added to the surface specified.
</p>
<p>
The <b>v0</b>, <b>v1</b> and <b>v2</b> parameters are the index numbers of vertices added
to the same surface using the AddVertex function.
</p>
<p class="hint">
A special DoubleSided effect can be enabled for a surface that
will treat each triangle in a surface as having two sides, see
<a href=#bbentityfx>bbEntityFX</a> and <a href=#bbbrushfx>bbBrushFX</a> for more information.
</p>
See Also: <a href=#bbaddvertex>bbAddVertex</a> <a href=#bbentityfx>bbEntityFX</a>
EndRem
Function AddTriangle(surface,v0,v1,v2)="bbAddTriangle"

Rem
bbdoc: <p> Sets the geometric coordinates of an existing vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>x position of vertex</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>y position of vertex</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>z position of vertex</td></tr>
</table>
</p>
<p>
The index value should be in the range 0..CountVertices()-1.
</p>
<p>
By changing the position of individual verticies in a mesh, dynamic
'mesh deforming' effects and high performance 'particle systems'
can be programmed in Blitz3D.
</p>
<p>
See the <a href=#bbvertexnormal>bbVertexNormal</a> or <a href=#bbupdatenormals>bbUpdateNormals</a> commands for correcting
lighting errors that may be introduced when deforming a mesh.
</p>
See Also: <a href=#bbvertexnormal>bbVertexNormal</a> <a href=#bbvertexcolor>bbVertexColor</a>
EndRem
Function VertexCoords(surface,index,x#,y#,z#)="bbVertexCoords"

Rem
bbdoc: <p> Sets the normal of an existing vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
<tr><td class=argname>nx#</td><td class=argvalue>normal x of vertex</td></tr>
<tr><td class=argname>ny#</td><td class=argvalue>normal y of vertex</td></tr>
<tr><td class=argname>nz#</td><td class=argvalue>normal z of vertex</td></tr>
</table>
</p>
<p>
The index value should be in the range 0..CountVertices()-1.
</p>
<p>
Depending on the suface properties and the type of active
lights in the world vertex normals can play a big part in
rendering correctly shaded surfaces.
</p>
<p>
A vertex normal should point directly away from any
triangle faces the vertex has been used to construct.
</p>
<p>
See the <a href=#bbupdatenormals>bbUpdateNormals</a> command to automatically
calculate the surface normals of all vertices in a mesh.
</p>
See Also: <a href=#bbupdatenormals>bbUpdateNormals</a> <a href=#bbaddvertex>bbAddVertex</a> <a href=#bbaddtriangle>bbAddTriangle</a> <a href=#bbentityfx>bbEntityFX</a> <a href=#bbentityshininess>bbEntityShininess</a>
EndRem
Function VertexNormal(surface,index,nx#,ny#,nz#)="bbVertexNormal"

Rem
bbdoc: <p> Sets the color of an existing vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
<tr><td class=argname>red#</td><td class=argvalue>red value of vertex</td></tr>
<tr><td class=argname>green#</td><td class=argvalue>green value of vertex</td></tr>
<tr><td class=argname>blue#</td><td class=argvalue>blue value of vertex</td></tr>
<tr><td class=argname>alpha#</td><td class=argvalue>optional alpha transparency of vertex (0.0 to 1.0 - default: 1.0)</td></tr>
</table>
</p>
<p>
Red, green and blue paramaters should all be in the range 0..255.
See the <a href=#bbcolor>bbColor</a> command for more information on combining
red, green and blue values to define specific colors.
</p>
<p>
The index value should be in the range 0..CountVertices()-1.
</p>
<p class="hint">
If you want to set the alpha individually for vertices using the
<b>alpha</b> parameter then you need to use EntityFX flags: 32 (to force
alpha-blending) and 2 (to switch to vertex colors).
</p>
See Also: <a href=#bbentityfx>bbEntityFX</a> <a href=#bbvertexalpha>bbVertexAlpha</a> <a href=#bbvertexred>bbVertexRed</a> <a href=#bbvertexgreen>bbVertexGreen</a> <a href=#bbvertexblue>bbVertexBlue</a>
EndRem
Function VertexColor(surface,index,red#,green#,blue#,alpha#=1)="bbVertexColor"

Rem
bbdoc: <p> Sets the texture coordinates of an existing vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
<tr><td class=argname>u#</td><td class=argvalue>u# coordinate of vertex</td></tr>
<tr><td class=argname>v#</td><td class=argvalue>v# coordinate of vertex</td></tr>
<tr><td class=argname>w#</td><td class=argvalue>w# coordinate of vertex</td></tr>
<tr><td class=argname>coord_set</td><td class=argvalue>co_oord set. Should be set to 0 or 1.</td></tr>
</table>
</p>
<p>
The index value should be in the range 0..CountVertices()-1.
</p>
<p>
Texture coordinates determine how any active texturing for a
surface will be positioned on triangles by changing the
texture location used at each vertex corner.
</p>
<p>
This works on the following basis:
</p>
<p>
The top left of an image has the uv coordinates 0,0.
</p>
<p>
The top right has coordinates 1,0.
</p>
<p>
The bottom right is 1,1.
</p>
<p>
The bottom left 0,1.
</p>
<p>
Thus, uv coordinates for a vertex correspond to a point in the
image. For example, coordinates 0.9,0.1 would be near the upper
right corner of the image. The w parameter is currently ignored.
</p>
<p>
The coord_set specifies which of two vertex texture coordinates
are to be modified. Secondary texture coordinates are sometimes
useful when multitexturing with the <a href=#bbtexturecoords>bbTextureCoords</a> controlling
which texture coordinate set is used by each texture applied to
the vertices' surface.
</p>
See Also: <a href=#bbaddvertex>bbAddVertex</a> <a href=#bbtexturecoords>bbTextureCoords</a> <a href=#bbvertexu>bbVertexU</a> <a href=#bbvertexv>bbVertexV</a> <a href=#bbvertexw>bbVertexW</a>
EndRem
Function VertexTexCoords(surface,index,u#,v#,w#=1,coord_set=0)="bbVertexTexCoords"

Rem
bbdoc: <p> Returns the number of vertices in a surface.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
</table>
</p>
<p>
Use the result of <a href=#bbcountvertices>bbCountVertices</a> command to make sure your
program only modifies vertices that exist. Vertex modifier
commands such as <a href=#bbvertexcoords>bbVertexCoords</a>, <a href=#bbvertexcolor>bbVertexColor</a>, <a href=#bbvertexnormal>bbVertexNormal</a>
and <a href=#bbvertextexcoords>bbVertexTexCoords</a> all use a vertex index parameter that should
be in the range of 0..CountVertices()-1.
</p>
See Also: <a href=#bbgetsurface>bbGetSurface</a> <a href=#bbfindsurface>bbFindSurface</a> <a href=#bbaddvertex>bbAddVertex</a> <a href=#bbvertexcoords>bbVertexCoords</a> <a href=#bbvertexcolor>bbVertexColor</a> <a href=#bbvertexnormal>bbVertexNormal</a> <a href=#bbvertextexcoords>bbVertexTexCoords</a>
EndRem
Function CountVertices(surface)="bbCountVertices"

Rem
bbdoc: <p> Returns the number of triangles in a surface.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
</table>
</p>
See Also: <a href=#bbaddtriangle>bbAddTriangle</a> <a href=#bbgetsurface>bbGetSurface</a> <a href=#bbfindsurface>bbFindSurface</a>
EndRem
Function CountTriangles(surface)="bbCountTriangles"

Rem
bbdoc: <p> Returns the x coordinate of a vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexX#(surface,index)="bbVertexX"

Rem
bbdoc: <p> Returns the y coordinate of a vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexY#(surface,index)="bbVertexY"

Rem
bbdoc: <p> Returns the z coordinate of a vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexZ#(surface,index)="bbVertexZ"

Rem
bbdoc: <p> Returns the x component of a vertices normal.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexNX#(surface,index)="bbVertexNX"

Rem
bbdoc: <p> Returns the y component of a vertices normal.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexNY#(surface,index)="bbVertexNY"

Rem
bbdoc: <p> Returns the z component of a vertices normal.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexNZ#(surface,index)="bbVertexNZ"

Rem
bbdoc: <p> Returns the red component of a vertices color.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexRed#(surface,index)="bbVertexRed"

Rem
bbdoc: <p> Returns the green component of a vertices color.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexGreen#(surface,index)="bbVertexGreen"

Rem
bbdoc: <p> Returns the blue component of a vertices color.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
EndRem
Function VertexBlue#(surface,index)="bbVertexBlue"

Rem
bbdoc: <p> Returns the alpha component of a vertices color, set using <a href=#bbvertexcolor>bbVertexColor</a>.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
See Also: <a href=#bbvertexred>bbVertexRed</a> <a href=#bbvertexgreen>bbVertexGreen</a> <a href=#bbvertexblue>bbVertexBlue</a> <a href=#bbvertexcolor>bbVertexColor</a>
EndRem
Function VertexAlpha#(surface,index)="bbVertexAlpha"

Rem
bbdoc: <p> Returns the texture u coordinate of a vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
<tr><td class=argname>coord_set</td><td class=argvalue>optional UV mapping coordinate set</td></tr>
</table>
</p>
<p>
The coord_set defaults to 0 but may optionally be 1
to specify the value returned refer to the vertex's
secondary texture coordinate set.
</p>
See Also: <a href=#bbvertexv>bbVertexV</a> <a href=#bbvertextexcoords>bbVertexTexCoords</a>
EndRem
Function VertexU#(surface,index,coord_set=0)="bbVertexU"

Rem
bbdoc: <p> Returns the texture v coordinate of a vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
<tr><td class=argname>coord_set</td><td class=argvalue>optional UV mapping coordinate set. Should be set to 0 or 1.</td></tr>
</table>
</p>
<p>
The coord_set defaults to 0 but may optionally be 1
to specify the value returned refer to the vertex's
secondary texture coordinate set.
</p>
See Also: <a href=#bbvertexu>bbVertexU</a> <a href=#bbvertextexcoords>bbVertexTexCoords</a>
EndRem
Function VertexV#(surface,index,coord_set=0)="bbVertexV"

Rem
bbdoc: <p> Returns the texture w coordinate of a vertex.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>index</td><td class=argvalue>index of vertex</td></tr>
</table>
</p>
<p>
The coord_set defaults to 0 but may optionally be 1
to specify the value returned refer to the vertex's
secondary texture coordinate set.
</p>
EndRem
Function VertexW#(surface,index)="bbVertexW"

Rem
bbdoc: <p> Returns the vertex index of a triangle corner.
about:
<table class="arg">
<tr><td class=argname>surface</td><td class=argvalue>surface handle</td></tr>
<tr><td class=argname>triangle_index</td><td class=argvalue>triangle index</td></tr>
<tr><td class=argname>corner</td><td class=argvalue>corner of triangle. Should be 0, 1 or 2.</td></tr>
</table>
</p>
EndRem
Function TriangleVertex(surface,triangle_index,corner)="bbTriangleVertex"

Rem
bbdoc: <p> Returns a string containing the class of the specified entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>a valid entity handle</td></tr>
</table>
</p>
<p>
Possible return values are &quot;Pivot&quot;, &quot;Light&quot;,&quot;Camera&quot;, &quot;Mirror&quot;, &quot;Listener&quot;,
&quot;Sprite&quot;, &quot;Terrain&quot;, &quot;Plane&quot;, &quot;Mesh&quot;, &quot;MD2&quot; and &quot;BSP&quot;.
</p>
<p>
Note that <a href=#bbentityclass>bbEntityClass</a> function will fail if a valid entity handle is not
supplied and will not just return an empty string.
</p>
EndRem
Function bbEntityClass$z(entity)="bbEntityClass"

Rem
bbdoc: <p> Returns the name of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
An entity's name may be set when it was loaded from a model file
or from the use of the <a href=#bbnameentity>bbNameEntity</a> command.
</p>
See Also: <a href=#bbnameentity>bbNameEntity</a> <a href=#bbloadmesh>bbLoadMesh</a> <a href=#bbloadanimmesh>bbLoadAnimMesh</a>
EndRem
Function bbEntityName$z(entity)="bbEntityName"

Rem
bbdoc: <p> Sets an entity's name.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>name$</td><td class=argvalue>name of entity</td></tr>
</table>
</p>
See Also: <a href=#bbentityname>bbEntityName</a>
EndRem
Function NameEntity(entity,name$z)="bbNameEntity"

Rem
bbdoc: <p> Returns an integer identifier.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
An entity's id is zero unless one has been specified earlier using the
<a href=#bbsetentityid>bbSetEntityID</a> command.
</p>
See Also: <a href=#bbsetentityid>bbSetEntityID</a>
EndRem
Function EntityID(entity)="bbEntityID"

Rem
bbdoc: <p> Sets an entity's identifier field which can later be retrieved using the <a href=#bbentityid>bbEntityID</a> command.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>id</td><td class=argvalue>any integer value</td></tr>
</table>
</p>
See Also: <a href=#bbentityid>bbEntityID</a>
EndRem
Function SetEntityID(entity,id)="bbSetEntityID"

Rem
bbdoc: <p> Takes a snapshot of the entity including the position, rotation, scale and alpha.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
The <a href=#bbcaptureentity>bbCaptureEntity</a> command can be used after
<a href=#bbcaptureworld>bbCaptureWorld</a> to control the tweening of a specific
Entity. This is most useful when an entity needs to
be repositioned and tweening between it's last state
and current is not desired.
</p>
See Also: <a href=#bbcaptureworld>bbCaptureWorld</a>
EndRem
Function CaptureEntity(entity)="bbCaptureEntity"

Rem
bbdoc: <p> Returns True </p> <p> This command casts a ray (an imaginary line) from src_entity to dest_entity
about:
<table class="arg">
<tr><td class=argname>src_entity</td><td class=argvalue>source entity handle</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>destination entity handle</td></tr>
</table>
If the ray hits an obscurer entity the result is False
otherwise the function returns True
</p>
<p>
See the <a href=#bbentitypickmode>bbEntityPickMode</a> for setting an entity as an obscurer.
</p>
See Also: <a href=#bbentitypickmode>bbEntityPickMode</a>
EndRem
Function EntityVisible(src_entity,dest_entity)="bbEntityVisible"

Rem
bbdoc: <p> Returns the distance between src_entity and dest_entity.
about:
<table class="arg">
<tr><td class=argname>src_entity</td><td class=argvalue>source entity handle</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>destination entity handle</td></tr>
</table>
</p>
EndRem
Function EntityDistance#(src_entity,dest_entity)="bbEntityDistance"

Rem
bbdoc: <p> Returns the yaw angle, that src_entity should be rotated by in order to face dest_entity.
about:
<table class="arg">
<tr><td class=argname>src_entity</td><td class=argvalue>source entity handle</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>destination entity handle</td></tr>
</table>
</p>
<p>
This command can be used to be point one entity at another, rotating on
the y axis only.
</p>
See Also: <a href=#bbdeltapitch>bbDeltaPitch</a>
EndRem
Function DeltaYaw#(src_entity,dest_entity)="bbDeltaYaw"

Rem
bbdoc: <p> Returns the pitch angle, that src_entity should be rotated by in order to face dest_entity.
about:
<table class="arg">
<tr><td class=argname>src_entity</td><td class=argvalue>source entity handle</td></tr>
<tr><td class=argname>dest_entity</td><td class=argvalue>destination entity handle</td></tr>
</table>
</p>
<p>
This command can be used to be point one entity at another, rotating on
the x axis only.
</p>
See Also: <a href=#bbdeltayaw>bbDeltaYaw</a>
EndRem
Function DeltaPitch#(src_entity,dest_entity)="bbDeltaPitch"

Rem
bbdoc: <p> Animates an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>mode of animation. Defaults to 1.</td></tr>
<tr><td class=argname>speed#</td><td class=argvalue>speed of animation. Defaults to 1.</td></tr>
<tr><td class=argname>sequence</td><td class=argvalue>specifies which sequence of animation frames to play.  Defaults to 0.</td></tr>
<tr><td class=argname>transition#</td><td class=argvalue>used to tween between an entity's current position rotation and the first frame of animation. Defaults to 0.</td></tr>
</table>
</p>
<p>
The mode specified can be one of the following values:
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Descriptiopn</th></tr>
<tr><td class=data>ANIM_STOP</td><td class=data>0</td><td class=data>Stop animation</td></tr>
<tr><td class=data>ANIM_LOOP</td><td class=data>1</td><td class=data>Loop animation (default)</td></tr>
<tr><td class=data>ANIM_PINGPONG</td><td class=data>2</td><td class=data>Ping-pong animation</td></tr>
<tr><td class=data>ANIM_ONCE</td><td class=data>3</td><td class=data>One-shot animation</td></tr>
</table>
<p>
A <b>speed</b> of greater than 1.0 will cause the animation to replay
quicker, less than 1.0 slower. A negative speed will play the
animation backwards.
</p>
<p>
Animation sequences are numbered 0,1,2...etc. Initially, an entity
loaded with <a href=#bbloadanimmesh>bbLoadAnimMesh</a> will have a single animation sequence.
</p>
<p>
More sequences can be added using either <a href=#bbextractanimseq>bbExtractAnimSeq</a>,
<a href=#bbloadanimseq>bbLoadAnimSeq</a> or <a href=#bbaddanimseq>bbAddAnimSeq</a>.
</p>
<p>
The optional <b>transition</b> parameter can be set to 0 to cause an instant
'leap' to the first frame,  while values greater than 0 will cause a
smoother transition to occur.
</p>
<p>
While <a href=#bbanimate>bbAnimate</a> begins or ends an animation calling <a href=#bbupdateworld>bbUpdateWorld</a>
once every main loop causes the animation to actually play.
</p>
See Also: <a href=#bbupdateworld>bbUpdateWorld</a> <a href=#bbloadanimmesh>bbLoadAnimMesh</a> <a href=#bbextractanimseq>bbExtractAnimSeq</a> <a href=#bbloadanimseq>bbLoadAnimSeq</a> <a href=#bbaddanimseq>bbAddAnimSeq</a>
EndRem
Function Animate(entity,mode=1,speed#=1.0,sequence=0,transition#=0)="bbAnimate"

Rem
bbdoc: <p> This command allows you to convert an animation with an MD2-style series  of anim sequences into a pure Blitz anim sequence, and play it back as such using Animate.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>first_frame</td><td class=argvalue>first frame of anim sequence to extract</td></tr>
<tr><td class=argname>last_frame</td><td class=argvalue>last frame of anim sequence to extract</td></tr>
<tr><td class=argname>anim_seq</td><td class=argvalue>anim sequence to extract from. This is usually 0, and  as such defaults to 0.</td></tr>
</table>
</p>
EndRem
Function ExtractAnimSeq(entity,first_frame,last_frame,anim_seq=0)="bbExtractAnimSeq"

Rem
bbdoc: <p> Creates an animation sequence for an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>length</td><td class=argvalue>number of frames to be added</td></tr>
</table>
</p>
<p>
This must be done before any animation keys set by <a href=#bbsetanimkey>bbSetAnimKey</a> can be
used in  an actual animation however this is optional.
</p>
<p>
You may use it to &quot;bake&quot; the frames you have added previously
using SetAnimKey.
</p>
<p>
Returns the animation sequence number added.
</p>
See Also: <a href=#bbsetanimkey>bbSetAnimKey</a>
EndRem
Function AddAnimSeq(entity,length)="bbAddAnimSeq"

Rem
bbdoc: <p> Sets an animation key for the specified entity at the specified frame.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>frame</td><td class=argvalue>frame of animation to be used as anim key</td></tr>
<tr><td class=argname>pos_key</td><td class=argvalue>true to include entity position information when setting  key. Defaults to true.</td></tr>
<tr><td class=argname>rot_key</td><td class=argvalue>true to include entity rotation information when setting  key. Defaults to true.</td></tr>
<tr><td class=argname>scale_key</td><td class=argvalue>true to include entity scale information when setting  key. Defaults to true.</td></tr>
</table>
</p>
<p>
The entity must have a valid animation sequence to work with.
</p>
<p>
This is most useful when you've got a character, or a complete set of
complicated moves to perform, and you want to perform them en-masse.
</p>
See Also: <a href=#bbaddanimseq>bbAddAnimSeq</a>
EndRem
Function SetAnimKey(entity,frame,pos_key=True,rot_key=True,scale_key=True)="bbSetAnimKey"

Rem
bbdoc: <p> Appends an animation sequence from a file to an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
<tr><td class=argname>filename$</td><td class=argvalue>filename of animated 3D object</td></tr>
</table>
</p>
<p>
Returns the animation sequence number added.
</p>
See Also: <a href=#bbloadanimmesh>bbLoadAnimMesh</a>
EndRem
Function LoadAnimSeq(entity,filename$z)="bbLoadAnimSeq"

Rem
bbdoc: <p> SetAnimTime allows you to manually animate entities.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>a valid entity handle.</td></tr>
<tr><td class=argname>time#</td><td class=argvalue>a floating point time value.</td></tr>
<tr><td class=argname>anim_seq</td><td class=argvalue>an optional animation sequence number.</td></tr>
</table>
</p>
<p>
A combination of <a href=#bbanimate>bbAnimate</a> and <a href=#bbupdateworld>bbUpdateWorld</a> are usually
required for animation however the <a href=#bbsetanimtime>bbSetAnimTime</a> allows
an alternative method for the program to control animation
by manually controlling the entity's progress along its
animation timeline.
</p>
EndRem
Function SetAnimTime(entity,time#,anim_seq=0)="bbSetAnimTime"

Rem
bbdoc: <p> Returns the specified entity's current animation sequence.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
EndRem
Function AnimSeq(entity)="bbAnimSeq"

Rem
bbdoc: <p> Returns the length or duration of the specified entity's current animation sequence
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
The value returned is equivalent to the
number of frames or calls to UpdateWorld required to play
the entire animation once.
</p>
EndRem
Function AnimLength(entity)="bbAnimLength"

Rem
bbdoc: <p> Returns the current animation time of an entity.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
<a href=#bbanimtime>bbAnimTime</a> returns a float between 0.0 and the value returned
by the <a href=#bbanimlength>bbAnimLength</a>() function unless the animtion is in transition
in which case a value of 0.0 is returned.
</p>
See Also: <a href=#bbanimlength>bbAnimLength</a>
EndRem
Function AnimTime#(entity)="bbAnimTime"

Rem
bbdoc: <p> Returns true if the specified entity is currently animating.
about:
<table class="arg">
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
EndRem
Function Animating(entity)="bbAnimating"

Rem
bbdoc: <p> Creates a terrain entity and returns its handle.
about:
<table class="arg">
<tr><td class=argname>grid_size</td><td class=argvalue>no of grid squares along each side of terrain</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> entity of terrain</td></tr>
</table>
</p>
<p>
The terrain extends from 0,0,0 to grid_size,1,grid_size.
</p>
<p>
The grid_size, no of grid squares along each side of terrain, and must
be a  power of 2 value, e.g. 32, 64, 128, 256, 512, 1024.
</p>
<p>
A terrain is a special type of polygon object that uses real-time level of
detail (LOD) to display landscapes which should theoretically consist of
over a million polygons with only a few thousand.
</p>
<p>
The way it does this is by constantly rearranging a certain amount of
polygons to display high levels of detail close to the viewer and low
levels further away.
</p>
<p>
This constant rearrangement of polygons is occasionally noticeable
however,  and is a well-known side-effect of all LOD landscapes.
</p>
<p>
This 'pop-in' effect  can be reduced in lots of ways though, as the
other terrain help files will  go on to explain.
</p>
<p>
The optional <b>parent</b> parameter attaches the new terrain
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbloadterrain>bbLoadTerrain</a>
EndRem
Function CreateTerrain(grid_size,parent=0)="bbCreateTerrain"

Rem
bbdoc: <p> Loads a terrain from an image file and returns the terrain's handle.
about:
<table class="arg">
<tr><td class=argname>file$</td><td class=argvalue>filename of image file to be used as height map</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity of terrain</td></tr>
</table>
</p>
<p>
The image's red channel is used to determine heights. Terrain is
initially the same width and depth as the image, and 1 unit high.
</p>
<p>
Tips on generating nice terrain -
</p>
<p>
* Smooth or blur the height map
</p>
<p>
* Reduce the y scale of the terrain
</p>
<p>
* Increase the x/z scale of the terrain
</p>
<p>
* Reduce the camera range
</p>
<p>
When texturing an entity, a texture with a scale of 1,1,1
(default) will  be the same size as one of the terrain's grid squares. A
texture that is scaled  to the same size as the size of the bitmap used
to load it or the no. of grid  square used to create it, will be the same
size as the terrain.
</p>
<p>
A heightmaps dimensions (width and height) must be the same and must be a
power of 2, e.g. 32, 64, 128, 256, 512, 1024.
</p>
<p>
The optional <b>parent</b> parameter attaches the new terrain
to a parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for
more details on the effects of entity parenting.
</p>
See Also: <a href=#bbcreateterrain>bbCreateTerrain</a>
EndRem
Function LoadTerrain(file$z,parent=0)="bbLoadTerrain"

Rem
bbdoc: <p> Sets the detail level for a terrain
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>detail_level</td><td class=argvalue>detail level of terrain</td></tr>
<tr><td class=argname>vertex_morph</td><td class=argvalue>True to enable vertex morphing of terrain. Defaults to False.</td></tr>
</table>
This is the number
of triangles used  to represent the terrain. A typical value is 2000.
</p>
<p>
The optional <b>vertex_morph</b>  parameter specifies whether to enable vertex
morphing. It is recommended you  set this to True, as it will reduce the
visibility of LOD 'pop-in'.
</p>
EndRem
Function TerrainDetail(terrain,detail_level,vertex_morph=0)="bbTerrainDetail"

Rem
bbdoc: <p> Enables or disables terrain shading.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>enable</td><td class=argvalue>True to enable terrain shading, False to to disable it. The default  mode is False.</td></tr>
</table>
</p>
<p>
Shaded terrains are a little slower  than non-shaded terrains, and in
some instances can increase the visibility  of LOD 'pop-in'. However, the
option is there to have shaded terrains if you  wish to do so.
</p>
EndRem
Function TerrainShading(terrain,enable)="bbTerrainShading"

Rem
bbdoc: <p> Sets the height of a point on a terrain.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>grid_x</td><td class=argvalue>grid x coordinate of terrain</td></tr>
<tr><td class=argname>grid_z</td><td class=argvalue>grid z coordinate of terrain</td></tr>
<tr><td class=argname>height#</td><td class=argvalue>height of point on terrain. Should be in the range 0-1.</td></tr>
<tr><td class=argname>realtime</td><td class=argvalue>True to modify terrain immediately. False to modify terrain when RenderWorld in next called. Defaults to False.</td></tr>
</table>
</p>
EndRem
Function ModifyTerrain(terrain,grid_x,grid_z,height#,realtime=0)="bbModifyTerrain"

Rem
bbdoc: <p> Returns the grid size used to create a terrain.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
</table>
</p>
EndRem
Function TerrainSize(terrain)="bbTerrainSize"

Rem
bbdoc: <p> Returns the height of the terrain at terrain grid coordinates x,z.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>grid_x</td><td class=argvalue>grid x coordinate of terrain</td></tr>
<tr><td class=argname>grid_z</td><td class=argvalue>grid z coordinate of terrain</td></tr>
</table>
</p>
<p>
The value returned is in the range 0 to 1.
</p>
See Also: <a href=#bbterrainy>bbTerrainY</a>
EndRem
Function TerrainHeight#(terrain,grid_x,grid_z)="bbTerrainHeight"

Rem
bbdoc: <p> Returns the interpolated x coordinate on a terrain.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>world x coordinate</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>world y coordinate</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>world z coordinate</td></tr>
</table>
</p>
See Also: <a href=#bbterrainy>bbTerrainY</a> <a href=#bbterrainz>bbTerrainZ</a>
EndRem
Function TerrainX#(terrain,x#,y#,z#)="bbTerrainX"

Rem
bbdoc: <p> Returns the interpolated y coordinate on a terrain.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>world x coordinate</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>world y coordinate</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>world z coordinate</td></tr>
</table>
</p>
<p>
<a href=#bbterrainy>bbTerrainY</a> can be used to calculate the effective height of a
terrain directly below / above the specified point.
</p>
See Also: <a href=#bbterrainx>bbTerrainX</a> <a href=#bbterrainz>bbTerrainZ</a> <a href=#bbterrainheight>bbTerrainHeight</a>
EndRem
Function TerrainY#(terrain,x#,y#,z#)="bbTerrainY"

Rem
bbdoc: <p> Returns the interpolated z coordinate on a terrain.
about:
<table class="arg">
<tr><td class=argname>terrain</td><td class=argvalue>terrain handle</td></tr>
<tr><td class=argname>x#</td><td class=argvalue>world x coordinate</td></tr>
<tr><td class=argname>y#</td><td class=argvalue>world y coordinate</td></tr>
<tr><td class=argname>z#</td><td class=argvalue>world z coordinate</td></tr>
</table>
</p>
See Also: <a href=#bbterrainx>bbTerrainX</a> <a href=#bbterrainy>bbTerrainY</a>
EndRem
Function TerrainZ#(terrain,x#,y#,z#)="bbTerrainZ"

Rem
bbdoc: <p> Creates a sprite entity and returns its handle.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> entity of sprite</td></tr>
</table>
</p>
<p>
Sprites are 2D rectangles that can be oriented automatically
towards the current rendering camera.
</p>
<p>
Sprites are created at position (0,0,0) and extend from
(-1,-1,0) to (+1,+1,0) billboard style.
</p>
<p>
Unlike other entities sprites are created with a default <a href=#bbentityfx>bbEntityFX</a>
flag of 1 (FullBright).
</p>
<p>
The orientation used to render a sprite unlike other entities
is goverened by a combination of the sprite entities own position
and orientation, the rendering camera's orientation and the
<a href=#bbspriteviewmode>bbSpriteViewMode</a>.
</p>
<p>
The default viewmode of a sprite means it is always turned
to face the camera. See the <a href=#bbspriteviewmode>bbSpriteViewMode</a> command for more
information.
</p>
<p>
The optional <b>parent</b> parameter attaches the new Sprite entity to a
specified parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for more
information on entity hierachy.
</p>
<p>
Unlike many Blitz3D primitives Sprites are not mesh based
and must not have mesh based commands used on them.
</p>
See Also: <a href=#bbloadsprite>bbLoadSprite</a> <a href=#bbrotatesprite>bbRotateSprite</a> <a href=#bbscalesprite>bbScaleSprite</a> <a href=#bbhandlesprite>bbHandleSprite</a> <a href=#bbspriteviewmode>bbSpriteViewMode</a> <a href=#bbpositionentity>bbPositionEntity</a> <a href=#bbmoveentity>bbMoveEntity</a> <a href=#bbtranslateentity>bbTranslateEntity</a> <a href=#bbentityalpha>bbEntityAlpha</a> <a href=#bbfreeentity>bbFreeEntity</a>
EndRem
Function CreateSprite(parent=0)="bbCreateSprite"

Rem
bbdoc: <p> Creates a sprite entity, and assigns a texture to it.
about:
<table class="arg">
<tr><td class=argname>path$</td><td class=argvalue>filename of image file to be used as sprite</td></tr>
<tr><td class=argname>tex_flag</td><td class=argvalue>optional texture flag</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>optional <b>parent</b> of entity</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Name</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>TX_COLOR</td><td class=data>1</td><td class=data>Color (default)</td></tr>
<tr><td class=data>TX_ALPHA</td><td class=data>2</td><td class=data>Alpha</td></tr>
<tr><td class=data>TX_MASKED</td><td class=data>4</td><td class=data>Masked</td></tr>
<tr><td class=data>TX_MIP</td><td class=data>8</td><td class=data>Mipmapped</td></tr>
<tr><td class=data>TX_CLAMPU</td><td class=data>16</td><td class=data>Clamp U</td></tr>
<tr><td class=data>TX_CLAMPV</td><td class=data>32</td><td class=data>Clamp V</td></tr>
<tr><td class=data>TX_SPHERE</td><td class=data>64</td><td class=data>Spherical reflection map</td></tr>
<tr><td class=data>TX_CUBIC</td><td class=data>128</td><td class=data>Cubic environment map</td></tr>
<tr><td class=data>TX_VRAM</td><td class=data>256</td><td class=data>Store texture in vram</td></tr>
<tr><td class=data>TX_HIGHCOLOR</td><td class=data>512</td><td class=data>Force the use of high color textures</td></tr>
</table>
<p>
See the <a href=#bbcreatetexture>bbCreateTexture</a> command for a detailed description
of the texture flags.
</p>
<p>
The optional <b>parent</b> parameter attaches the new Sprite entity to a
specified parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for more
information on entity hierachy.
</p>
See Also: <a href=#bbloadsprite>bbLoadSprite</a> <a href=#bbrotatesprite>bbRotateSprite</a> <a href=#bbscalesprite>bbScaleSprite</a> <a href=#bbhandlesprite>bbHandleSprite</a> <a href=#bbspriteviewmode>bbSpriteViewMode</a> <a href=#bbpositionentity>bbPositionEntity</a> <a href=#bbmoveentity>bbMoveEntity</a> <a href=#bbtranslateentity>bbTranslateEntity</a> <a href=#bbentityalpha>bbEntityAlpha</a> <a href=#bbfreeentity>bbFreeEntity</a>
EndRem
Function LoadSprite(path$z,tex_flag=0,parent=0)="bbLoadSprite"

Rem
bbdoc: <p> Sets the view mode of a sprite.
about:
<table class="arg">
<tr><td class=argname>sprite</td><td class=argvalue>spritehandle</td></tr>
<tr><td class=argname>view_mode</td><td class=argvalue>view_mode of sprite</td></tr>
</table>
</p>
<p>
The view mode determines how at rendertime a sprite alters its
orientation in respect to the camera:
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>SPRITE_TURNXY</td><td class=data>1</td><td class=data>Turn about X and Y axis to face camera</td></tr>
<tr><td class=data>SPRITE_STILL</td><td class=data>2</td><td class=data>Do not modify orientation at render time.</td></tr>
<tr><td class=data>SPRITE_ALIGNZ</td><td class=data>3</td><td class=data>Turn about X and Y axis to face camera and align Z axis with camera</td></tr>
<tr><td class=data>SPRITE_TURNY</td><td class=data>4</td><td class=data>Turn about Y axis to face camera</td></tr>
</table>
<p>
This allows the sprite to in  some instances give the impression
that it is more than two dimensional.
</p>
<p>
In technical terms, the four sprite modes perform the following
changes:
</p>
<p>
Mode 1 - Sprite changes its pitch and yaw values to face camera,
but doesn't roll, good for most smoke and particle effects.
</p>
<p>
Mode 2 - Sprite does not change either its pitch, yaw or roll
values, good for generic flat rectangular entities such as fences.
</p>
<p>
Mode 3 - Sprite changes its yaw and pitch to face camera, and
changes its roll value to match cameras, useful for overlays.
</p>
<p>
Mode 4 - Sprite changes its yaw to face camera, pitch and roll
are unmodified. Useful for trees and other upstanding scenery.
</p>
<p class="hint">
The <a href=#bbentityfx>bbEntityFX</a> flag 16 can be used to make a Sprite double sided
and hence visible from both sides. This applies to Mode 2 Sprites
in particular.
</p>
See Also: <a href=#bbcreatesprite>bbCreateSprite</a> <a href=#bbloadsprite>bbLoadSprite</a>
EndRem
Function SpriteViewMode(sprite,view_mode)="bbSpriteViewMode"

Rem
bbdoc: <p> Rotates a sprite.
about:
<table class="arg">
<tr><td class=argname>sprite</td><td class=argvalue>sprite handle</td></tr>
<tr><td class=argname>angle#</td><td class=argvalue>absolute angle of sprite rotation</td></tr>
</table>
</p>
See Also: <a href=#bbcreatesprite>bbCreateSprite</a> <a href=#bbloadsprite>bbLoadSprite</a>
EndRem
Function RotateSprite(sprite,angle#)="bbRotateSprite"

Rem
bbdoc: <p> Scales a sprite.
about:
<table class="arg">
<tr><td class=argname>sprite</td><td class=argvalue>sprite handle</td></tr>
<tr><td class=argname>x_scale#</td><td class=argvalue>x scale of sprite</td></tr>
<tr><td class=argname>y_scale#</td><td class=argvalue>y scale of sprite</td></tr>
</table>
</p>
See Also: <a href=#bbloadsprite>bbLoadSprite</a> <a href=#bbcreatesprite>bbCreateSprite</a>
EndRem
Function ScaleSprite(sprite,x_scale#,y_scale#)="bbScaleSprite"

Rem
bbdoc: <p> Sets a sprite handle.
about:
<table class="arg">
<tr><td class=argname>sprite</td><td class=argvalue>sprite handle.</td></tr>
<tr><td class=argname>x_handle#</td><td class=argvalue>x handle of sprite</td></tr>
<tr><td class=argname>y_handle#</td><td class=argvalue>y handle of sprite</td></tr>
</table>
</p>
<p>
As a sprite extends from -1,-1 to +1,+1 and the handle
defaults to 0,0 the standard handle of a sprite is
the center of its image.
</p>
<p>
A sprite's handle represents the relative position on the
sprite image used to position the sprite when
being rendered.
</p>
See Also: <a href=#bbloadsprite>bbLoadSprite</a> <a href=#bbcreatesprite>bbCreateSprite</a>
EndRem
Function HandleSprite(sprite,x_handle#,y_handle#)="bbHandleSprite"

Rem
bbdoc: <p> Loads an MD2 entity and returns its handle.
about:
<table class="arg">
<tr><td class=argname>md2_file$</td><td class=argvalue>filename of md2</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity of md2</td></tr>
</table>
</p>
<p>
The MD2 model format uses a highly efficient vertex animation
technology that is not compatible with the standard Blitz3D
animation system but instead requires use of the specific MD2
animation commands.
</p>
<p>
The optional <b>parent</b> parameter attaches the new MD2 entity to a
specified parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for more
information on entity hierachy.
</p>
<p class="hint">
An MD2 texture has to be loaded and applied separately, otherwise the md2
will appear untextured.
</p>
See Also: <a href=#bbanimatemd2>bbAnimateMD2</a> <a href=#bbmd2animtime>bbMD2AnimTime</a> <a href=#bbmd2animlength>bbMD2AnimLength</a> <a href=#bbmd2animtime>bbMD2AnimTime</a> <a href=#bbmd2animating>bbMD2Animating</a>
EndRem
Function LoadMD2(md2_file$z,parent=0)="bbLoadMD2"

Rem
bbdoc: <p> Animates an md2 entity.
about:
<table class="arg">
<tr><td class=argname>md2</td><td class=argvalue>md2 handle</td></tr>
<tr><td class=argname>mode</td><td class=argvalue>mode of animation</td></tr>
<tr><td class=argname>speed#</td><td class=argvalue>speed of animation. Defaults to  1.</td></tr>
<tr><td class=argname>first_frame</td><td class=argvalue>first frame of animation. Defaults to 1.</td></tr>
<tr><td class=argname>last_frame#</td><td class=argvalue>last frame of animation. Defaults to last frame of  all md2 animations.</td></tr>
<tr><td class=argname>transition#</td><td class=argvalue>smoothness of transition between last frame shown of  previous animation and first frame of next animation. Defaults to 0.</td></tr>
</table>
</p>
<table class="data">
<tr><th class=data>Mode</th><th class=data>Value</th><th class=data>Description</th></tr>
<tr><td class=data>ANIM_STOP</td><td class=data>0</td><td class=data>Stop animation</td></tr>
<tr><td class=data>ANIM_LOOP</td><td class=data>1</td><td class=data>Loop animation (default)</td></tr>
<tr><td class=data>ANIM_PINGPONG</td><td class=data>2</td><td class=data>PingPong animation</td></tr>
<tr><td class=data>ANIM_ONCE</td><td class=data>3</td><td class=data>OneShot animation</td></tr>
</table>
<p>
The MD2 will actually move from one frame to the next when UpdateWorld is called.
</p>
See Also: <a href=#bbmd2animating>bbMD2Animating</a>
EndRem
Function AnimateMD2(md2,mode=0,speed#=1.0,first_frame=1,last_frame=0,transition#=0)="bbAnimateMD2"

Rem
bbdoc: <p> Returns the animation time of an md2 model.
about:
<table class="arg">
<tr><td class=argname>md2</td><td class=argvalue>md2 handle</td></tr>
</table>
</p>
<p>
The animation time is the exact moment that the MD2 is at with
regards its frames of animation.
</p>
<p>
For example, if the MD2 entity is currently animating between
the third and fourth frames, then MD2AnimTime will return a
number somewhere between 3 and 4.
</p>
EndRem
Function MD2AnimTime(md2)="bbMD2AnimTime"

Rem
bbdoc: <p> Returns the animation length of an MD2 model in frames.
about:
<table class="arg">
<tr><td class=argname>md2</td><td class=argvalue>md2 handle</td></tr>
</table>
</p>
<p>
The animation length is the total number of animation frames
loaded from the MD2 file.
</p>
EndRem
Function MD2AnimLength(md2)="bbMD2AnimLength"

Rem
bbdoc: <p> Returns True False </p>
about:
<table class="arg">
<tr><td class=argname>md2</td><td class=argvalue>md2 handle</td></tr>
</table>
See Also: <a href=#bbanimatemd2>bbAnimateMD2</a>
EndRem
Function MD2Animating(md2)="bbMD2Animating"

Rem
bbdoc: <p> Loads a BSP model and returns its handle.
about:
<table class="arg">
<tr><td class=argname>file$</td><td class=argvalue>filename of BSP model</td></tr>
<tr><td class=argname>gamma_adjust#</td><td class=argvalue>intensity of BSP lightmaps. Values should be in the  range 0-1. Defaults to 0.</td></tr>
<tr><td class=argname>parent</td><td class=argvalue>parent entity of BSP</td></tr>
</table>
</p>
<p>
A BSP model is a standard Blitz3D entity. Use the standard entity commands to
scale, rotate and position the BSP, and the standard collision commands to
setup collisions with the BSP.
</p>
<p>
BSP models are not lit by either <a href=#bbambientlight>bbAmbientLight</a> or any directional
lights. This allows you to setup lighting for in-game models without affecting
the BSP's internal lighting. BSP models ARE lit by point or spot lights.
See the <a href=#bbbspambientlight>bbBSPAmbientLight</a> and <a href=#bbbsplighting>bbBSPLighting</a> commands for more control
over the lighting of BSP entities.
</p>
<p>
BSP's cannot be painted, textured, colored, faded etc. in Blitz3D.
</p>
<p>
Textures for the BSP model must be in the same directory as the BSP
file itself.
</p>
<p>
Shaders are *not* supported!
</p>
<p>
The optional <b>parent</b> parameter attaches the new Sprite entity to a
specified parent entity. See the <a href=#bbentityparent>bbEntityParent</a> command for more
information on entity hierachy.
</p>
See Also: <a href=#bbbspambientlight>bbBSPAmbientLight</a> <a href=#bbbsplighting>bbBSPLighting</a>
EndRem
Function LoadBSP(file$z,gamma_adjust#=0,parent=0)="bbLoadBSP"

Rem
bbdoc: <p> Sets the ambient lighting color for a BSP model.
about:
<table class="arg">
<tr><td class=argname>bsp</td><td class=argvalue>BSP handle</td></tr>
<tr><td class=argname>red#</td><td class=argvalue>red BSP ambient light value</td></tr>
<tr><td class=argname>green#</td><td class=argvalue>green BSP ambient light value</td></tr>
<tr><td class=argname>blue#</td><td class=argvalue>blue BSP ambient light value</td></tr>
</table>
</p>
<p>
The red, green and blue values should  be in the range 0-255. The default
BSP ambient light color is 0,0,0.
</p>
<p>
Note that BSP models  do not use the <a href=#bbambientlight>bbAmbientLight</a> setting.
</p>
<p>
This can also be used to increase the brightness of a BSP model,
but the effect is  not as 'nice' as using the <b>gamma_adjust</b> parameter of
LoadBSP.
</p>
See Also: <a href=#bbloadbsp>bbLoadBSP</a> <a href=#bbbsplighting>bbBSPLighting</a>
EndRem
Function BSPAmbientLight(bsp,red#,green#,blue#)="bbBSPAmbientLight"

Rem
bbdoc: <p> Controls whether BSP models are illuminated using lightmaps, or by vertex lighting.
about:
<table class="arg">
<tr><td class=argname>bsp</td><td class=argvalue>BSP handle</td></tr>
<tr><td class=argname>use_lightmaps</td><td class=argvalue>True to use lightmaps, False for vertex lighting. The default  mode is True.</td></tr>
</table>
</p>
<p>
Vertex lighting will be faster on some graphics cards, but may not look
as good.
</p>
See Also: <a href=#bbloadbsp>bbLoadBSP</a> <a href=#bbbspambientlight>bbBSPAmbientLight</a>
EndRem
Function BSPLighting(bsp,use_lightmaps)="bbBSPLighting"

Rem
bbdoc: <p> Creates a listener entity and returns its handle.
about:
<table class="arg">
<tr><td class=argname>parent</td><td class=argvalue>parent entity of listener. A parent entity, typically a camera,  must be specified to 'carry' the listener around.</td></tr>
<tr><td class=argname>rolloff_factor#</td><td class=argvalue>the rate at which volume diminishes with distance.  Defaults to 1.</td></tr>
<tr><td class=argname>doppler_scale#</td><td class=argvalue>the severity of the doppler effect. Defaults to  1.</td></tr>
<tr><td class=argname>distance_scale#</td><td class=argvalue>artificially scales distances. Defaults to 1.</td></tr>
</table>
</p>
<p>
Currently, only a single listener is supported which is typically parented
to the program's main camera.
</p>
See Also: <a href=#bbloadsound>bbLoadSound</a> <a href=#bbemitsound>bbEmitSound</a>
EndRem
Function CreateListener(parent,rolloff_factor#=1.0,doppler_scale#=1.0,distance_scale#=1.0)="bbCreateListener"

Rem
bbdoc: <p> Emits a sound attached to the specified entity and returns a sound channel.
about:
<table class="arg">
<tr><td class=argname>sound</td><td class=argvalue>sound handle</td></tr>
<tr><td class=argname>entity</td><td class=argvalue>entity handle</td></tr>
</table>
</p>
<p>
The sound must have been loaded using <a href=#bbloadsound>bbLoadSound</a> with the SOUND3D
flag.
</p>
<p>
The sound channel returned can subsequently be used with such sound channel
commands as <a href=#bbchannelvolume>bbChannelVolume</a> and <a href=#bbchannelpitch>bbChannelPitch</a>.
</p>
See Also: <a href=#bbloadsound>bbLoadSound</a> <a href=#bbcreatelistener>bbCreateListener</a> <a href=#bbchannelvolume>bbChannelVolume</a> <a href=#bbchannelpitch>bbChannelPitch</a>
EndRem
Function EmitSound(sound,entity)="bbEmitSound"

EndExtern

Function GetChar()
	Return GetKey()
End Function

Function SetChannelVolume(channel,volume)
	ChannelVolume channel,volume
End Function

Function TextureName$(tex)
	Return String.FromCString( bbTextureName(tex) )
End Function

Function EntityName$(entity)
	Return String.FromCString( bbEntityName(entity) )
End Function

Function EntityClass$(entity)
	Return String.FromCString( bbEntityClass(entity) )
End Function
