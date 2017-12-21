package app.view.mediators;
import app.controller.signals.ApplicationMediatorMessageSignal;
import consts.Defaults;
import flash.display.Graphics;
import mmvc.impl.Mediator;
import openfl.display.Sprite;

class ApplicationMediator extends Mediator<Application>
{
    public function new() { super(); }

    @inject public var messageSignal:ApplicationMediatorMessageSignal;

    override public function onRegister()
    {
        super.onRegister();

        trace("-> onRegister: view = " + view);
        trace("-> onRegister: interestsSignal = " + messageSignal);

        messageSignal.add(HandleMessageSignal);

        var displayObject:Sprite = view;
        if(displayObject != null) {
            var g:Graphics = displayObject.graphics;
            g.beginFill(0xffcc00);
            g.drawRect(0,0,
                displayObject.width,
                displayObject.height * Defaults.COMPONENT__FACTOR__HEADER
            );
            g.endFill();
        }
    }

    private function HandleMessageSignal(type:String, ?data:Dynamic):Void {
        switch(type) {
            case ApplicationMediatorMessageSignal.SOME_MESSAGE:

        }
    }

    /**
	@see mmvc.impl.Mediator
	*/
    override public function onRemove():Void
    {
        super.onRemove();
    }
}
