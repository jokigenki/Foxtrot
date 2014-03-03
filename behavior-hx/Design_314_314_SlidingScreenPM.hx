package scripts;

import com.stencyl.graphics.G;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;



class Design_314_314_SlidingScreenPM extends SceneScript
{          	
	
public var _TargetActor:Actor;

public var _CurrentXScreen:Float;

public var _CurrentYScreen:Float;

public var _XBorder:Float;

public var _YBorder:Float;

public var _IsSliding:Bool;

public var _CameraGizmo:Actor;

public var _TargetXScreen:Float;

public var _TargetYScreen:Float;

public var _ScreenCentreX:Float;

public var _ScreenCentreY:Float;

public var _SlideTime:Float;

public var _ScreenWidth:Float;

public var _ScreenGap:Float;

public var _ScreenHeight:Float;

public var _TestX:Float;

public var _NumberOfHorizontalScreens:Float;

public var _MagicOffset:Float;

public var _ScreenGapX:Float;

public var _NumberOfVerticalScreens:Float;

public var _TestY:Float;

public var _ScreenGapY:Float;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Target Actor", "_TargetActor");
nameMap.set("Current X Screen", "_CurrentXScreen");
_CurrentXScreen = 0.0;
nameMap.set("Current Y Screen", "_CurrentYScreen");
_CurrentYScreen = 0.0;
nameMap.set("X Border", "_XBorder");
_XBorder = 130.0;
nameMap.set("Y Border", "_YBorder");
_YBorder = 80.0;
nameMap.set("Is Sliding?", "_IsSliding");
_IsSliding = false;
nameMap.set("Camera Gizmo", "_CameraGizmo");
nameMap.set("Target X Screen", "_TargetXScreen");
_TargetXScreen = 0.0;
nameMap.set("Target Y Screen", "_TargetYScreen");
_TargetYScreen = 0.0;
nameMap.set("Screen Centre X", "_ScreenCentreX");
_ScreenCentreX = 0.0;
nameMap.set("Screen Centre Y", "_ScreenCentreY");
_ScreenCentreY = 0.0;
nameMap.set("Slide Time", "_SlideTime");
_SlideTime = 0.5;
nameMap.set("Screen Width", "_ScreenWidth");
_ScreenWidth = 640.0;
nameMap.set("Screen Gap", "_ScreenGap");
_ScreenGap = 0.0;
nameMap.set("Screen Height", "_ScreenHeight");
_ScreenHeight = 384.0;
nameMap.set("Test X", "_TestX");
_TestX = 0.0;
nameMap.set("Number Of Horizontal Screens", "_NumberOfHorizontalScreens");
_NumberOfHorizontalScreens = 1.0;
nameMap.set("Magic Offset", "_MagicOffset");
_MagicOffset = 6.0;
nameMap.set("Screen Gap X", "_ScreenGapX");
_ScreenGapX = 0.0;
nameMap.set("Number Of Vertical Screens", "_NumberOfVerticalScreens");
_NumberOfVerticalScreens = 1.0;
nameMap.set("Test Y", "_TestY");
_TestY = 0.0;
nameMap.set("Screen Gap Y", "_ScreenGapY");
_ScreenGapY = 0.0;

	}
	
	override public function init()
	{
		            _ScreenCentreX = asNumber((((_ScreenWidth / 2) - (_CameraGizmo.getWidth() / 2)) + _MagicOffset));
propertyChanged("_ScreenCentreX", _ScreenCentreX);
        _ScreenCentreY = asNumber((((_ScreenHeight / 2) - (_CameraGizmo.getHeight() / 2)) + _MagicOffset));
propertyChanged("_ScreenCentreY", _ScreenCentreY);
        if((_NumberOfHorizontalScreens > 1))
{
            _ScreenGapX = asNumber(((getSceneWidth() - _ScreenWidth) / (_NumberOfHorizontalScreens - 1)));
propertyChanged("_ScreenGapX", _ScreenGapX);
}

        if((_NumberOfVerticalScreens > 1))
{
            _ScreenGapY = asNumber(((getSceneHeight() - _ScreenHeight) / (_NumberOfVerticalScreens - 1)));
propertyChanged("_ScreenGapY", _ScreenGapY);
}

        _CurrentXScreen = asNumber(-1);
propertyChanged("_CurrentXScreen", _CurrentXScreen);
        _CurrentYScreen = asNumber(-1);
propertyChanged("_CurrentYScreen", _CurrentYScreen);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if(!(cast((scripts.Design_27_27_ActorExtrasPM._customBlock_ActorIsNull(_TargetActor)), Bool)))
{
            if(_TargetActor.getValue("Disable Behaviours On Killed PM", "_IsKilled"))
{
                return;
}

            if((_IsSliding || isTransitioning()))
{
                return;
}

            _TestX = asNumber((_ScreenCentreX + _XBorder));
propertyChanged("_TestX", _TestX);
            _TestY = asNumber((_ScreenCentreY + _YBorder));
propertyChanged("_TestY", _TestY);
            _TargetXScreen = asNumber(0);
propertyChanged("_TargetXScreen", _TargetXScreen);
            _TargetYScreen = asNumber(0);
propertyChanged("_TargetYScreen", _TargetYScreen);
            if((_NumberOfHorizontalScreens > 1))
{
                while((_TestX < getSceneWidth()))
{
                    if((_TargetActor.getX() <= _TestX))
{
                        break;
}

                    _TargetXScreen += 1;
propertyChanged("_TargetXScreen", _TargetXScreen);
                    _TestX += _ScreenGapX;
propertyChanged("_TestX", _TestX);
}

                if((_TargetXScreen >= _NumberOfHorizontalScreens))
{
                    _TargetXScreen = asNumber((_NumberOfHorizontalScreens - 1));
propertyChanged("_TargetXScreen", _TargetXScreen);
}

                else if((_TargetXScreen < 0))
{
                    _TargetXScreen = asNumber(0);
propertyChanged("_TargetXScreen", _TargetXScreen);
}

}

            if((_NumberOfVerticalScreens > 1))
{
                while((_TestY < getSceneHeight()))
{
                    if((_TargetActor.getY() <= _TestY))
{
                        break;
}

                    _TargetYScreen += 1;
propertyChanged("_TargetYScreen", _TargetYScreen);
                    _TestY += _ScreenGapY;
propertyChanged("_TestY", _TestY);
}

                if((_TargetYScreen >= _NumberOfVerticalScreens))
{
                    _TargetYScreen = asNumber((_NumberOfVerticalScreens - 1));
propertyChanged("_TargetYScreen", _TargetYScreen);
}

                else if((_TargetYScreen < 0))
{
                    _TargetYScreen = asNumber(0);
propertyChanged("_TargetYScreen", _TargetYScreen);
}

}

            if((!(_TargetXScreen == _CurrentXScreen) || !(_TargetYScreen == _CurrentYScreen)))
{
                _CurrentXScreen = asNumber(_TargetXScreen);
propertyChanged("_CurrentXScreen", _CurrentXScreen);
                _CurrentYScreen = asNumber(_TargetYScreen);
propertyChanged("_CurrentYScreen", _CurrentYScreen);
                _CameraGizmo.moveTo((_ScreenCentreX + (_ScreenGapX * _TargetXScreen)), (_ScreenCentreY + (_ScreenGapY * _TargetYScreen)), _SlideTime, Quad.easeOut);
                _IsSliding = true;
propertyChanged("_IsSliding", _IsSliding);
                runLater(1000 * _SlideTime, function(timeTask:TimedTask):Void {
                            _IsSliding = false;
propertyChanged("_IsSliding", _IsSliding);
}, null);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}