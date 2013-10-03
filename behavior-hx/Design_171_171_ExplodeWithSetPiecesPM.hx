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



class Design_171_171_ExplodeWithSetPiecesPM extends ActorScript
{          	
	
public var _ExplodeActorType:ActorType;

public var _NumberOfPieces:Float;

public var _PieceNumber:Float;
    public function _customEvent_Killed():Void
{
        trace("" + "KILLED");
        for(index0 in 0...Std.int(_NumberOfPieces))
{
            createRecycledActor(_ExplodeActorType, actor.getX(), actor.getY(), Script.FRONT);
            _PieceNumber = asNumber(index0);
propertyChanged("_PieceNumber", _PieceNumber);
            if((_PieceNumber > getLastCreatedActor().getNumFrames()))
{
                _PieceNumber -= getLastCreatedActor().getNumFrames();
propertyChanged("_PieceNumber", _PieceNumber);
}

            getLastCreatedActor().setAnimation("" + ("" + (("" + "p") + ("" + _PieceNumber))));
}

        recycleActor(actor);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Explode Actor Type", "_ExplodeActorType");
nameMap.set("Number Of Pieces", "_NumberOfPieces");
_NumberOfPieces = 0.0;
nameMap.set("Piece Number", "_PieceNumber");
_PieceNumber = 0.0;
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}