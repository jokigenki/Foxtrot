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



class Design_171_171_ExplodeWithSetPiecesPM extends ActorScript
{          	
	
public var _ShrapnelActorType:ActorType;

public var _ExplosionActorType:ActorType;

public var _NumberOfPieces:Float;

public var _PieceNumber:Float;

public var _ShakeScreen:Bool;
    public function _customEvent_Killed():Void
{
        if((hasValue(_ExplosionActorType) != false))
{
            createRecycledActor(_ExplosionActorType, actor.getX(), actor.getY(), Script.FRONT);
}

        for(index0 in 0...Std.int(_NumberOfPieces))
{
            createRecycledActor(_ShrapnelActorType, actor.getX(), actor.getY(), Script.FRONT);
            _PieceNumber = asNumber(index0);
propertyChanged("_PieceNumber", _PieceNumber);
            getLastCreatedActor().setAnimation("" + ("" + (("" + "p") + ("" + _PieceNumber))));
}

        recycleActor(actor);
        if(_ShakeScreen)
{
            startShakingScreen(0.5 / 100, 0.5);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Shrapnel Actor Type", "_ShrapnelActorType");
nameMap.set("Explosion Actor Type", "_ExplosionActorType");
nameMap.set("Number Of Pieces", "_NumberOfPieces");
_NumberOfPieces = 0.0;
nameMap.set("Piece Number", "_PieceNumber");
_PieceNumber = 0.0;
nameMap.set("Shake Screen", "_ShakeScreen");
_ShakeScreen = false;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}