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



class Design_20_20_DisplayPlayerPositionPM extends SceneScript
{          	
	
public var _XPosition:Float;

public var _YPosition:Float;

public var _CurrentY:Float;

public var _LineHeight:Float;

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("X Position", "_XPosition");
_XPosition = 0.0;
nameMap.set("Y Position", "_YPosition");
_YPosition = 0.0;
nameMap.set("Current Y", "_CurrentY");
_CurrentY = 0.0;
nameMap.set("Line Height", "_LineHeight");
_LineHeight = 0.0;

	}
	
	override public function init()
	{
		    addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _CurrentY = asNumber(_YPosition);
propertyChanged("_CurrentY", _CurrentY);
        for(actorInGroup in getActorGroup(0).list)
{
if(actorInGroup != null && !actorInGroup.dead && !actorInGroup.recycled){
            g.setFont(getFont(575));
            g.drawString("" + (("" + actorInGroup.getX()) + ("" + (("" + ",") + ("" + actorInGroup.getY())))), _XPosition, _CurrentY);
            _CurrentY = asNumber((_CurrentY + _LineHeight));
propertyChanged("_CurrentY", _CurrentY);
}
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}