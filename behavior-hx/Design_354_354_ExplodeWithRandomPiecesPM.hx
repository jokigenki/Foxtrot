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



class Design_354_354_ExplodeWithRandomPiecesPM extends ActorScript
{          	
	
public var _PieceNumber:Float;

public var _NumberOfPieces:Float;

public var _ExplodeActorType:ActorType;

public var _HighestAnimationNumber:Float;

public var _SetPiecesStart:Float;

public var _SetPiecesEnd:Float;

public var _RandomPiecesStart:Float;

public var _RandomPiecesEnd:Float;

public var _TotalNumberOfPieces:Float;

public var _ShakeScreen:Bool;
    public function _customEvent_Killed():Void
{
        for(index0 in 0...Std.int(_NumberOfPieces))
{
            createRecycledActor(_ExplodeActorType, actor.getX(), actor.getY(), Script.FRONT);
            _PieceNumber = asNumber(randomInt(Math.floor(1), Math.floor(_HighestAnimationNumber)));
propertyChanged("_PieceNumber", _PieceNumber);
            getLastCreatedActor().setAnimation("" + ("" + (("" + "p") + ("" + _PieceNumber))));
}

        recycleActor(actor);
        if(_ShakeScreen)
{
            startShakingScreen(1 / 100, 1);
}

}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Piece Number", "_PieceNumber");
_PieceNumber = 0.0;
nameMap.set("Number Of Pieces", "_NumberOfPieces");
_NumberOfPieces = 0.0;
nameMap.set("Explode Actor Type", "_ExplodeActorType");
nameMap.set("Highest Animation Number", "_HighestAnimationNumber");
_HighestAnimationNumber = 0.0;
nameMap.set("Set Pieces Start", "_SetPiecesStart");
_SetPiecesStart = 0.0;
nameMap.set("Set Pieces End", "_SetPiecesEnd");
_SetPiecesEnd = 0.0;
nameMap.set("Random Pieces Start", "_RandomPiecesStart");
_RandomPiecesStart = 0.0;
nameMap.set("Random Pieces End", "_RandomPiecesEnd");
_RandomPiecesEnd = 0.0;
nameMap.set("Total Number Of Pieces", "_TotalNumberOfPieces");
_TotalNumberOfPieces = 0.0;
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