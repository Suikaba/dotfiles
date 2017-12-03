import qualified Data.Map as M
import XMonad
import qualified XMonad.StackSet as W

import Control.Monad (liftM2)
import System.IO -- for xmobar

import XMonad.Hooks.EwmhDesktops

import XMonad.Actions.CopyWindow -- kill1, etc
import XMonad.Actions.CycleWS -- nextWS, etc
import XMonad.Actions.FloatKeys
import XMonad.Actions.UpdatePointer

import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.TwoPane
import XMonad.Layout.Gaps

import XMonad.Hooks.DynamicLog -- for xmobar
import XMonad.Hooks.ManageDocks -- avoid xmobar area
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig  -- removeKeys, additionalKeys
import XMonad.Util.SpawnOnce



colorGreen = "#88b986"
colorGray = "#676767"

gapWidth = 5


main = do
    xmproc <- spawnPipe myWsBar -- call xmobar
    xmonad $ docks $ ewmh defaultConfig
        {
            modMask = mod4Mask, -- Use Super(Win Key) instead of Alt
            terminal = "urxvt",
            normalBorderColor = colorGray,
            focusedBorderColor = colorGreen,
            startupHook = myStartupHook,
            manageHook =  myManageHookFloat <+> manageHook defaultConfig <+> manageDocks,
            borderWidth = 2,
            workspaces = ["1", "2", "3", "4", "5"],
            layoutHook = avoidStruts $ (toggleLayouts (noBorders Full)
                                       $ myLayout),
            -- xmobar
            logHook = myLogHook xmproc >> updatePointer (0.5, 0.5) (0, 0),
            handleEventHook = fullscreenEventHook
        }

        -- Defines keys to remove
        `removeKeysP`
        [
            "M-S-c",
            "M-S-<Return>"
        ]

        -- Keymap: window operations
        `additionalKeysP`
        [
            -- Shrink / Expand the focued window
            ("M-,", sendMessage Shrink),
            ("M-.", sendMessage Expand),
            ("M-z", sendMessage MirrorShrink),
            ("M-a", sendMessage MirrorExpand),
            -- Toggle layout (Fullscreen mode)
            ("M-f", sendMessage ToggleLayout),
            -- Move the focused window
            ("M-C-<R>", withFocused (keysMoveWindow(3, 0))),
            ("M-C-<L>", withFocused (keysMoveWindow(-3, 0))),
            ("M-C-<U>", withFocused (keysMoveWindow(0, -3))),
            ("M-C-<D>", withFocused (keysMoveWindow(0, 3))),
            -- Resize the focused window
            ("M-s", withFocused (keysResizeWindow(-6, -6) (0.5, 0.5))),
            ("M-i", withFocused (keysResizeWindow(6, 6) (0.5, 0.5))),
            -- Close the focused window
            ("M-c", kill1),
            -- Go to the next / previous workspace
            ("M-<R>", nextWS),
            ("M-<L>", prevWS),
            ("M-l", nextWS),
            ("M-h", prevWS),
            -- Shift the focused window to the next / previous workspace
            ("M-S-<R>", shiftToNext),
            ("M-S-<L>", shiftToPrev),
            ("M-S-l", shiftToNext),
            ("M-S-h", shiftToPrev),
            -- Move the focus down / up
            ("M-<D>", windows W.focusDown),
            ("M-<U>", windows W.focusUp),
            ("M-j", windows W.focusDown),
            ("M-k", windows W.focusUp),
            -- Shift the focused window to the master window
            ("M-S-m", windows W.shiftMaster),
            -- Swap the focusd window down / up
            ("M-S-j", windows W.swapDown),
            ("M-S-k", windows W.swapUp)
        ]

        -- Keymap: custom command
        `additionalKeysP`
        [
            -- M1 = Alt
            ("M1-C-l", spawn "xscreensaver-command -lock"),
            ("M-<Return>", spawn "urxvt"),
            -- you can quit dmenu by using C-c
            ("M-p", spawn "exe=`dmenu_run -l 10 -fn 'Ricty:size=16'` && exec $exe"),
            ("M-w", spawn "google-chrome-stable")
        ]

-------------------------------------------------------------------------------
-- myLayout: Handle window behavior
-------------------------------------------------------------------------------
myLayout = spacing gapWidth $
           (ResizableTall 1 (1/201) (116/201) [])
           ||| (TwoPane (1/201) (116/201))
           ||| Simplest

-------------------------------------------------------------------------------
-- myStartupHook: Start up applications
-------------------------------------------------------------------------------
myStartupHook = do
    spawnOnce "xscreensaver -no-splash"


-------------------------------------------------------------------------------
-- myManageHookFloat: new window will create in Float mode
-------------------------------------------------------------------------------
myManageHookFloat = composeAll
    [
        className =? "Gimp" --> doFloat
    ]


-------------------------------------------------------------------------------
-- myLogHook: loghock settings
-------------------------------------------------------------------------------
myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

-------------------------------------------------------------------------------
-- myWsBar: xmobar
-------------------------------------------------------------------------------
myWsBar = "xmobar $HOME/.xmonad/xmobarrc"
wsPP = xmobarPP {
                    ppOutput = putStrLn,
                    ppTitle = xmobarColor "green" "" . shorten 50
                }
