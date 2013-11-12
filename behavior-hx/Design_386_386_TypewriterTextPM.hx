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
import nme.events.Event;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Cubic;
import com.eclecticdesignstudio.motion.easing.Elastic;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quad;
import com.eclecticdesignstudio.motion.easing.Quart;
import com.eclecticdesignstudio.motion.easing.Quint;
import com.eclecticdesignstudio.motion.easing.Sine;



class Design_386_386_TypewriterTextPM extends SceneScript
{          	
	
public var _CancelDrawing:Bool;

public var _UseFont:Font;

public var _XPos:Float;

public var _YPos:Float;

public var _CurrentText:String;

public var _DrawCharacterEveryNSeconds:Float;

public var _TextToDraw:String;

public var _CurrentIndex:Float;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Cancel Drawing?", "_CancelDrawing");
_CancelDrawing = false;
nameMap.set("Use Font", "_UseFont");
nameMap.set("X Pos", "_XPos");
_XPos = 0;
nameMap.set("Y Pos", "_YPos");
_YPos = 0;
nameMap.set("Current Text", "_CurrentText");
_CurrentText = "";
nameMap.set("Draw Character Every N Seconds", "_DrawCharacterEveryNSeconds");
_DrawCharacterEveryNSeconds = 0.1;
nameMap.set("Text To Draw", "_TextToDraw");
_TextToDraw = "";
nameMap.set("Current Index", "_CurrentIndex");
_CurrentIndex = 0;

	}
	
	override public function init()
	{
		            runPeriodically(1000 * _DrawCharacterEveryNSeconds, function(timeTask:TimedTask):Void {
                    if(_CancelDrawing)
{
                        timeTask.repeats = false;
return;
}

                    else
{
                        _CurrentIndex += 1;
propertyChanged("_CurrentIndex", _CurrentIndex);
                        if((_CurrentIndex > ("" + _TextToDraw).length))
{
                            timeTask.repeats = false;
return;
}

                        else
{
                            _CurrentText = ("" + _TextToDraw).substring(Std.int(0), Std.int(_CurrentIndex));
propertyChanged("_CurrentText", _CurrentText);
}

}

}, null);
    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        if((hasValue(_UseFont) != false))
{
            g.setFont(_UseFont);
}

        g.drawString("" + _CurrentText, _XPos, _YPos);
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}