import XMonad
import qualified XMonad.StackSet as W
import System.Exit

import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll (sinkAll, killAll)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.LayoutModifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger



myModMask                               = mod4Mask                                          :: KeyMask
myBrowser                               = "firefox"                                         :: String
myTerminal                              = "termite"                                         :: String
myEmacs                                 = "emacsclient -c -a 'emacs' "                      :: String
myEditor                                = "emacsclient -c -a 'emacs'"                       :: String
myBorderWidth                           = 2                                                 :: Dimension
myBorderColor                           = "#6272a4"                                         :: String
myFocusedBorderColor                    = "#ff79c6"                                         :: String
myFileManager                           = "pcmanfm"                                         :: String
myWorkspaces                            = ["1","2","3","4","5","6","7","8","9"]


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --no-fading-openclose"
    spawn "/usr/bin/emacs --daemon"

myConfig = def
    { modMask                           = myModMask
    , terminal                          = myTerminal
    , startupHook                       = myStartupHook
    , layoutHook                        = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ myLayout
    , manageHook                        = myManageHook
    , normalBorderColor                 = myBorderColor
    , focusedBorderColor                = myFocusedBorderColor
    , borderWidth                       = myBorderWidth
    , workspaces                        = myWorkspaces
    }
  `additionalKeysP`
    [ ("M-<Return>",                    spawn myTerminal                                    )
    , ("M-S-<Return>",                  spawn "dmenu_run"                                   )
    , ("M-f",                           spawn myBrowser                                     )
    , ("M-S-c",                         kill                                                )
    , ("M-S-a",                         killAll                                             )
    , ("M-M1-h",                        spawn (myTerminal ++ " -e htop")                    )
    , ("M-S-e",                         spawn myEditor                                      )
    , ("M-e",                           spawn myFileManager                                 )
    , ("M-l",                           io (exitWith ExitSuccess)                           )
    ]



myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp"               --> doFloat
    , isDialog                          --> doFloat
    ]


myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol                            = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled                               = Tall nmaster delta ratio
    nmaster                             = 1      -- Default number of windows in the master pane
    ratio                               = 1/2    -- Default proportion of screen occupied by master pane
    delta                               = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep                             = myOrange " <fn=1> \xf6d8 </fn>"
    , ppTitleSanitize                   = xmobarStrip
    , ppCurrent                         = wrap (myGreen "[ ") (myGreen " ]") . myPink
    , ppHidden                          = myPink . wrap " *" ""
    , ppHiddenNoWindows                 = myPurple . wrap " " ""
    , ppUrgent                          = myRed . wrap (myYellow "!") (myYellow "!")
    , ppOrder                           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras                          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused                       = wrap (myGreen "[ ") (myGreen " ]") . myFgColor . ppWindow
    formatUnfocused                     = wrap (myComment "[ ") (myComment " ]") . myCurrentLine . ppWindow

    ppWindow :: String -> String
    ppWindow                            = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    myBgColor, myFgColor, myCurrentLine, myComment, myCyan, myGreen, myOrange, myPink, myPurple, myRed, myYellow :: String -> String
    myBgColor                           = xmobarColor "#282a36" ""
    myFgColor                           = xmobarColor "#f8f8f2" ""
    myCurrentLine                       = xmobarColor "#44475a" ""
    myComment                           = xmobarColor "#6272a4" ""
    myCyan                              = xmobarColor "#8be9fd" ""
    myGreen                             = xmobarColor "#50fa7b" ""
    myOrange                            = xmobarColor "#ffb86c" ""
    myPink                              = xmobarColor "#ff79c6" ""
    myPurple                            = xmobarColor "#bd93f9" ""
    myRed                               = xmobarColor "#ff5555" ""
    myYellow                            = xmobarColor "#f1fa8c" ""
