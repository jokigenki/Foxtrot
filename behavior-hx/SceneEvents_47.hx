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



class SceneEvents_47 extends SceneScript
{          	
	
 
 	public function new(dummy:Int, engine:Engine)
	{
		super(engine);
		
	}
	
	override public function init()
	{
		            setGameAttribute("Last Destination", "_Larder|Final Boss|D|A");
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit("_Larder|Final Boss|D|A");
        scripts.Design_206_206_DoorsAndInventoryExtrasPM._customBlock_UnlockExit("_Larder|Transition To Humpty|A|A");
        runLater(1000 * 8, function(timeTask:TimedTask):Void {
                    shoutToScene("_customEvent_" + "SwitchScene");
}, null);

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}