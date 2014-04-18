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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_56_56_PivotPM extends ActorScript
{          	
	
public var _IsActive:Bool;

public var _LiftType:ActorType;

public var _Lifts:Array<Dynamic>;

public var _NumberOfLifts:Float;

public var _LiftAngleGap:Float;

public var _Radius:Float;

public var _AngleOffset:Float;

public var _Lift:Actor;

public var _XPos:Float;

public var _YPos:Float;

public var _Count:Float;

public var _Angle:Float;

public var _LiftIndex:Float;

public var _Steps:Float;

public var _PositionsX:Array<Dynamic>;

public var _LiftIndices:Array<Dynamic>;

public var _LiftOffsetX:Float;

public var _PositionsY:Array<Dynamic>;

public var _Direction:Float;

public var _LiftOffsetY:Float;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Is Active?", "_IsActive");
_IsActive = false;
nameMap.set("Lift Type", "_LiftType");
_LiftType = getActorType(616);
nameMap.set("Lifts", "_Lifts");
_Lifts = [];
nameMap.set("Number Of Lifts", "_NumberOfLifts");
_NumberOfLifts = 4.0;
nameMap.set("Lift Angle Gap", "_LiftAngleGap");
_LiftAngleGap = 0.0;
nameMap.set("Radius", "_Radius");
_Radius = 0.0;
nameMap.set("Angle Offset", "_AngleOffset");
_AngleOffset = 0.0;
nameMap.set("Lift", "_Lift");
nameMap.set("X Pos", "_XPos");
_XPos = 0.0;
nameMap.set("Y Pos", "_YPos");
_YPos = 0.0;
nameMap.set("Count", "_Count");
_Count = 0.0;
nameMap.set("Angle", "_Angle");
_Angle = 0.0;
nameMap.set("Lift Index", "_LiftIndex");
_LiftIndex = 0.0;
nameMap.set("Actor", "actor");
nameMap.set("Steps", "_Steps");
_Steps = 360.0;
nameMap.set("Positions X", "_PositionsX");
_PositionsX = [];
nameMap.set("Lift Indices", "_LiftIndices");
_LiftIndices = [];
nameMap.set("Lift Offset X", "_LiftOffsetX");
_LiftOffsetX = 0.0;
nameMap.set("Positions Y", "_PositionsY");
_PositionsY = [];
nameMap.set("Direction", "_Direction");
_Direction = 1.0;
nameMap.set("Lift Offset Y", "_LiftOffsetY");
_LiftOffsetY = 0.0;

	}
	
	override public function init()
	{
		            actor.disableActorDrawing();
        _Lifts = new Array<Dynamic>();
propertyChanged("_Lifts", _Lifts);
        _LiftIndices = new Array<Dynamic>();
propertyChanged("_LiftIndices", _LiftIndices);
        _LiftAngleGap = asNumber(Math.round((_Steps / _NumberOfLifts)));
propertyChanged("_LiftAngleGap", _LiftAngleGap);
        for(index0 in 0...Std.int(_Steps))
{
            _Angle = asNumber(Utils.RAD * ((index0 * (360 / _Steps))));
propertyChanged("_Angle", _Angle);
            _PositionsX.push((actor.getXCenter() + (Math.sin(_Angle) * _Radius)));
            _PositionsY.push((actor.getYCenter() + (Math.cos(_Angle) * _Radius)));
}

        for(index0 in 0...Std.int(_NumberOfLifts))
{
            _LiftIndex = asNumber((((_LiftAngleGap * index0) + _AngleOffset) * (_Steps / 360)));
propertyChanged("_LiftIndex", _LiftIndex);
            _XPos = asNumber(_PositionsX[Std.int(_LiftIndex)]);
propertyChanged("_XPos", _XPos);
            _YPos = asNumber(_PositionsY[Std.int(_LiftIndex)]);
propertyChanged("_YPos", _YPos);
            createRecycledActor(_LiftType, (_XPos - _LiftOffsetX), (_YPos - _LiftOffsetY), Script.FRONT);
            _Lift = getLastCreatedActor();
propertyChanged("_Lift", _Lift);
            if(((_LiftOffsetX == 0) && (_LiftOffsetY == 0)))
{
                _LiftOffsetX = asNumber((_Lift.getWidth()/2));
propertyChanged("_LiftOffsetX", _LiftOffsetX);
                _LiftOffsetY = asNumber((_Lift.getHeight()/2));
propertyChanged("_LiftOffsetY", _LiftOffsetY);
                _Lift.setX((_Lift.getX() - _LiftOffsetX));
                _Lift.setY((_Lift.getY() - _LiftOffsetY));
}

            _Lift.moveToLayer(actor.getLayerID());
            _Lifts.push(_Lift);
            _LiftIndices.push(_LiftIndex);
}

        _Count = asNumber(0);
propertyChanged("_Count", _Count);
        for(item in cast(_Lifts, Array<Dynamic>))
{
            item.setValue("Precalc Windmill Arm PM", "_Radius", _Radius);
            item.setValue("Precalc Windmill Arm PM", "_Pivot", actor);
            item.setValue("Precalc Windmill Arm PM", "_TargetX", item.getX());
            item.setValue("Precalc Windmill Arm PM", "_TargetX", item.getY());
            _Count += 1;
propertyChanged("_Count", _Count);
}

    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        _Count = asNumber(0);
propertyChanged("_Count", _Count);
        for(item in cast(_LiftIndices, Array<Dynamic>))
{
            _LiftIndex = asNumber(item);
propertyChanged("_LiftIndex", _LiftIndex);
            _LiftIndex += _Direction;
propertyChanged("_LiftIndex", _LiftIndex);
            if((_LiftIndex >= _Steps))
{
                _LiftIndex = asNumber((_LiftIndex - _Steps));
propertyChanged("_LiftIndex", _LiftIndex);
}

            else if((_LiftIndex < 0))
{
                _LiftIndex = asNumber((_LiftIndex + _Steps));
propertyChanged("_LiftIndex", _LiftIndex);
}

            _Lift = _Lifts[Std.int(_Count)];
propertyChanged("_Lift", _Lift);
            _LiftIndices[Std.int(_Count)] = _LiftIndex;
            _Lift.setValue("Precalc Windmill Arm PM", "_TargetX", _PositionsX[Std.int(_LiftIndex)]);
            _Lift.setValue("Precalc Windmill Arm PM", "_TargetY", _PositionsY[Std.int(_LiftIndex)]);
            _Count += 1;
propertyChanged("_Count", _Count);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}