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

            import box2D.common.math.B2Vec2;
import box2D.dynamics.joints.B2Joint;
import box2D.dynamics.joints.B2RevoluteJoint;
import box2D.dynamics.joints.B2RevoluteJointDef;
import box2D.dynamics.joints.B2DistanceJoint;
import box2D.dynamics.joints.B2DistanceJointDef;


class Design_222_222_JointsExtras extends SceneScript
{          	
	    

/* Params are:__actor1 __x1 __y1 __actor2 __x2 __y2 */
public static function _customBlock_CreateRevoluteJoint(__actor1:Actor, __x1:Float, __y1:Float, __actor2:Actor, __x2:Float, __y2:Float):Void
{
        __x1 = Engine.toPhysicalUnits(__x1);
__y1 = Engine.toPhysicalUnits(__y1);
__x2 = Engine.toPhysicalUnits(__x2);
__y2 = Engine.toPhysicalUnits(__y2);
var jointDef:B2RevoluteJointDef = new B2RevoluteJointDef();
jointDef.initialize(__actor1.getBody(), __actor2.getBody(), new B2Vec2(__x1, __y1));
jointDef.localAnchorA.set(__x1,__y1);
jointDef.localAnchorB.set(__x2,__y2);
Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
}
    

/* Params are:__actor1 __x1 __y1 __actor2 __x2 __y2 __upper __lower */
public static function _customBlock_CreateRevoluteJointWithParams(__actor1:Actor, __x1:Float, __y1:Float, __actor2:Actor, __x2:Float, __y2:Float, __upper:Float, __lower:Float):Void
{
        scripts.Design_222_222_JointsExtras._customBlock_CreateRevoluteJoint(__actor1,__x1,__y1,__actor2,__x2,__y2);
        var j = cast(Script.lastCreatedJoint, B2RevoluteJoint);
j.enableLimit(true);
j.setLimits(__lower, __upper);
}
    

/* Params are:__actor1 __x1 __y1 __actor2 __x2 __y2 */
public static function _customBlock_CreateDistanceJoint(__actor1:Actor, __x1:Float, __y1:Float, __actor2:Actor, __x2:Float, __y2:Float):Void
{
        __x1 = Engine.toPhysicalUnits(__x1);
__y1 = Engine.toPhysicalUnits(__y1);
__x2 = Engine.toPhysicalUnits(__x2);
__y2 = Engine.toPhysicalUnits(__y2);
var jointDef:B2DistanceJointDef = new B2DistanceJointDef();
jointDef.initialize(__actor1.getBody(), __actor2.getBody(), new B2Vec2(__x1, __y1), new B2Vec2(__x2, __y2));
Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
}
    

/* Params are:__actor1 __x1 __y1 __actor2 __x2 __y2 __damping __frequency */
public static function _customBlock_CreateDistanceJointWithParams(__actor1:Actor, __x1:Float, __y1:Float, __actor2:Actor, __x2:Float, __y2:Float, __damping:Float, __frequency:Float):Void
{
        scripts.Design_222_222_JointsExtras._customBlock_CreateDistanceJoint(__actor1,__x1,__y1,__actor2,__x2,__y2);
        var j = cast(Script.lastCreatedJoint, B2DistanceJoint);
j.setDampingRatio(__damping);
j.setFrequency(__frequency);
}
    

/* Params are:__joint */
public static function _customBlock_DestroyJoint(__joint:B2Joint):Void
{
        Engine.engine.world.destroyJoint(__joint);
}
    

/* Params are:*/
public static function _customBlock_lastJoint():Dynamic
{
        return Script.lastCreatedJoint;
}
    

/* Params are:__argument __value __joint */
public static function _customBlock_setLimits(__argument:String, __value:Dynamic, __joint:Dynamic):Void
{
        if (Reflect.hasField(__joint, "m_" + __argument))
{
    Reflect.setField(__joint, "m_" + __argument, __value);
}
}

 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		
	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}