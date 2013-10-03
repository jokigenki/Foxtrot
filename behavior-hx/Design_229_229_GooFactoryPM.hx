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



class Design_229_229_GooFactoryPM extends SceneScript
{          	
	
public var _Links:Array<Dynamic>;

public var _Actor:Actor;
    

/* Params are:__side __actortype __damping __frequency __x __y */
public static function _customBlock_CreateNBlock(__side:Float, __actortype:ActorType, __damping:Float, __frequency:Float, __x:Float, __y:Float):Void
{
        var blocks = scripts.Design_229_229_GooFactoryPM._customBlock_CreateNSquare(__side, __actortype, __x, __y);
var limit = Std.int(__side -1);
var s = Std.int(__side);
for (col in 0...limit)
{
	for (row in 0...limit)
	{
		scripts.Design_229_229_GooFactoryPM._customBlock_JoinActors(
			blocks[col + (row * s)],
			blocks[col + (row * s) + 1],
			blocks[col + ((row + 1) * s)],
			blocks[col + ((row + 1) * s) + 1],
			__damping,
			__frequency);
			
	}
}
}
    

/* Params are:__actor1 __actor2 __actor3 __actor4 __damping __frequency */
public static function _customBlock_JoinActors(__actor1:Actor, __actor2:Actor, __actor3:Actor, __actor4:Actor, __damping:Float, __frequency:Float):Void
{
        var blocks:Array<Actor> = [__actor1, __actor2, __actor3, __actor4];
var links:Array<Array<Int>> = [[1,2,3],[2,3],[3]];
for (index0 in 0...links.length)
{
	var a1 = blocks[index0];
	if (!a1.hasBehavior("Goo Particle PM")) continue;
	var blockLinks = links[index0];
	var l = Std.int(blockLinks.length);
	for (index1 in 0...l)
	{
		var blockIndex = blockLinks[index1];
		var a2 = blocks[blockIndex];
		if (!a2.hasBehavior("Goo Particle PM")) continue;
		if (!a1.say("Goo Particle PM", "IsLinkedTo", [a2]))
		{
			scripts.Design_222_222_JointsExtras._customBlock_CreateDistanceJointWithParams(a1,a1.getX(),a1.getY(),a2,a2.getX(),a2.getY(),__damping,__frequency);
			a1.say("Goo Particle PM", "AddLink", [a2]);
			a2.say("Goo Particle PM", "AddLink", [a1]);
		}
	}
}
}
    

/* Params are:__side __actortype __x __y */
public static function _customBlock_CreateNSquare(__side:Float, __actortype:ActorType, __x:Float, __y:Float):Array<Dynamic>
{
        var blockSize = 0.0;
var last = null;
var xpos = __x;
var ypos = __y;
var blocks = new Array<Actor>();
for (row in 0...Std.int(__side))
{
	for (col in 0...Std.int(__side))
	{
		last = Engine.engine.getRecycledActorOfType(__actortype, xpos, ypos, Script.FRONT);		
		Script.lastCreatedActor = last;
		if (col == 0 || col == __side - 1 || row == 0 || row == __side - 1)
		{
			last.setAnimation("Edge");
		}
		if (blockSize == 0)
		{
			blockSize = last.getWidth();
		}
		xpos += blockSize - 2;
		blocks.push(last);
	}

	xpos = __x;
	ypos += blockSize - 2;
}

return blocks;
}
    

/* Params are:__actortype __damping __frequency __x __y */
public static function _customBlock_CreateLine(__actortype:ActorType, __damping:Float, __frequency:Float, __x:Float, __y:Float):Void
{
        var blocks = scripts.Design_229_229_GooFactoryPM._customBlock_CreateNSquare(4,__actortype, __x, __y);
var links = [5,9,13,12,8,4,0,1,2,3,7,11,15,14,10,16];
var last = null;
for (i in 0...links.length)
{
	if (last == null)
	{
		last = blocks[links[i]];
	} else {
		var next = blocks[links[i]];
		scripts.Design_222_222_JointsExtras._customBlock_CreateDistanceJointWithParams(last,last.getX(),last.getY(),next,next.getX(),next.getY(),__damping,__frequency);
		last.say("Goo Particle PM", "AddLink", [next]);
		next.say("Goo Particle PM", "AddLink", [last]);
		last = next;
	}
}

}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		nameMap.set("Links", "_Links");
_Links = [];
nameMap.set("Actor", "_Actor");

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}