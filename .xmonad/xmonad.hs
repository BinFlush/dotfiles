-- Jákups xmonad xonfig file
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Themes
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Hooks.SetWMName
-- import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.Layout.Tabbed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.NoBorders
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.InsertPosition
import XMonad.Util.NamedScratchpad
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageHelpers
--import XMonad.Util.Font
--------main :: IO ()
--------main = return ()
-- main = xmonad defaultConfig
--     { startupHook = setWMName "LG3D" }

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "st"
-- myTerminal      = "kitty"
--

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
--
---- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ff0000"

-- xloadimage -onroot -fullscreen </home/jakupl/Pictures/ubuntu-dark-background.jpg>

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $


    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- Mundtlig matematik A eksamen special!
--    , ((modm		  , xK_x     ), spawn $ myTerminal ++ " -e vim -c VimtexCompile /home/jakupl/Kvuc/matematik/matA/mundtlig/notertilmundtlig.tex")
--    , ((modm		  , xK_x     ), spawn $ myTerminal ++ " -e vim -c VimtexCompile /home/jakupl/Kvuc/sso/latex/SSO.tex")
--    , ((modm		  , xK_f     ), spawn "formelsamlingA")
    -- DISABLE MOUSE SHORTCUT
    , ((modm .|. shiftMask, xK_m     ), spawn "/home/jakupl/keyboarddisable/touchpadonoff.sh")

    -- Show workspace numbers
    , ((modm, xK_plus     ), spawn "/home/jakupl/.xmonad/wsnr.sh")

    -- Volume controls
    , ((0                     , 0x1008FF11), spawn "/home/jakupl/.xmonad/volume/volume.py dn")
    , ((0                     , 0x1008FF13), spawn "/home/jakupl/.xmonad/volume/volume.py up")
    , ((0                     , 0x1008FF12), spawn "/home/jakupl/.xmonad/volume/togglemute.sh")
    
    -- brightness control
    , ((0                     , 0x1008ff02), spawn "/home/jakupl/.xmonad/brightness/bright.py up")
    , ((0                     , 0x1008ff03), spawn "/home/jakupl/.xmonad/brightness/bright.py dn")
    -- toggle notifications
    , ((modm, xK_Escape), spawn "/home/jakupl/.xmonad/notify-mute.py")


    -- toggle lockscreen
    , ((modm .|. shiftMask, xK_Escape), spawn "/home/jakupl/.xmonad/lockscreen_blur.py toggle")


    -- Keyboard Layout switcher
    -- , ((modm .|. shiftMask, xK_Escape), spawn "/home/jakupl/customscripts/layout_switch.sh")

    -- toggle fullscreen
    , ((modm .|. shiftMask, xK_f), sendMessage ToggleLayout )
    -- lock screen
    , ((modm .|. shiftMask, xK_l), spawn "/home/jakupl/.xmonad/lockscreen_blur.py lock")

    -- Sagemath scratchpad
    , ((modm,   xK_b), namedScratchpadAction myScratchPads "terminal")
    , ((modm .|. shiftMask,   xK_b), namedScratchpadAction myScratchPads "terminalclean")

    , ((modm,               xK_s     ), namedScratchpadAction myScratchPads "signal-desktop")
    , ((modm,               xK_a     ), namedScratchpadAction myScratchPads "messenger")
    , ((modm,               xK_n     ), namedScratchpadAction myScratchPads "pymodoro")
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run -nb '#B90000'")


{-  EMERGENCY MOUSECLICK BINDINGS FOR MY BROKEN LAPTOP
    , ((0,              0xffbe     ), spawn "sleep 0.1 && xdotool click 1")
    , ((modm .|. shiftMask,              xK_p     ), spawn "xdotool click 1")
    , ((modm,              0xffbe     ), spawn "/home/jakupl/.xmonad/clicker/lefthold.sh")
    , ((shiftMask,              0xffbe     ), spawn "/home/jakupl/.xmonad/clicker/lefthold.sh")
    , ((0,              0xffbf     ), spawn "sleep 0.1 && xdotool click 2")
    , ((shiftMask,              0xffbf     ), spawn "/home/jakupl/.xmonad/clicker/midhold.sh")
    , ((0,              0xffc0     ), spawn "sleep 0.1 && xdotool click 3")
    , ((modm,              0xffc0     ), spawn "/home/jakupl/.xmonad/clicker/righthold.sh")
    , ((shiftMask,              0xffc0     ), spawn "/home/jakupl/.xmonad/clicker/righthold.sh")
    , ((0,              0xffc1     ), spawn "xdotool click 5")
    , ((0,              0xffc2     ), spawn "xdotool click 4")
-}

    -- launch passmenu
    , ((modm,               xK_o     ), spawn "passmenu")

    -- launch gmrun
--    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
--    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_k     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_j     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
   , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
--myTheme = defaultTheme { fontName = "xft:DejaVu Sans:size=10" }

myLayout = toggleLayouts (noBorders Full) (avoidStruts (smartSpacing 2 $ tiled ||| Mirror tiled ||| simpleTabbed))
--myLayout = tiled ||| Mirror tiled ||| tabbed shrinkText tabConfig ||| Full
--myLayout = tiled ||| Mirror tiled ||| simpleTabbed ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2/3

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


-----------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "vlc"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , title  =? "wsnumber1"          --> doF W.focusDown <+> doFloat <+> doShift "1" 
    , title  =? "wsnumber2"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "2"
    , title  =? "wsnumber3"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "3"
    , title  =? "wsnumber4"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "4"
    , title  =? "wsnumber5"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "5"
    , title  =? "wsnumber6"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "6"
    , title  =? "wsnumber7"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "7"
    , title  =? "wsnumber8"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "8"
    , title  =? "wsnumber9"          --> doF W.focusDown <+> doCenterFloat  <+> doShift "9"
    , title  =? "batteryalert"          --> doF W.focusDown <+> doCenterFloat
    , title  =? "floatme"       --> doCenterFloat]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- Set opacity of unfocused windows
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
     where fadeAmount = 0xbddddddd
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = do
myStartupHook = do
    spawnOnce "nitrogen --restore &"
--    spawnOnce "compton &"
--    spawnOnce "xmobar &"
--    spawnOnce "stalonetray &"
--    spawnOnce "/home/jakupl/nmappletskript/nmskript.sh &"
--    spawnOnce "unclutter --timeout 8 &"
--    spawnOnce "echo hey &"
------------------------------------------------------------------------
myScratchPads = [ NS "terminalclean" spawnTermc findTermc manageTermc, NS "terminal" spawnTerm findTerm manageTerm,  NS "signal-desktop" spawnSig findSig manageSig, NS "messenger" spawnMess findMess manageMess, NS "pymodoro" spawnPom findPom managePom]

  where
    spawnTerm  = myTerminal ++ " -T sagepad" ++ " -e sage"
    findTerm   = title =? "sagepad"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.25
        w = 0.38
        t = 0.3 -h
        l = 0.95 -w
    spawnTermc  = myTerminal ++ " -T termclean"
    findTermc   = title =? "termclean"
    manageTermc = customFloating $ W.RationalRect l t w h
      where
        h = 0.25
        w = 0.38
        t = 0.55 -h
        l = 0.95 -w
    spawnSig  = "signal-desktop"
    findSig   = className =? "Signal"
    manageSig = customFloating $ W.RationalRect l t w h
      where
        h = 0.8
        w = 0.8
        t = 0.9 -h
        l = 0.95 -w
    spawnMess  = "caprine"
    findMess   = className =? "Caprine"
    manageMess = customFloating $ W.RationalRect l t w h
      where
        h = 0.8
        w = 0.8
        t = 0.9 -h
        l = 0.85 -w
    spawnPom  = "pymodoro"
    findPom   = title =? "Pymodoro"
--    managePom = doCenterFloat
    managePom = doFloatAt 0.4525 0.3
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do 
  xmproc <- spawnPipe "xmobar -x 0 /home/jakup/.config/xmobar/xmobarrc"
  xmonad $ docks defaults
    { startupHook = setWMName "LG3D" } -- some old crap to make old java work
--    { startupHook = setWMName "XMonad" }




-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
--        manageHook         = myManageHook <+> namedScratchpadManageHook myScratchPads,
        manageHook         = myManageHook <+> namedScratchpadManageHook myScratchPads <+> insertPosition Below Newer,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
